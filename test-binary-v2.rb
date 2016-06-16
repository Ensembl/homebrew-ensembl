# Documentation: https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class TestBinaryV2 < Formula
  desc "Description"
  homepage "https://github.com/andrewyatz/test-binary"
  url "https://github.com/andrewyatz/test-binary/archive/2.0.0.tar.gz"
  version "2.0.0"
  sha256 "fce5539782e63b29a32dc51e4b16a9a79d8e4d5de61392aa21bb1d2e676025b1"

  def install
    Dir["bin/*"].each do |entry|
      newEntry = entry+"-"+version
      mv entry, newEntry
    end
    bin.install Dir["bin/*"]
  end

  test do
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "#{bin}/helloworld-"+version
  end
end
