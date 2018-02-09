
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Genblast < Formula
  desc 'Splice aware aligner for transcript models'
  homepage 'http://genome.sfu.ca/genblast/'
  url 'http://genome.sfu.ca/genblast/latest/genblast_v139.zip'
  version '1.39'
  sha256 '7934ef446d9b2f8fa80a6b53a2f001e2531edf2a2749545390e739ffa878e8d4'
  revision 2

  patch :DATA

  def install
    system 'make', 'all'
    bin.install 'genblast'
    bin.install 'alignscore.txt'
    File.open((etc+'genblast.bash'), 'w') { |file| file.write("export GBLAST_PATH=#{HOMEBREW_PREFIX}/bin\n") }
  end

  def caveats; <<~EOS
    To run genblast you need to specify set GBLAST_PATH which points
    to the directory where your blast format binary and blast binaries
    are, otherwise it will use the current directory.

    You also need to run genblast from it's directory as it needs the
    alignscore.txt file.

    You could source #{etc}/genblast.bash which contains:
     export GBLAST_PATH=#{HOMEBREW_PREFIX}/bin

    If you use NCBI blast and create you own blast indexes you need to use
     -parse_seqids when making the indexes
    and you might want to have a masking library to speed up the search:
     https://www.ncbi.nlm.nih.gov/books/NBK279681/#cookbook.Create_BLAST_database_with_the
    EOS
  end

  test do
    system "#{bin}/genblast"
  end
end

__END__
diff -aur genblast_v139/data_manager.cpp genblast_v139_mod/data_manager.cpp
--- genblast_v139/data_manager.cpp	2012-02-23 23:31:00.000000000 +0000
+++ genblast_v139_mod/data_manager.cpp	2017-02-23 10:33:58.958044000 +0000
@@ -2808,10 +2808,23 @@
 
 
 
+	string query_query = "Query";
+  bool prog_wublast = false;
+  bool is_first_line = false;
+	if (alignFile.find("wublast") != string::npos)
+	{
+		query_query += ":";
+    prog_wublast = true;
+	}
+  else
+  {
+    query_query += " ";
+  }
 	if (!alignFile_Open)
 
 	{
 
+    is_first_line = true;
 		alignFile_is.open(alignFile.c_str());
 
 		if (!alignFile_is.is_open())
@@ -2855,7 +2868,7 @@
 
 		//if (cur_align_start && line.find("TBLASTN") == 0) //signal of next batch of HSPs
 
-		if (line.find("TBLASTN") == 0) //signal of next batch of HSPs
+		if (prog_wublast && line.find("TBLASTN") == 0) //signal of next batch of HSPs
 
 		{
 
@@ -2864,10 +2877,18 @@
 			break;
 
 		}
+    else
+    if (!prog_wublast && line.find("Query=") == 0)
+    {
+      if (is_first_line)
+        is_first_line = false;
+      else
+        break;
+    }
 
 
 
-		int pos = line.find("Query:");
+		int pos = line.find(query_query);
 
 		if (pos == 0) //header line, starts with '>'
 
@@ -2947,7 +2968,7 @@
 				getline(alignFile_is, line);
 				remove_trailing_cr_lf(line);
 
-				pos = line.find("Query:");
+				pos = line.find(query_query);
 
 				}
 
@@ -2976,7 +2997,7 @@
 					getline(alignFile_is, line); //next possible query line
 					remove_trailing_cr_lf(line);
 
-					pos = line.find("Query:");
+					pos = line.find(query_query);
 
 				}
 
@@ -3035,11 +3056,16 @@
 //	cout << "get blast alignments" << "\n";
 
 
