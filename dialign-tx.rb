class DialignTx < Formula
  homepage "http://dialign-tx.gobics.de"
  url "http://dialign-tx.gobics.de/DIALIGN-TX_1.0.2.tar.gz"
  sha256 "fb3940a48a12875332752a298f619f0da62593189cd257d28932463c7cebcb8f"

  def install
    cd 'source' do
      system "make", "CPPFLAGS=-O3 -funroll-loops -std=gnu89 -pedantic"
      bin.install 'dialign-tx'
    end
  end

end
