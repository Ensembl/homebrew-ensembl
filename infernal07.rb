class Infernal < Formula
  homepage "http://infernal.janelia.org/"
  # doi "10.1093/bioinformatics/btp157"
  # tag "bioinformatics"

  url "http://eddylab.org/software/infernal/infernal-0.7.tar.gz"
  sha256 ""

  keg_only 'Required for libs and older software. New versions are preferred'

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

end