+  bool prog_wublast = false;
+  bool is_first_line = false;
+	if (alignFile.find("wublast") != string::npos)
+    prog_wublast = true;
 
 	if (!alignFile_Open)
 
 	{
 
+    is_first_line = true;
 		alignFile_is.open(alignFile.c_str());
 
 		if (!alignFile_is.is_open())
@@ -3079,7 +3105,7 @@
 
 		//if (cur_align_start && line.find("TBLASTN") == 0) //signal of next batch of HSPs
 
-		if (line.find("TBLASTN") == 0) //signal of next batch of HSPs
+		if (prog_wublast && line.find("TBLASTN") == 0) //signal of next batch of HSPs
 
 		{
 
@@ -3088,6 +3114,14 @@
 			break;
 
 		}
+    else
+    if (!prog_wublast && line.find("Query=") == 0)
+    {
+      if (is_first_line)
+        is_first_line = false;
+      else
+        break;
+    }
 
 
 
diff -aur genblast_v139/data_manager.h genblast_v139_mod/data_manager.h
--- genblast_v139/data_manager.h	2012-02-23 23:31:12.000000000 +0000
+++ genblast_v139_mod/data_manager.h	2017-02-23 10:33:58.963040000 +0000
@@ -14,7 +14,7 @@
 //#define VERBOSE
 
 #define COMMAND_WITH_BLAST //run it in command line mode (with blast integrated)
-#define PERFORMANCE //record performance numbers in perform.txt
+//#define PERFORMANCE //record performance numbers in perform.txt
 
 //#define TIMING
 
diff -aur genblast_v139/gBlast.cpp genblast_v139_mod/gBlast.cpp
--- genblast_v139/gBlast.cpp	2012-02-23 23:33:20.000000000 +0000
+++ genblast_v139_mod/gBlast.cpp	2017-05-05 14:12:32.443621000 +0100
@@ -44,7 +44,7 @@
 
 void help()
 {
-	cout << "\ngenBlastG release v1.0.138\n";
+	cout << "\ngenBlastG release v1.0.139-ensembl-patch-2\n";
 	cout << "\nSYNOPSIS:\n";
 	cout << "Given a list of query protein sequences and a target database that \n";
 
@@ -83,7 +83,7 @@
 	cout << "(e.g. for 50%\n\t\tgene coverage, use \"0.5\"), optional\n";
 
 	cout << "\t-s\tparameter for genBlast: minimum score of the HSP group in \n\t\tthe output, a real number, optional\n";
-	cout << "\t-scodon\tThe number of base pairs to search for start codon within the region of HSP \
+	cout << "\t-scodon\tThe number of base pairs to search for start codon within the region of HSP\n\t \
 		group (inside the first HSP). If not specified, default is 15.\n";
 
 	//for genblastg:
@@ -118,6 +118,8 @@
 	cout << "\t-id\tThe GFF output user_id\n";
 	cout << "\t-b\tTurn on the verbose on-screen output\n";
 	cout << "\t-pid\tturn on final alignment PID computation (global alignment between predicted gene and query) in output.\n";
+	cout << "\t-softmask\tWith this option NCBI blast will create a masking library, you need to use it when blasting against a whole genome\n";
+	cout << "\t-maskid\tSet the mask id for NCBI blast if you have created your own index. Default is 100\n";
 
 	cout << "\nExample:\n";
 
@@ -126,6 +128,7 @@
 	cout << "-o myoutput\n";
 
 	cout << "\n(Rong She\tLast updated: Nov. 2010)\n\n";
+	cout << "\tLast updated: May 2017)\n\n";
 	//[-i min-intron-length] [-x min-internal-exon-length] 
 	//[-n max-num-splice-sites] 
 	//[-v splice-region-version-s1ors2] [-h s2-tree-data-shift] [-j s2-tree-cls-threshold] 
@@ -397,13 +400,14 @@
 	//[-gff] [-cdna] [-pro]
 
 	string queryList="", targetDb="";
-	string eValue="1e-2", gapSet="F", filterSet="F", proteinSeq = "T", tmpStr, outStr; //stuff we pass to tblastn
+	string eValue="1e-2", gapSet="F", filterSet="F", proteinSeq = "T", tmpStr, outStr, moreOpt; //stuff we pass to tblastn
         int word_length=0;
 	char *stopstring;
 	int error;
 	int op=-1;
 	int a=1;
 	bool SKIP = false;
+  bool SOFTMASK = false;
 	string skip_gene;
 	//bool phase1_only = false;
 //	int genewise_gene_index;
@@ -603,6 +607,9 @@
 		if (strcmp(argv[a], "-o")==0)
 			op = getOpt(argc, argv, a, outStr); //output filename if specified
 		else
+		if (strcmp(argv[a], "-bo")==0)
+			op = getOpt(argc, argv, a, moreOpt); //output filename if specified
+		else
 		if (strcmp(argv[a], "-i")==0)
 			op = checkOpt_Int(argc, argv, a, MIN_INTRON_LEN, 1, 300);
 		else
@@ -716,6 +723,15 @@
 			op = getOpt(argc, argv, a, skip_gene);
 		}
 		else
+		if (strcmp(argv[a], "-softmask")==0)
+    {
+      SOFTMASK = true;
+			op = 0;
+    }
+		else
+		if (strcmp(argv[a], "-maskid")==0)
+			op = checkOpt_Int(argc, argv, a, BLAST_MASK_ID, 0, INT_MAX);
+		else
 		{
 			cout << "Cannot recognize option " << argv[a] << "\n";
 			op = -1;
@@ -737,10 +753,11 @@
 		return -1;
 	}
 
-	char command[256];
+	char command[1024];
 
 	//now ask wu-blastall to run
 	string pathStr;
+  int res;
 	char* gb_path = getenv("GBLAST_PATH");
 	if (gb_path == NULL)
 		pathStr = ".";
@@ -771,9 +788,34 @@
 		else
 		{
 			cout << "formatting target database for blast..." << "\n";
-			sprintf(command, "%s/formatdb -i %s -p F", pathStr.c_str(), targetDb.c_str());
-		}
-		system(command);
+      if (SOFTMASK)
+      {
+        sprintf(command, "%s/convert2blastmask -in %s -parse_seqids -masking_algorithm repeatmasker -masking_options \"repeatmasker, default\" -outfmt maskinfo_asn1_bin -out %s.asnb", pathStr.c_str(), targetDb.c_str(), targetDb.c_str());
+        res = system(command);
+        if (res == -1) {
+          fprintf(stderr, "Failed to run command %s\n", command);
+          exit(1);
+        }
+        else if (res > 0) {
+          fprintf(stderr, "Command %s died with error %d\n", command, res);
+          exit(res);
+        }
+        sprintf(command, "%s/makeblastdb -parse_seqids -in %s -dbtype nucl -mask_data %s.asnb", pathStr.c_str(), targetDb.c_str(), targetDb.c_str());
+      }
+      else
+      {
+        sprintf(command, "%s/makeblastdb -parse_seqids -in %s -dbtype nucl", pathStr.c_str(), targetDb.c_str());
+      }
+		}
+		res = system(command);
+    if (res == -1) {
+      fprintf(stderr, "Failed to run command %s\n", command);
+      exit(1);
+    }
+    else if (res > 0) {
+      fprintf(stderr, "Command %s died with error %d\n", command, res);
+      exit(res);
+    }
 	}
 	if (!hasFile(xndfile.c_str()) || !hasFile (xnsfile.c_str()) || !hasFile (xntfile.c_str())) //test if xdformat is successful
 	{
@@ -783,6 +825,7 @@
 
 	char wuFilename[256];
 	char reportFilename[256];
+  char masking[64];
 
 	string targetDbFilename;
 	int tgt_pos = targetDb.find_last_of("/\\");
@@ -793,6 +836,7 @@
 		sprintf(wuFilename, "%s_%s.wublast", queryList.c_str(), targetDbFilename.c_str());
 	else
 		sprintf(wuFilename, "%s_%s.blast", queryList.c_str(), targetDbFilename.c_str());
+	string filterStr = "-dust";
 	if (hasFile(wuFilename))
 		cout << "blast already done, move forward" << "\n";
 	else
@@ -813,14 +857,48 @@
 		{
 			cout << "running blast..." << "\n";
 			if (proteinSeq.compare("T") == 0)
+			{
 				progStr = "tblastn";
+				filterStr = "-seg";
+			}
 			else
+			{
 				progStr = "blastn";
-			sprintf(command, "%s/blastall -p %s -d %s -i %s -e %s -F %s -g %s -W %d -o %s", pathStr.c_str(), progStr.c_str(), 
-				targetDb.c_str(), queryList.c_str(), 
-				eValue.c_str(), filterSet.c_str(), gapSet.c_str(), word_length, wuFilename);
-		}
-		system(command);
+				filterStr = "-dust";
+			}
+      if (SOFTMASK)
+      {
+        sprintf(masking, " -db_soft_mask %d", BLAST_MASK_ID);
+      }
+      else
+      {
+        sprintf(masking, "");
+      }
+			if (word_length == 0)
+			{
+				//sprintf(command, "%s/%s -db %s -query %s -db_soft_mask %d -gapopen 11 -gapextend 2 -evalue %s %s %s %s -out %s %s", pathStr.c_str(), progStr.c_str(),
+				sprintf(command, "%s/%s -db %s -query %s %s -evalue %s %s %s %s -out %s %s", pathStr.c_str(), progStr.c_str(),
+					targetDb.c_str(), queryList.c_str(), masking, eValue.c_str(), filterStr.c_str(),
+					filterSet.compare("F") ? "yes" : "no", gapSet.compare("F") ? "" : "-ungapped -comp_based_stats F", wuFilename, moreOpt.c_str());
+			}
+			else
+			{
+				//sprintf(command, "%s/%s -db %s -query %s -db_soft_mask %d -gapopen 11 -gapextend 2 -evalue %s %s %s %s -word_size %d -out %s %s", pathStr.c_str(), progStr.c_str(),
+				sprintf(command, "%s/%s -db %s -query %s %s -evalue %s %s %s %s -word_size %d -out %s %s", pathStr.c_str(), progStr.c_str(),
+					targetDb.c_str(), queryList.c_str(), masking, eValue.c_str(), filterStr.c_str(),
+					filterSet.compare("F") ? "yes" : "no", gapSet.compare("F") ? "" : "-ungapped -comp_based_stats F", word_length, wuFilename, moreOpt.c_str());
+			}
+		}
+    fprintf(stdout, "Command to run\n %s\n", command);
+		res = system(command);
+    if (res == -1) {
+      fprintf(stderr, "Failed to run command %s\n", command);
+      exit(1);
+    }
+    else if (res > 0) {
+      fprintf(stderr, "Command %s died with error %d\n", command, res);
+      exit(res);
+    }
 	}
 
 	sprintf(reportFilename, "%s.report", wuFilename);
