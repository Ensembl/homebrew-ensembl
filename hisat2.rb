class Hisat2 < Formula
  desc "graph-based alignment to a population of genomes"
  homepage "https://ccb.jhu.edu/software/hisat2/"
  url "ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/downloads/hisat2-2.0.5-source.zip"
  sha256 "ef74e2ab828aff8fd8a6320feacc8ddb030b58ecbc81c095609acb3851b6dc53"
  # tag "bioinformatics"
  # doi "10.1038/nmeth.3317"
  # tag origin homebrew-science
  # tag dervied

  def install
    system "make"
    bin.install "hisat2", Dir["hisat2-*"]
    doc.install Dir["doc/*"]
  end

  test do
    assert_match "HISAT2", shell_output("#{bin}/hisat2 2>&1", 1)
  end
end