class CdHit < Formula
  desc "Cluster and compare protein or nucleotide sequences"
  homepage "http://cd-hit.org"
  # doi "10.1093/bioinformatics/btl158"
  # tag "bioinformatics"
  # tag origin homebrew-science
  # tag dervied

  url "https://github.com/weizhongli/cdhit/releases/download/V4.6.8/cd-hit-v4.6.8-2017-0621-source.tar.gz"
  version "4.6.8"
  sha256 "b67ef2b3a9ff0ee6c27b1ce33617e1bfc7981c1034ea53f8923d025144e595ac"

  head "https://github.com/weizhongli/cdhit.git"

  # error: 'omp.h' file not found
  needs :openmp

  def install
    args = (ENV.compiler == :clang) ? [] : ["openmp=yes"]

    system "make", *args
    bin.mkpath
    system "make", "PREFIX=#{bin}", "install"
  end

  test do
    assert_match "Usage", shell_output("#{bin}/cd-hit -h", 1)
  end
end
