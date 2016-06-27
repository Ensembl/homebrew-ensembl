class Paml43 < Formula
  desc 'Phylogenetic analysis by maximum likelihood'
  homepage 'http://abacus.gene.ucl.ac.uk/software/'
  url 'http://abacus.gene.ucl.ac.uk/software/SoftOld/paml4.3.tar.gz'
  version "4.3.0"
  sha256 "e1d91af7c1ab86851395a2fc7dd7e8c2ca641d53c2f159cf5399cf18c73f6aa0"

  def install
    cd 'src' do
      system 'make'
      bin.install %w(chi2 pamp mcmctree basemlg evolver yn00 baseml codeml)
    end
  end
end
