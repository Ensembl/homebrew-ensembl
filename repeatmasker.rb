class Repeatmasker < Formula
  desc "Nucleic and proteic repeat masking tool"
  homepage "http://www.repeatmasker.org/"
  version "4.0.5"
  url "http://www.repeatmasker.org/RepeatMasker-open-4-0-5.tar.gz"
  sha256 "e4c15c64b90d57ce2448df4c49c37529eeb725e97f3366cc90f794a4c0caeef7"

  option "without-configure", "Do not run configure"
  option "without-cache", "Do not change the cache directory to use REPEATMASKER_CACHE instead of HOME"

  depends_on "homebrew/science/hmmer" # at least version 3.1 for nhmmer
  depends_on "perl" => :optional
  depends_on "ensembl/ensembl/rmblast"
  depends_on "homebrew/science/trf"
  depends_on "ensembl/moonshine/phrap" => :recommended
  depends_on "ensembl/moonshine/repbase" => :recommended

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"RepeatMasker"
  end

  def post_install
    system "cp", libexec/"RepeatMaskerConfig.tmpl", libexec/"RepeatMaskerConfig.pm"
    inreplace libexec/"RepeatMaskerConfig.pm" do |f|
      f.gsub! /^(\s*\$RMBLAST_DIR\s*=)\s*\S+/, "\\1 \"#{Formula['ensembl/ensembl/rmblast'].opt_bin}\";"
      f.gsub! /^(\s*\$DEFAULT_SEARCH_ENGINE\s*=)\s*\S+/, '\1 "ncbi"'
      f.gsub! /^(\s*\$TRF_PRGM\s*=)\s*\S+/, "\\1 \"#{Formula['homebrew/science/trf'].opt_bin}/trf\";"
      f.gsub! /^(\s*\$HMMER_DIR\s*=)\s*\S+/, "\\1 \"#{Formula['homebrew/science/hmmer'].opt_bin}\";"
      f.gsub! "HOME", "REPEATMASKER_CACHE" if build.with? "cache"
      if build.with? "phrap"
        f.gsub! /^(\s*\$CROSSMATCH_DIR\s*=)\s*\S+/, "\\1 \"#{Formula["ensembl/moonshine/phrap"].opt_bin}\";"
        f.gsub! /^(\s*\$DEFAULT_SEARCH_ENGINE\s*=)\s*\S+/, '\1 "crossmatch";'
      end
    end

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

    for file in ["RepeatMasker", "DateRepeats", "ProcessRepeats", "RepeatProteinMask", "DupMasker", "util/queryRepeatDatabase.pl", "util/queryTaxonomyDatabase.pl", "util/rmOutToGFF3.pl", "util/rmToUCSCTables.pl"] do
      inreplace "#{libexec}/#{file}", /^#!.*perl/, "#!#{perl}"
    end

    if build.with? "repbase"
      system "cp --backup --suffix=.rm #{Formula['ensembl/moonshine/repbase'].opt_libexec}/* #{libexec}/Libraries"
    else
     system "for F in #{libexec}/Libraries/*.rm; do mv $F ${F%.rm};done"
    end

    system "#{perl} #{libexec}/util/buildRMLibFromEMBL.pl #{libexec}/Libraries/RepeatMaskerLib.embl > #{libexec}/Libraries/RepeatMasker.lib"
    system "#{HOMEBREW_PREFIX}/bin/makeblastdb -dbtype nucl -in #{libexec}/Libraries/RepeatMasker.lib"
    system "#{HOMEBREW_PREFIX}/bin/makeblastdb -dbtype prot -in #{libexec}/Libraries/RepeatPeps.lib"
  end

  def caveats; <<-EOS.undent
    Congratulations!  RepeatMasker is now ready to use.
    If something went wrong you can reconfigure RepeatMasker
    with:
      brew postinstall ensembl/ensembl/repeatmasker
      or
      cd #{libexec} && ./configure

    You will need to set your environment variable REPEATMASKER_CACHE
    where you want repeatmasker to write cache it.
      export REPEATMASKER_CACHE=$HOME
      or
      export REPEATMASKER_CACHE=/nfs/path/to/my/project
    EOS
  end

  test do
    system "RepeatMasker"
  end
end
