class Libpll < Formula
  homepage "http://www.libpll.org/"
  url "http://www.libpll.org/Downloads/libpll-1.0.2.tar.gz"
  sha256 "64cb110237a454b9e36749634f07744d4ce12a7438cf5f143d6e73aec8b637c7"
  head "https://git.assembla.com/phylogenetic-likelihood-library.git"

  # tag origin homebrew-science
  # tag dervied

  depends_on "libtool" => :build
  depends_on "automake" => :build
  depends_on "autoconf" => :build

  option "without-check", "Disable build-time checking (not recommended)"

  def install
    system "autoreconf", "-fvi"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "check" if build.with? "check"
    system "make", "install"
  end
end
