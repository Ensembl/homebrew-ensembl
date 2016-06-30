class Probcons < Formula
  homepage 'http://probcons.stanford.edu/' 
  url 'http://probcons.stanford.edu/probcons_v1_12.tar.gz'
  version '1.12'
  sha256 'ecf3f9ab9ad47e14787c76d1c64aeea5533d4038c4be0236c00cdd79104cf383'

  def install
    inreplace 'SafeVector.h', 'size_t', 'std::size_t'
    inreplace 'CompareToRef.cc', '#include <string>', '#include <cstring>'
    inreplace 'ProjectPairwise.cc', '#include <string>', '#include <cstring>'
    inreplace 'Main.cc', '#include <string>', '#include <cstring>'
    inreplace 'Makefile', '-DVERSION="1.12"', '-DVERSION="1.12" -std=c++11'
    system "make"
    bin.install 'probcons'
  end

end
