class Lastz < Formula
  desc "Align DNA sequences, a pairwise aligner"
  homepage "https://www.bx.psu.edu/~rsharris/lastz/"
  url "https://github.com/lastz/lastz/archive/1.04.00.tar.gz"
  sha256 "a4c2c7a77430387e96dbc9f5bdc75874334c672be90f5720956c0f211abf9f5a"
  head "https://github.com/lastz/lastz"
  # tag "bioinformatics"
  # tag origin homebrew-science
  # tag dervied

  def install
    system "make", "definedForAll=-Wall"
    bin.install "src/lastz", "src/lastz_D"
    prefix.install "README.lastz.html", "test_data", "tools"
  end

  test do
    assert_match "NOTE", shell_output("#{bin}/lastz --help", 1)
  end
end