@@ -854,6 +932,12 @@
 	int cur_pos, cur_space_pos, hsp_count=1, query_len, chr_start, chr_end, query_start, query_end, exit_code;
 	bool strandness, lastEnded = true, wublast_ok = true, cur_output = true;
 	string cur_query_name;
+	string query_query = "Query";
+	string query_subject = "Sbjct";
+	if (prog_is_wublast) {
+		query_query += ": ";
+		query_subject += ":";
+	}
 	while (!wuFile.eof() && wublast_ok)
 	{
 		getline(wuFile, wuline);
@@ -905,20 +989,36 @@
 			{
 				getline(wuFile, wuline);
 				remove_trailing_cr_lf(wuline);
-				if ((cur_pos = wuline.find("(")) != string::npos && (cur_space_pos = wuline.find(" letters")) != string::npos)
+				if (prog_is_wublast)
 				{
-					if (cur_space_pos > cur_pos)
+					if ((cur_pos = wuline.find("(")) != string::npos && (cur_space_pos = wuline.find(" letters")) != string::npos)
 					{
-						error = errno;
-						query_len = strtol(wuline.substr(cur_pos+1, cur_space_pos - cur_pos - 1).c_str(), &stopstring, 10);
-						if (errno == error) //there is no error produced by strtol function
-							query_len_found = true; //we are good to go!
+						if (cur_space_pos > cur_pos)
+						{
+							error = errno;
+							query_len = strtol(wuline.substr(cur_pos+1, cur_space_pos - cur_pos - 1).c_str(), &stopstring, 10);
+							if (errno == error) //there is no error produced by strtol function
+								query_len_found = true; //we are good to go!
+						}
+					}
+				}
+				else
+				{
+					if ((cur_pos = wuline.find("Length", 0)) != string::npos && (cur_space_pos = wuline.find("=")) != string::npos)
+					{
+						if (cur_space_pos > cur_pos)
+						{
+							error = errno;
+							query_len = strtol(wuline.substr(cur_space_pos+1).c_str(), &stopstring, 10);
+							if (errno == error) //there is no error produced by strtol function
+								query_len_found = true; //we are good to go!
+						}
 					}
 				}
 			}
 			if (!query_len_found)
 			{
-				cout << "wublast format has problem (after getting query name " << cur_query_name << "), check wublast file" << "\n";
+				cout << "wuBlast/Blast format has problem (after getting query name " << cur_query_name << "), check blast file" << "\n";
 				exit(-1);
 			}
 		}
