# Copyright [2016] EMBL-European Bioinformatics Institute
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Creates the Kent Source with libraries and include paths

class Kent < Formula
  desc "UCSC Genome Browser source tree"
  homepage "https://genome.ucsc.edu/"
  url "https://github.com/ucscGenomeBrowser/kent/archive/v335_base.tar.gz"
  version "v335"
  sha256 "19816b701e3fa947a80714a80197d5148f2f699d56bfa4c1d531c28d9b859748"

  option "with-connector-c", "Build with connector-c dependency. Otherwise we depend on mysql-client"

  depends_on "ncurses"
  
  # we use the Ensembl mysql-client compile. You can use 
  # mysql-connector-c brings in the MySQL libs for less effort. YMMV
  
  if build.with? "connector-c"
    ohai 'Using mysql-connector-c'
    depends_on "mysql-connector-c"
  else
    ohai 'Using mysql-client from ensembl homebrew'
    depends_on "ensembl/ensembl/mysql-client"
  end
  
  depends_on "libpng"
  depends_on "openssl" 

  patch :DATA

  def install
    libpng = Formula["libpng"]
    if build.with? "connector-c"
      mysql = Formula["mysql-connector-c"]
    else
      mysql = Formula["ensembl/ensembl/mysql-client"]
    end
    openssl = Formula["openssl"]

    machtype = `uname -m`.chomp

    args = ["BINDIR=#{bin}", "SCRIPTS=#{bin}", "PREFIX=#{prefix}", "USE_SSL=1", "SSL_DIR=#{openssl.opt_prefix}"]
    args << "MACHTYPE=#{machtype}"
    args << "CFLAGS=-fPIC"
    args << "PNGLIB=-L#{libpng.opt_lib} -lpng -lz"
    args << "PNGINCL=-I#{libpng.opt_include}"

    if mysql.installed?
      args << "MYSQLINC=#{mysql.opt_include}/mysql"
      args << "MYSQLLIBS=-lmysqlclient -lz"
    end

    inreplace "src/inc/common.mk", "CFLAGS=", "CFLAGS=-fPIC"
    #inreplace "src/htslib/sam.c", "int magic_len; // has_EOF;", "int magic_len, has_EOF;"

    cd build.head? ? "src" : "src" do
      system "make", "userApps", *args
      system "make", "install", *args
    end

    cd "src/utils/cpgIslandExt" do
      system "make", "compile"
      bin.install "cpg_lh"
    end

    cd "src/hg/mouseStuff/axtBest" do
      system "make", "compile"
      bin.install 'axtBest'
    end

    cd bin do
      mv "calc", "kent-tools-calc"
    end

    kent_bash = (etc+'kent.bash')
    File.delete(kent_bash) if File.exist?(kent_bash)
    (kent_bash).write <<-EOF.undent
      export MACHTYPE=#{machtype}
      export KENT_SRC=#{prefix}
    EOF
  end

  
  test do
    (testpath/"test.fa").write <<-EOF.undent
      >test
      ACTG
    EOF
    system "#{bin}/faOneRecord test.fa test > out.fa"
    compare_file "test.fa", "out.fa"
  end

end
__END__
diff --git a/src/makefile b/src/makefile
index bb2d162..849c687 100644
--- a/src/makefile
+++ b/src/makefile
@@ -187,3 +187,13 @@ doc-beta: ${DOCS_LIST:%=%.docbeta}
 doc-install: ${DOCS_LIST:%=%.docinstall}
 %.docinstall:
 	cd $* && $(MAKE) install
+
+.PHONY: install
+install:
+ifndef PREFIX
+	$(error PREFIX is not set)
+endif
+	${MKDIR} $(PREFIX)/inc
+	${MKDIR} $(PREFIX)/lib/${MACHTYPE}
+	cp inc/*.h $(PREFIX)/inc/.
+	cp lib/${MACHTYPE}/*.a $(PREFIX)/lib/${MACHTYPE}/.
