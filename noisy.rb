class Noisy < Formula
  desc 'Identify homo-plastic characters in multiple sequence alignments'
  homepage 'http://www.bioinf.uni-leipzig.de/Software/noisy/'
  url 'http://www.bioinf.uni-leipzig.de/Software/noisy/Noisy-1.5.12.tar.gz'
  sha256 'd0e388506147999aa8920cad03dc86dcd606c53ec8b14acafa5cd4957b96d609'
  version '1.5.12'

  def install
    system './configure', "--prefix=#{prefix}"
    system 'make'
    system 'make', 'install'
  end
end
