class BcftoolsAT131 < Formula
  desc "Tools (written in C using htslib) for manipulating VCF and BCF"
  homepage "http://www.htslib.org/"
  # doi "10.1093/bioinformatics/btp352"
  # tag "bioinformatics"
  # tag origin homebrew-science
  # tag dervied

  keg_only "Old version 1.3.1"

  url "https://github.com/samtools/bcftools/releases/download/1.3.1/bcftools-1.3.1.tar.bz2"
  sha256 "12c37a4054cbf1980223e2b3a80a7fdb3fd850324a4ba6832e38fdba91f1b924"
  
  def install
    system "make" 
    system 'make', "prefix=#{prefix}", 'install'
  end

  test do
    system "bcftools 2>&1 |grep -q bcftools"
  end
end
