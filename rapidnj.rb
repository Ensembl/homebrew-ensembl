class Rapidnj < Formula
  desc "RapidNJ: fast neighbour-joining trees"
  homepage "https://birc.au.dk/software/rapidnj/"
  url "http://users-birc.au.dk/cstorm/software/rapidnj/rapidnj-src-2.3.2.zip"
  sha256 "9245e84a0d0b412572571ac85dd4599f0b0417718aef687fa014ec119d67b67a"

  def install
    system "make"

    cd "bin" do
      bin.install "rapidnj"
    end
  end

  test do
    system "#{bin}/rapidnj"
  end
end
