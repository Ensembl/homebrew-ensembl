class EnsemblGitTools < Formula
  desc "Library of extended Git functions for working with Ensembl"
  homepage "https://github.com/ensembl/ensembl-git-tools"

  url "https://github.com/Ensembl/ensembl-git-tools/archive/1.0.6.tar.gz"
  sha256 "9f2d1859a0b9ad6889aaa505518170969d433c09dd1dece5a02f5ce177a9aaef"

  def install
    bin.install Dir["bin/*"]
    prefix.install "advanced_bin/"
    lib.install "lib/EnsEMBL"
    prefix.install "hooks"
  end

  test do
    system 'git-ensembl'
  end
end
