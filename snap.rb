class Snap < Formula
  desc "Gene prediction tool"
  homepage "http://korflab.ucdavis.edu/software.html"
  # doi "10.1186/1471-2105-5-59"
  # tag "bioinformatics"
  # tag origin homebrew-science
  # tag dervied

  url "http://korflab.ucdavis.edu/Software/snap-2013-11-29.tar.gz"
  sha256 "e2a236392d718376356fa743aa49a987aeacd660c6979cee67121e23aeffc66a"

  def install
    system "make"
    bin.install %w[exonpairs fathom forge hmm-info snap]
    bin.install Dir["*.pl"]
    doc.install %w[00README LICENSE example.zff]
    prefix.install %w[DNA HMM Zoe]
  end

  def caveats; <<-EOS.undent
      Set the ZOE environment variable:
        export ZOE=#{opt_prefix}
    EOS
  end

  test do
    system "#{bin}/snap", "-help"
  end
end
