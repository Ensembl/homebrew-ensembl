# Documentation: https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class TestBinaryV1 < Formula
  desc "Description"
  homepage "https://github.com/andrewyatz/test-binary"
  url "https://github.com/andrewyatz/test-binary/archive/1.0.0.tar.gz"
  version "1.0.0"
  sha256 "78cd490c1e24b164edadea8d1d3563e9ca0504245571b3c6da49a74a864310a9"

  def install
    bin.install 'bin/helloworld'
  end

  test do
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "#{bin}/helloworld"
  end
end
