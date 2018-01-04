class Recon < Formula
  homepage "http://www.repeatmasker.org/RepeatModeler.html"
  # doi "10.1101/gr.88502"
  # tag "bioinformatics"
  # tag origin homebrew-science
  # tag dervied
  url "http://www.repeatmasker.org/RepeatModeler/RECON-1.08.tar.gz"
  sha256 "699765fa49d18dbfac9f7a82ecd054464b468cb7521abe9c2bd8caccf08ee7d8"

  def install
    inreplace "scripts/recon.pl", '$path = "";', "$path = \"#{bin}\";"
    bin.mkdir
    system *%W[make -C src]
    system *%W[make -C src install BINDIR=#{bin} MANDIR=#{man}]
    bin.install Dir["scripts/*"]
    doc.install %W[00README COPYRIGHT INSTALL LICENSE]
  end

  test do
    assert_match "usage", shell_output("#{bin}/recon.pl 2>&1", 255)
  end
end
