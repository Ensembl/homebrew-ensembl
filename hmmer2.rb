class Hmmer2 < Formula
  desc "Profiles protein sequences with hidden Markov models of a sequence family's consensus"
  homepage "http://hmmer.janelia.org/"
  # doi "10.1142/9781848165632_0019", "10.1186/1471-2105-11-431", "10.1371/journal.pcbi.1002195"
  # tag "bioinformatics"
  # tag origin homebrew-science
  # tag dervied

  url "http://eddylab.org/software/hmmer/2.3.2/hmmer-2.3.2.tar.gz"
  sha256 "d20e1779fcdff34ab4e986ea74a6c4ac5c5f01da2993b14e92c94d2f076828b4"

  keg_only "hmmer2 conflicts with hmmer version 3"

  def install
    # Fix "make: Nothing to be done for `install'."
    rm "INSTALL"
    system "./configure", "--prefix=#{prefix}", "--mandir=#{man}", "--enable-threads"
    system "make"
    system "make", "install"
  end

  test do
    assert_match "threshold", shell_output("#{bin}/hmmpfam 2>&1", 1)
  end
end