@@ -1058,7 +1158,7 @@
 					strandness = false;
 			}
 			else
-			if (wuline.find("Query: ") != string::npos)
+			if (wuline.find(query_query) != string::npos)
 			{
 				cur_pos = wuline.find_first_of("0123456789");
 				cur_space_pos = wuline.find(" ", cur_pos);
@@ -1075,7 +1175,7 @@
 					query_end = e;
 			}
 			else
-			if (wuline.find("Sbjct:") != string::npos)
+			if (wuline.find(query_subject) != string::npos)
 			{
 				cur_pos = wuline.find_first_of("0123456789");
 				cur_space_pos = wuline.find(" ", cur_pos);
diff -aur genblast_v139/gBlast.h genblast_v139_mod/gBlast.h
--- genblast_v139/gBlast.h	2010-10-12 20:55:08.000000000 +0100
+++ genblast_v139_mod/gBlast.h	2017-02-23 10:33:58.971043000 +0000
@@ -73,6 +73,8 @@
 
 //int MIN_INTERNAL_EXON_LEN = 20;
 
+int BLAST_MASK_ID = 100; //When you create your database this is the 'other' mask id
+
 
 string PHASE1_VERSION = "1.1";
 
diff -aur genblast_v139/graph.cpp genblast_v139_mod/graph.cpp
--- genblast_v139/graph.cpp	2012-02-23 23:33:18.000000000 +0000
+++ genblast_v139_mod/graph.cpp	2017-02-23 10:33:58.980039000 +0000
@@ -17780,12 +17780,16 @@
 		{
 
 			if (!end_site_fixed)
+      {
 
 				CalcStartEndPos2( false, HSPs, chr_seq); //do the regular stuff
 
+		}
 			else
+      {
 
 				start_site = - CalcStartPos(HSPs.front()->HSP_end, HSPs.front()->gene_start, false, chr_seq);
+		}
 
 		}
 
