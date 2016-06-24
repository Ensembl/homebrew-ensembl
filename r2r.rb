class R2r< Formula
  homepage "http://breaker.research.yale.edu/R2R/"
  # tag "bioinformatics"

  url "http://breaker.research.yale.edu/R2R/R2R-1.0.4.tgz"
  sha256 ""

  def install
    cd 'NotByZasha/infernal-0.7' do
      system './configure'
      system 'make'
    end
    cd 'src' do
      system 'make'
      bin.install 'r2r'
    end
  end
end
