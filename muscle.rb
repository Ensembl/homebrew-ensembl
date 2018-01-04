class Muscle < Formula
  desc "Multiple sequence alignment program"
  homepage "https://www.drive5.com/muscle/"
  url "https://www.drive5.com/muscle/muscle_src_3.8.1551.tar.gz"
  sha256 "c70c552231cd3289f1bad51c9bd174804c18bb3adcf47f501afec7a68f9c482e"
  # doi "10.1093/nar/gkh340", "10.1186/1471-2105-5-113"
  # tag "bioinformatics"

  def install
    # Fix build per Makefile instructions
    inreplace "Makefile", "-static", ""

    system "make"
    bin.install "muscle"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/muscle -version")
  end
end