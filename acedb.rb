
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Acedb < Formula
  desc "A C.elegans database. The WormBase version"
  homepage "http://www.acedb.org/"
  url "https://github.com/WormBase/acedb.git", :using => :git
  version 'a0eb67856282eefad70329308990a82d5c1f4aa1'

  
  depends_on 'curl'
  depends_on 'flex'
  depends_on 'byacc'
  depends_on 'readline'
  depends_on 'libxmu'
  depends_on 'gtk+'

  # Patch needed to remove all references to LEX_LIB to 
  # compile to use libfl.a archive and not libfl.so
  patch :DATA

  def install
    ENV.deparallelize
    ENV['ACEDB_MACHINE'] = 'LINUX_64'
    ENV['ACEDB'] = prefix
    ln_sf 'wmake/makefile', 'makefile'
    system 'make'
    system 'make', 'install', "ACEMBLY_BIN="
  end

  test do
    system "false"
  end
end

__END__
diff --git a/wmake/truemake b/wmake/truemake
index 5135672..0c5fc45 100644
--- a/wmake/truemake
+++ b/wmake/truemake
@@ -1116,7 +1116,7 @@ acelibtest : libfree.a libace.a acelibtest.c
 
 tagcount : libfree.a libace.a tagcount.c
 	$(CC) tagcount.c
-	$(LINKER) -o tagcount tagcount.o -L. -lace -lfree $(GLIB_LIBS) $(LEX_LIBS)
+	$(LINKER) -o tagcount tagcount.o -L. -lace -lfree $(GLIB_LIBS)
 
 
 ##########################################
@@ -1165,7 +1165,7 @@ $(ACESOCK_CLIENT_OBJ): $(ACESOCK_UTILS_HDR) $(ACESOCK_CLIENTLIB_HDR) $(ACESOCK_C
 saceclient:  libfree.a libmd5.a  $(ACESOCK_SOCKET_OBJ) \
              $(ACESOCK_UTILS_OBJ) $(ACESOCK_CLIENTLIB_OBJ) $(ACESOCK_CLIENT_OBJ)
 	$(LINKER) -o $@  $(ACESOCK_SOCKET_OBJ) $(ACESOCK_UTILS_OBJ) $(ACESOCK_CLIENTLIB_OBJ) \
-	 $(ACESOCK_CLIENT_OBJ) commandmenu.o -L. -lfree -lmd5 -lm $(GLIB_LIBS) $(LEX_LIBS)
+	 $(ACESOCK_CLIENT_OBJ) commandmenu.o -L. -lfree -lmd5 -lm $(GLIB_LIBS)
 	chmod 755 $(@)$(EXE_SUFFIX)
 
 ##################### sxaceclient, client version of xace ###################
@@ -1377,7 +1377,7 @@ dotplot.o : dotplot.c
 
 dotterbatch: libfree.a libgd.a libgraph.a dotter.o dotterMain.o dotterKarlin.o dotterng.o translate.o blxparser.o
 	$(LINKER) -o dotterbatch dotter.o dotterKarlin.o dotterMain.o dotterng.o \
-	translate.o blxparser.o $(GRAPHGIF_LIBS) -L. -lfree  $(GLIB_LIBS) $(LEX_LIBS)
+	translate.o blxparser.o $(GRAPHGIF_LIBS) -L. -lfree  $(GLIB_LIBS)
 
 # I have removed this optimisation stuff from dotter for now because you cannot
 # debug properly with it, EG
@@ -1457,7 +1457,7 @@ intron2 : libfree.a intron2.o
 	$(LINKER)  -o intron2 intron2.o -L. -lfree $(LIBS)
 
 metacheck : libfree.a libace.a metadata.o
-	  $(LINKER) -o metacheck metadata.o -L. -lace -lfree $(LIBS) $(LEX_LIBS) 
+	  $(LINKER) -o metacheck metadata.o -L. -lace -lfree $(LIBS)
 
 makeUserPasswd: makeUserPasswd.c libfree.a libmd5.a 
 	$(CC) $@.c
