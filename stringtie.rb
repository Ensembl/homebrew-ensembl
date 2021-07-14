class Stringtie < Formula
  desc "StringTie is a fast and highly efficient assembler of RNA-Seq alignments into potential transcripts"
  homepage "https://ccb.jhu.edu/software/stringtie/index.shtml"
  version "2.1.5"
  url "http://ccb.jhu.edu/software/stringtie/dl/stringtie-#{version}.tar.gz"
  sha256 "f227ceb33399ef97ec653f5730b54574f9b656fda13f44fcc04b9e7c9a0dc165"

  def install
    system 'make', 'release'
    bin.install "stringtie"
  end

  def test
    assert_true(version, shell_output(system "#{opt_prefix}/bin/stringtie", "--version").strip)
  end
end
