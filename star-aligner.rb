class StarAligner < Formula
  desc "Spliced Transcripts Alignment to a Reference"
  homepage "https://github.com/alexdobin/STAR"
  version "2.7.8a"
  url "https://github.com/alexdobin/STAR/archive/#{version}.tar.gz"
  sha256 "e6bf898291a1a350b36d8c031d3f65fc66869e6775a053af57c9cfe275f77305"

  def install
    cd "source" do
      system 'make', "STAR", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}"
      bin.install 'STAR'
      system 'make', 'clean'
      system 'make', "STARlong", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}"
      bin.install 'STARlong'
    end
  end

  def test
    assert_equal(version, shell_output("#{opt_prefix}/bin/STAR --version").strip)
  end
end
