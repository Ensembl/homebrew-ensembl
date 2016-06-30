class DialignT < Formula
  homepage "http://dialign-tx.gobics.de"
  url "http://dialign-tx.gobics.de/DIALIGN-T_0.2.2.tar.gz"
  sha256 "31c2aa031c58854f3c22abf44bf731f6cd67eb86cb46db9ce6b4b49c3011db98"

  def install
    cd 'source' do
      system "make", "CPPFLAGS=-O3 -funroll-loops -std=gnu89 -pedantic"
      bin.install 'dialign-t'
    end
  end

end
