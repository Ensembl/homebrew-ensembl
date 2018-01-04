class Trimal < Formula
  desc "Automated alignment trimming in phylogenetic analyses"
  homepage "http://trimal.cgenomics.org/"
  # doi "10.1093/bioinformatics/btp348"
  # tag "bioinformatics"
  # tag origin homebrew-science
  # tag dervied
  url "https://github.com/scapella/trimal/archive/v1.4.1.tar.gz"
  sha256 "cb8110ca24433f85c33797b930fa10fe833fa677825103d6e7f81dd7551b9b4e"

  head "https://github.com/scapella/trimal"

  def install
    system "make", "-C", "source", "CC=c++"
    bin.install "source/readal", "source/trimal", "source/statal"
    pkgshare.install "dataset"
    doc.install %w[AUTHORS CHANGELOG LICENSE README]
  end

  test do
    assert_match "Salvador", shell_output("#{bin}/trimal 2>&1", 0)
    assert_match "Salvador", shell_output("#{bin}/readal 2>&1", 0)
    assert_match "Salvador", shell_output("#{bin}/statal 2>&1", 0)
  end
end
