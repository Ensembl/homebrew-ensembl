# Copyright [2016] EMBL-European Bioinformatics Institute
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Repeatmasker < Formula
  desc "Nucleic and proteic repeat masking tool"
  homepage "http://www.repeatmasker.org/"
  version "4-0-5"
  url "http://www.repeatmasker.org/RepeatMasker-open-#{version}.tar.gz"
  sha256 "e4c15c64b90d57ce2448df4c49c37529eeb725e97f3366cc90f794a4c0caeef7"
  revision 2

  option "without-configure", "Do not run configure"
  option "without-cache", "Do not change the cache directory to use REPEATMASKER_CACHE instead of HOME"
  option "with-dfam", "Use Hmmer and Dfam to mask sequences"

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
      f.gsub! /(RMBLAST_DIR\s*=)\s*\S+/, '\1 "'.concat(HOMEBREW_PREFIX).concat('/bin";')
      f.gsub! /(DEFAULT_SEARCH_ENGINE\s*=)\s*\S+/, '\1 "ncbi";'
      f.gsub! /(TRF_PRGM\s*=)\s*\S+/, '\1 "'.concat(Formula['homebrew/science/trf'].opt_bin).concat('/trf";')
      f.gsub! /(HMMER_DIR\s*=)\s*\S+/, '\1 "'.concat(Formula['homebrew/science/hmmer'].opt_bin).concat('";')
      f.gsub! "HOME", "REPEATMASKER_CACHE" if build.with? "cache"
      if build.with? "phrap"
        f.gsub! /(CROSSMATCH_DIR\s*=)\s*\S+/, '\1 "'.concat(Formula["ensembl/moonshine/phrap"].opt_bin).concat('";')
        f.gsub! /(DEFAULT_SEARCH_ENGINE\s*=)\s*\S+/, '\1 "crossmatch";'
      elsif build.with? "dfam"
        f.gsub! /(DEFAULT_SEARCH_ENGINE\s*=)\s*\S+/, '\1 "hmmer";'
      end
    end

    if build.with? "perl"
      perl = Formula["perl"].opt_bin/"perl"
    else
      if ENV.has_key?('PLENV_ROOT')
        perl = %x{#{ENV['PLENV_ROOT']}/bin/plenv which perl}.chomp
      else
        perl = "/usr/bin/perl"
      end
    end

    for file in ["RepeatMasker", "DateRepeats", "ProcessRepeats", "RepeatProteinMask", "DupMasker", "util/queryRepeatDatabase.pl", "util/queryTaxonomyDatabase.pl", "util/rmOutToGFF3.pl", "util/rmToUCSCTables.pl"] do
      inreplace "#{libexec}/#{file}", /^#!.*perl/, "#!#{perl}"
    end

    if build.with? "repbase"
      system "cp --backup --suffix=.rm #{Formula['ensembl/moonshine/repbase'].opt_libexec}/* #{libexec}/Libraries"
    else
     system "for F in #{libexec}/Libraries/*.rm; do if [ -e \"$F\" ]; then mv $F ${F%.rm};fi;done"
     inreplace "#{libexec}/Libraries/RepeatMaskerLib.embl", /RELEASE 20110419-min/, "RELEASE 20170101-min"
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
    (testpath/"hmmer_dna.fa").write(">dna\nATCGAGCTACGAGCGATCATGCGATCATCATAAAAAAAAAAAATATATATATATATATA\n")
    system "RepeatMasker -engine hmmer #{testpath}/hmmer_dna.fa"
    assert File.exist?(testpath/"hmmer_dna.fa.masked")
    assert File.exist?(testpath/"hmmer_dna.fa.out")
    assert File.exist?(testpath/"hmmer_dna.fa.tbl")
    (testpath/"blast_dna.fa").write(">dna\nATCGAGCTACGAGCGATCATGCGATCATCATAAAAAAAAAAAATATATATATATATATA\n")
    (testpath/"blast_dna.lib").write(">TEST1#SIMPLE @test [S:10]\natatatatatatata\n")
    system "RepeatMasker -engine ncbi -lib #{testpath}/blast_dna.lib #{testpath}/blast_dna.fa"
    assert File.exist?(testpath/"blast_dna.fa.masked")
    assert File.exist?(testpath/"blast_dna.fa.out")
    assert File.exist?(testpath/"blast_dna.fa.tbl")
  end
end
