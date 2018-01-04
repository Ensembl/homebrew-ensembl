class Exonerate09 < Formula
  desc "Pairwise sequence alignment of DNA and proteins"
  homepage "http://www.ebi.ac.uk/about/vertebrate-genomics/software/exonerate"
  # doi "10.1186/1471-2105-6-31"
  # tag "bioinformatics"
  # tag origin homebrew-science
  # tag dervied
  url "http://ftp.ebi.ac.uk/pub/software/vertebrategenomics/exonerate/exonerate-0.9.0.tar.gz"
  sha256 "d23be9992967790cf937eb3439cc185c27d366358e9c8c1b049d647a80f1d6f1"

  depends_on "pkg-config" => :build
  depends_on "glib"

  keg_only 'Exonerate 0.9 clashes with names'

  patch :DATA

  def install
    # Fix the following error. This issue is fixed upstream in 2.4.0.
    # /usr/bin/ld: socket.o: undefined reference to symbol 'pthread_create@@GLIBC_2.2.5'
    # /lib/x86_64-linux-gnu/libpthread.so.0: error adding symbols: DSO missing from command line

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--enable-glib2"
    ENV.deparallelize
    system "make"
    system "make", "install"

  end

  test do
    system "#{bin}/exonerate --version |grep exonerate"
  end
end
__END__
diff -aur exonerate-0.9.0/configure exonerate-0.9.0-mod/configure
--- exonerate-0.9.0/configure	2004-11-18 16:10:13.000000000 +0000
+++ exonerate-0.9.0-mod/configure	2016-01-26 10:58:59.082027999 +0000
@@ -1506,14 +1506,16 @@
 #  --enable-glib2  Use glib2 library
 #  --disable-glib2 Do not glib2 (use glib1 instead)],
 #[enable_glib2="$enableval"],[enable_glib2=no])
-#if test "$enable_glib2" = yes; then
-#    echo "Using GLIB-2"
+if test "$enable_glib2" = yes; then
+    echo "Using GLIB-2"
 #    (AM_PATH_GLIB_2_0(2.0.0,
 #            [LIBS="$LIBS $GLIB_LIBS" CFLAGS="$CFLAGS $GLIB_CFLAGS"],
 #            AC_MSG_ERROR(Cannot find GLIB2: Is pkg-config in path?)))
-#    glib_cflags=`pkg-config --cflags glib-2.0`
-#    glib_libs=`pkg-config --libs glib-2.0`
-#elif test "$enable_glib2" = no; then
+    glib_cflags=`pkg-config --cflags glib-2.0`
+    glib_libs=`pkg-config --libs glib-2.0`
+    CFLAGS="$CFLAGS $glib_cflags"
+    LIBS="$LIBS $glib_libs"
+elif test "$enable_glib2" = no; then
     echo "Using GLIB-1"
     # Check whether --with-glib-prefix or --without-glib-prefix was given.
 if test "${with_glib_prefix+set}" = set; then
@@ -1786,10 +1788,10 @@
 
     glib_cflags=`glib-config --cflags glib`
     glib_libs=`glib-config --libs glib`
-#else
-#    echo "error: must be yes or no: --enable-glib2:[$enable_glib2]"
-#    exit 1
-#fi
+else
+    echo "error: must be yes or no: --enable-glib2:[$enable_glib2]"
+    exit 1
+fi
 
 
 
diff -aur exonerate-0.9.0/src/c4/viterbi.c exonerate-0.9.0-mod/src/c4/viterbi.c
--- exonerate-0.9.0/src/c4/viterbi.c	2004-11-18 13:57:10.000000000 +0000
+++ exonerate-0.9.0-mod/src/c4/viterbi.c	2016-01-26 10:31:55.842027999 +0000
@@ -1857,7 +1857,7 @@
     g_string_append(cflags, " -I" SOURCE_ROOT_DIR "/src/struct");
     g_string_append(cflags, " -I" SOURCE_ROOT_DIR "/src/general");
     g_string_append(cflags, " -I" SOURCE_ROOT_DIR "/src/sequence");
-    g_string_append(cflags, " `glib-config --cflags`");
+    g_string_append(cflags, " `pkg-config glib-2.0 --cflags`");
     for(i = 0; i < viterbi->model->cflags_add_list->len; i++)
         g_string_append(cflags,
                         viterbi->model->cflags_add_list->pdata[i]);
diff -aur exonerate-0.9.0/src/model/bootstrapper.c exonerate-0.9.0-mod/src/model/bootstrapper.c
--- exonerate-0.9.0/src/model/bootstrapper.c	2004-05-26 10:07:47.000000000 +0100
+++ exonerate-0.9.0-mod/src/model/bootstrapper.c	2016-01-26 10:31:36.450027999 +0000
@@ -177,7 +177,7 @@
                           " -I" SOURCE_ROOT_DIR "/src/sequence"
                           " -I" SOURCE_ROOT_DIR "/src/general"
                           " -I" SOURCE_ROOT_DIR "/src/struct"
-                          " `glib-config --cflags`"
+                          " `pkg-config glib-2.0 --cflags`"
                           " -o ", bs->object_path,
                           " -c ", bs->lookup_path, NULL);
     if(system(command))
diff -aur exonerate-0.9.0/src/model/Makefile.in exonerate-0.9.0-mod/src/model/Makefile.in
--- exonerate-0.9.0/src/model/Makefile.in	2004-11-18 16:10:18.000000000 +0000
+++ exonerate-0.9.0-mod/src/model/Makefile.in	2016-01-26 11:02:56.594027999 +0000
@@ -92,7 +92,7 @@
 
 bootstrapper_SOURCES = bootstrapper.c modeltype.c                                            ungapped.c affine.c est2genome.c ner.c                                protein2dna.c protein2genome.c coding2coding.c                        coding2genome.c genome2genome.c                                       frameshift.c intron.c phase.c
 
-bootstrapper_LDADD = $(C4_OBJECTS) -lm                                        $(top_srcdir)/src/sequence/submat.o                      $(top_srcdir)/src/sequence/splice.o                      $(top_srcdir)/src/c4/heuristic.o
+bootstrapper_LDADD = $(C4_OBJECTS)                                         $(top_srcdir)/src/sequence/submat.o                      $(top_srcdir)/src/sequence/splice.o                      $(top_srcdir)/src/c4/heuristic.o  -lm
 
 
 edit_distance_test_SOURCES = edit_distance.test.c edit_distance.c
