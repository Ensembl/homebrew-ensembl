class Mash < Formula
  desc "Fast genome distance estimation using MinHash"
  homepage "https://github.com/marbl/Mash"
  # tag "bioinformatics"
  # doi "10.1101/029827"
  # tag origin homebrew-science
  # tag dervied

  url "https://github.com/marbl/Mash/archive/v2.0.tar.gz"
  sha256 "7bea8cd3c266640bbd97f2e1c9d0168892915c1c14f7d03a9751bf7a3709dd01"
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
