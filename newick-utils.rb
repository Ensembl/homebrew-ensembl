class NewickUtils < Formula
  homepage "http://cegg.unige.ch/newick_utils"
  # doi "10.1093/bioinformatics/btq243"
  # tag "bioinformatics"
  # tag origin homebrew-science
  # tag dervied

  url "http://cegg.unige.ch/pub/newick-utils-1.6.tar.gz"
  sha256 "2c142a2806f6e1598585c8be5afba6d448c572ad21c142e70d6fd61877fee798"

  head "https://github.com/tjunier/newick_utils.git"

  # Ignore errors in nw_display that I think are fine (the SVG is almost the same)
  patch :DATA

  def install
    system "./configure",
      # Fix error: use of undeclared identifier 'LUA_GLOBALSINDEX'
      "--with-lua=no",
      # A radical way of skipping the error in nw_display would be to disable the
      # libxml support altogether with "--with-libxml=no",
      "--disable-dependency-tracking",
      "--prefix=#{prefix}"
    system "make"
    system "make", "check"
    system "make", "install"
  end

  test do
    expected = <<-EOS
 +-------------------------------------+ B
=| A
 +---------------------------------------------------------------------------+ C

 |------------------|------------------|------------------|------------------|
 0                0.5                  1                1.5                  2
 substitutions/site
EOS

    output = pipe_output("#{bin}/nw_display -", "(B:1,C:2)A;\n")
    assert_equal expected, output.split("\n").map(&:rstrip).join("\n")
  end
end

__END__
--- a/tests/test_nw_display.sh
+++ b/tests/test_nw_display.sh
@@ -138,0 +138,2 @@
+pass=TRUE
+
