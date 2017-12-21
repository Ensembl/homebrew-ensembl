class Erable < Formula
  desc "ERaBLE: Evolutionary Rates and Branch Lengths Estimation"
  homepage "https://www.atgc-montpellier.fr/erable/"
  url "http://www.atgc-montpellier.fr/download/sources/erable/erable1.0_Unix_Linux.tar.gz"
  sha256 "b03ff6f4d854a7cc064f392e428447932cdf1dba08c39712b88354d6ab1bef9a"

  def install
    cd "erable1.0_Unix_Linux" do
      system "./configure"
      system "make"
    end

    cd "erable1.0_Unix_Linux/src" do
      bin.install "erable"
    end

  end

  test do
    system "#{bin}/erable"
  end
end
