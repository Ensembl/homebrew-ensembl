class R2r< Formula
  homepage "http://breaker.research.yale.edu/R2R/"
  # tag "bioinformatics"

  url "http://breaker.research.yale.edu/R2R/R2R-1.0.4.tgz"
  sha256 "3578c8ad5dfc2a4e6c4f0613ca3e98a1f352af661f60886a1616c5e6d8e7440d"

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
