class Sonlib < Formula
  desc 'Small general purpose library for C and Python with focus on bioinformatics'
  homepage 'https://github.com/benedictpaten/sonLib'
  url 'https://github.com/benedictpaten/sonLib.git', :using => :git
  version '0.1'

  def install
    system 'make', 'all'
    lib.install Dir['lib/*.a']
    include.install Dir['lib/*.h']
    mkpath (prefix+'sonLib')
    (prefix+'sonLib').install Dir['*']
  end
end
