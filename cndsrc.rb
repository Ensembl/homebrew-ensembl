class Cndsrc < Formula
  desc 'Collection of utils including mercator'
  homepage 'https://www.biostat.wisc.edu/~cdewey/software.html'
  url 'https://www.biostat.wisc.edu/~cdewey/software/cndsrc-2013.01.11.tar.gz'
  sha256 'c75a0e337a67937130ae1d4d2c703ec19fefa6e870cc89a89e272f0e2fcf6de8'
  version '2013.01.11'

  patch :DATA

  def install
    system 'make', 'install', "prefix=#{prefix}"
    cd "#{prefix}/bin" do
      %w(faFilter faFrag faCount faAlign).each { |f| mv f, f+'Cndsrc' }
    end
  end
end
__END__
diff --git a/apps/mercator/util/maskRepetitive.cc b/apps/mercator/util/maskRepetitive.cc
index bdd7239..1733fd8 100644
--- a/apps/mercator/util/maskRepetitive.cc
+++ b/apps/mercator/util/maskRepetitive.cc
@@ -20,6 +20,7 @@
 #include <iostream>
 #include <vector>
 #include <ctime>
+#include <stdint.h>
 
 #include "bio/formats/fasta.hh"
 #include "util/string.hh"
diff --git a/makefile b/makefile
index c3df2dd..2d1f76b 100644
--- a/makefile
+++ b/makefile
@@ -27,6 +27,7 @@ CC = $(CXX)
 CXXFLAGS += -Wall
 CPPFLAGS += -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE 
 CPPFLAGS += -Iinclude
+CPPFLAGS += -D_GLIBCXX_USE_CXX11_ABI=0
 LDFLAGS += #-ggdb
 
 ifeq ($(OS),MACOSX)

