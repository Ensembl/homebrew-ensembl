class Repeatmasker < Formula
  homepage "http://www.repeatmasker.org/"
  # tag "bioinformatics"

  version "4.0.5"
  url "http://www.repeatmasker.org/RepeatMasker-open-4-0-5.tar.gz"
  sha256 "e4c15c64b90d57ce2448df4c49c37529eeb725e97f3366cc90f794a4c0caeef7"

  option "without-configure", "Do not run configure"
  option "with-cache", "Specify a cache directory"

  depends_on "homebrew/science/hmmer" # at least version 3.1 for nhmmer
  depends_on "perl" => :optional
  depends_on "ensembl/ensembl/rmblast"
  depends_on "homebrew/science/trf"

  def install
    perl = if build.with? "perl"
      Formula["perl"].opt_bin/"perl"
    else
      %x{plenv which perl}
      if $?.exitstatus != 0
        "/usr/bin/perl"
      else
        %x{plenv which perl}.chomp
      end
    end

    libexec.install Dir["*"]
    bin.install_symlink libexec/"RepeatMasker"

    inreplace libexec/"RepeatMaskerConfig.tmpl", "HOME", "REPEATMASKER_CACHE"
    # Configure RepeatMasker. The prompts are:
    # PRESS ENTER TO CONTINUE
    # Enter path [ perl ]:
    # REPEATMASKER INSTALLATION DIRECTORY Enter path
    # TRF PROGRAM Enter path
    # 2. RMBlast - NCBI Blast with RepeatMasker extensions: [ Un-configured ]
    # RMBlast (rmblastn) INSTALLATION PATH
    # Do you want RMBlast to be your default search engine for Repeatmasker?
    # 4. HMMER3.1 & DFAM
    # HMMER INSTALLATION PATH Enter path
    # Do you want HMMER to be your default search engine for Repeatmasker?
    # 5. Done
    (libexec/"config.txt").write <<-EOS.undent

      #{perl}
      #{libexec}
      #{HOMEBREW_PREFIX}/bin/trf
      2
      #{HOMEBREW_PREFIX}/bin
      Y
      4
      #{HOMEBREW_PREFIX}/bin
      N
      5
      EOS
    system "cd #{libexec} && ./configure <config.txt" if build.with? "configure"
  end

  def caveats; <<-EOS.undent
    Congratulations!  RepeatMasker is now ready to use.
    The program is installed with a minimal repeat library
    by default.  This library only contains simple, low-complexity,
    and common artefact ( contaminate ) sequences.  These are
    adequate for use with your own custom repeat library.  If you
    plan to search using common species specific repeats you will
    need to obtain the complete RepeatMasker repeat library from
    GIRI ( www.girinst.org ) and install it:
      cd #{libexec}
      tar zxvf repeatmaskerlibraries-20140131.tar.gz
      ./configure <config.txt

    The default aligner is RMBlast. You may reconfigure RepeatMasker
    by running
      cd #{libexec} && ./configure

    You will need to set your environment variable REPEATMASKER_CACHE
    where you want repeatmasker to write cache it.
      export REPEATMASKER_CACHE=$HOME
      export REPEATMASKER_CACHE=/nfs/path/to/my/project
    EOS
  end

  test do
    system "RepeatMasker"
  end
end
