class Infernal < Formula
  desc "Search DNA databases for RNA structure and sequence similarities"
  homepage "http://eddylab.org/infernal/"
  # doi "10.1093/bioinformatics/btp157"
  # tag "bioinformatics"
  # tag origin homebrew-science
  # tag dervied

  url "http://eddylab.org/software/infernal/infernal-1.1.2.tar.gz"
  sha256 "ac8c24f484205cfb7124c38d6dc638a28f2b9035b9433efec5dc753c7e84226b"

  deprecated_option "check" => "with-test"
  deprecated_option "with-check" => "with-test"

  option "with-test", "Run the test suite (`make check`). Takes a couple of minutes."

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end

  test do
    system "#{bin}/cmsearch", "-h"
  end
end