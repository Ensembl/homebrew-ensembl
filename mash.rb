class Mash < Formula
  desc "Fast genome distance estimation using MinHash"
  homepage "https://github.com/marbl/Mash"
  # tag "bioinformatics"
  # doi "10.1101/029827"
  # tag origin homebrew-science
  # tag dervied

  url "https://github.com/marbl/Mash/archive/v2.0.tar.gz"
  sha256 "28f9b0d5ca646065b0b0b8c628552420fa61ac2904777a33c1856c4512640660"
  head "https://github.com/marbl/Mash.git"

  needs :cxx11

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "capnp"
  depends_on "gsl"
  depends_on "zlib" unless OS.mac?

  def install
    system "./bootstrap.sh"
    system "./configure",
      "--prefix=#{prefix}",
      "--with-capnp=#{Formula["capnp"].opt_prefix}",
      "--with-gsl=#{Formula["gsl"].opt_prefix}"
    system "make"
    bin.install "mash"
    doc.install Dir["doc/sphinx/*"]
  end

  test do
    system bin/"mash", "-h"
  end
end