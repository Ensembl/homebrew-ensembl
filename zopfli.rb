class Zopfli < Formula
  desc "New zlib (gzip, deflate) compatible compressor"
  homepage "https://github.com/google/zopfli" 
  url "https://github.com/google/zopfli/archive/master.zip"
  version "1.0.0"
  sha256 "5f13a3ed3cea32b4f73e9ca215ec27a04ca1ae15ef7e78b8705778290da5dcca"
  head "https://github.com/google/zopfli.git", :using => :git

  def install
    # Makefile hardcodes gcc
    inreplace "makefile", "gcc", ENV.cc
    system "make", "-f", "makefile"
    bin.install "zopfli"
    if build.head?
      system "make", "-f", "makefile", "zopflipng"
      bin.install "zopflipng"
    end
  end

  test do
    system "#{bin}/zopfli"
  end
end
