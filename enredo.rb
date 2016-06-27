class Enredo < Formula
  desc 'Graph-based method to detect co-linear segments among multiple genomes'
  homepage 'https://github.com/jherrero/enredo'
  url 'https://github.com/jherrero/enredo.git', :using => :git
  version '0.5.0'

  def install
    inreplace 'src/link.h', '#include <vector>', "#include <vector>\n#include <sys/types.h>"
    inreplace 'src/link.cpp', '#include <vector>', "#include <vector>\n#include <sys/types.h>"
    system './configure', "--prefix=#{prefix}"
    system 'make'
    system 'make', 'install'
  end
end
