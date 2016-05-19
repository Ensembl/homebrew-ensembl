class EnsemblGitTools < Formula
  desc "Library of extended Git functions for working with Ensembl"
  homepage "https://github.com/ensembl/ensembl-git-tools"
  # tag "versioncontrol"

  url "https://github.com/Ensembl/ensembl-git-tools/archive/1.0.5.tar.gz"

  def install
    bin.install "git-ensembl"
  end

  test do
    system 'git-ensembl'
  end
end
