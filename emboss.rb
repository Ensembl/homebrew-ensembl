class Emboss < Formula
  homepage "http://emboss.sourceforge.net/"
  url "ftp://emboss.open-bio.org/pub/EMBOSS/EMBOSS-6.6.0.tar.gz"
  mirror "http://mirrors.mit.edu/gentoo-distfiles/distfiles/EMBOSS-6.6.0.tar.gz"
  mirror "http://science-annex.org/pub/emboss/EMBOSS-6.6.0.tar.gz"
  sha256 "7184a763d39ad96bb598bfd531628a34aa53e474db9e7cac4416c2a40ab10c6e"

  # tag origin homebrew-science
  # tag dervied
  
  option "with-embossupdate", "Run embossupdate after `make install`"

  depends_on "pkg-config" => :build
  depends_on "libpng"     => :recommended

  def install
    inreplace "Makefile.in", "$(bindir)/embossupdate", "" if build.without? "embossupdate"

    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --prefix=#{prefix}
      --mandir=#{man}
      --docdir=#{doc}
      --enable-64
      --with-thread
    ]
    args << "--without-x" if build.without? "x11"

    system "./configure", *args
    system "make", "install"
  end
end
