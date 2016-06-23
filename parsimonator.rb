class Parsimonator < Formula
  desc 'A fast parsimony program for building phylogenies from DNA'
  homepage 'http://sco.h-its.org/exelixis/web/software/parsimonator/index.html'
  url 'https://github.com/stamatak/Parsimonator-1.0.2/archive/master.zip'
  sha256 'da935321313fdd9b5d85cbdf2720329a6bff4d831f08646f32d1e0c3d65e254a'
  version '1.0.2'

  def install
    system 'make'
  end
end
