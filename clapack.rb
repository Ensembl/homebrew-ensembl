class Clapack < Formula
  desc 'Algebra functions'
  homepage 'https://github.com/CshlSiepelLab/phast'
  url 'http://www.netlib.org/clapack/clapack-3.2.1.tgz'
  sha256 '6dc4c382164beec8aaed8fd2acc36ad24232c406eda6db462bd4c41d5e455fac'
  version '3.2.1'
  
  keg_only 'Conflicts with openblas'
  
  def install
    cp 'make.inc.example', 'make.inc'
    system 'make', 'f2clib'
    system 'make', 'blaslib'
    system 'make', 'lib'

    (prefix+'F2CLIBS').install 'F2CLIBS/libf2c.a'
    prefix.install 'INCLUDE'
    prefix.install Dir['*.a']
  end
end
