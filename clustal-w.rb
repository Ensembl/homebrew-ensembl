class ClustalW < Formula
  homepage "http://www.clustal.org/clustal2/"
  # tag "bioinformatics"
  # doi "10.1093/nar/22.22.4673"
  # tag origin homebrew-science
  # tag dervied
  url "http://www.clustal.org/download/2.1/clustalw-2.1.tar.gz"
  sha256 "e052059b87abfd8c9e695c280bfba86a65899138c82abccd5b00478a80f49486"

  def install
    # header is missing #include <string>
    # reported to clustalw@ucd.ie Dec 11 2015
    inreplace "src/general/VectorOutOfRange.h",
      "#include <exception>",
      "#include <exception>\n#include<string>"

    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/clustalw2 --version 2>&1 |grep CLUSTAL"
  end
end
