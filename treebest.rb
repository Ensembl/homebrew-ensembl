class Treebest < Formula
  desc "Tree Building guided by Species Tree"
  homepage "https://github.com/Ensembl/treebest"
  url "https://github.com/Ensembl/treebest/archive/ensembl_production_84.tar.gz"
  sha256 "02312c99d1a758653f31252417c01a7c0126599328232913203d17e4ecafdd10"
  version '84'

  def install
    system "make"
    bin.install 'treebest'
  end

  test do
    system "true"
  end
end
