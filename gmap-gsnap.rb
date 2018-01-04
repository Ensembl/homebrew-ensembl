class GmapGsnap < Formula
  desc "Genomic Mapping & Alignment Program for RNA/EST/Short-read sequences"
  homepage "http://research-pub.gene.com/gmap/"
  url "http://research-pub.gene.com/gmap/src/gmap-gsnap-2017-01-14.tar.gz"
  sha256 "f3eca0b66ff9770c5965d43b3532e59d839e593de00fa3550141527f3c7f1d2c"
  # doi "10.1093/bioinformatics/btq057"
  # tag "bioinformatics"
  # tag origin homebrew-science
  # tag dervied

  depends_on "samtools"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    ENV.deparallelize
    system "make", "check"
    system "make", "install"
  end

  def caveats; <<-EOF.undent
    You will need to either download or build indexed search databases.
    See the readme file for how to do this:
      http://research-pub.gene.com/gmap/src/README

    Databases will be installed to:
      #{share}
    EOF
  end

  test do
    system "#{bin}/gsnap", "--version"
  end
end