class Quicktree < Formula
  desc "Efficient NJ implementation"
  homepage "http://www.sanger.ac.uk/science/tools/quicktree"
  url "ftp://ftp.sanger.ac.uk/pub/resources/software/quicktree/quicktree.tar.gz"
  sha256 "3b5986a8d7b8e59ad5cdc30bd7c7d91431909c25230e8fed13494f21337da6ef"
  version '1.1.0'

  def install
    system "make"
    bin.install 'bin/quicktree'
  end

  test do
    system "true"
  end
end
