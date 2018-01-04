class Rmblast < Formula
  desc "RepeatMasker compatible version of the standard NCBI BLAST suite"
  homepage "http://www.repeatmasker.org/RMBlast.html"
  # tag "bioinformatics"
  # tag origin homebrew-science
  # tag dervied

  version "2.2.28"
  if OS.mac?
    url "http://ftp.ncbi.nlm.nih.gov/blast/executables/rmblast/LATEST/ncbi-rmblastn-#{version}-universal-macosx.tar.gz"
    sha256 "f94e91487b752eb24386c3571250a3394ec7a00e7a5370dd103f574c721b9c81"
  elsif OS.linux?
    url "http://ftp.ncbi.nlm.nih.gov/blast/executables/rmblast/LATEST/ncbi-rmblastn-#{version}-x64-linux.tar.gz"
    sha256 "e6503ad25a6760d2d2931f17efec80ba879877b4042a1d10a60820ec21a61cfe"
  else
    raise "Unknown operating system"
  end
  revision 1

  depends_on "ensembl/ensembl/blast" => :recommended

  def install
    prefix.install Dir["*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rmblastn -version")
  end
end
