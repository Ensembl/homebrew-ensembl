class Cafe < Formula
  desc "Computational Analysis of gene Family Evolution"
  homepage "http://sites.bio.indiana.edu/~hahnlab/Software.html"
  url "http://downloads.sourceforge.net/project/cafehahnlab/Previous_versions/cafehahnlab-code_v2.2.tgz"
  sha256 "82853f2df095417708182e4115666162c7cbf67f53778d6a6fa26c1ff58d7473"

  def install
    cd 'cafe.2.2/cafe' do
      system 'make'
      mv 'bin/shell', 'bin/cafeshell'
      bin.install 'bin/cafeshell'
    end
  end
end

