class Parsimonator < Formula
  desc 'A fast parsimony program for building phylogenies from DNA'
  homepage 'http://sco.h-its.org/exelixis/web/software/parsimonator/index.html'
  url 'https://github.com/stamatak/Parsimonator-1.0.2/archive/master.zip'
  sha256 '1f5be1c5b5c703c0b03969af7d8fa85da280044f131757c76b66e9021b67ae18'
  version '1.0.2'

  def install
    system 'make'
  end
end
