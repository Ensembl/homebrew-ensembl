class Maker < Formula
  homepage "http://www.yandell-lab.org/software/maker.html"
  # doi '10.1101/gr.6743907' => 'MAKER', '10.1186/1471-2105-12-491' => 'MAKER2', '10.1104/pp.113.230144' => 'MAKER-P'
  # tag "bioinformatics"

  url "http://yandell.topaz.genetics.utah.edu/maker_downloads/static/maker-2.31.9.tgz"
  sha256 "c92f9c8c96c6e7528d0a119224f57cf5e74fadfc5fce5f4b711d0778995cabab"
  revision 1

  depends_on "ensembl/ensembl/augustus"
  depends_on "ensembl/ensembl/blast"
  depends_on "ensembl/ensembl/exonerate22"
  depends_on "infernal"
  depends_on "mir-prefer"
  depends_on :mpi => [:cc, :cxx, :f90, :f77]
  depends_on "ensembl/ensembl/repeatmasker"
  depends_on "snap"
  depends_on "snoscan"
  depends_on "trnascan"
  depends_on 'ensembl/ensembl/bioperl-169'

  resource "cpanm" do
    url "https://cpanmin.us/"
    sha256 "d2221f1adb956591fa43cd61d0846b961be1fffa222210f097bfd472a11e0539"
  end

  # How can we download this and make it available to cpanm?
  resource "cpanfile" do
    url "https://raw.githubusercontent.com/Ensembl/cpanfiles/master/maker/cpanfile"
    sha256 "4f4b2a2eac3202f9a45f09f1ba8c61347d5da1ee29023827bea79b523fc523dc"
  end

  def install
    bioperl = Formula['ensembl/ensembl/bioperl-169']
    perllib = buildpath+"src/perl-libs"

    ENV.prepend_create_path "PERL5LIB", perllib+'lib/perl5'
    ENV.prepend_create_path "PERL5LIB", bioperl.libexec

    resource("cpanfile").stage do
      copy 'cpanfile', buildpath+'cpanfile'
    end

    resource("cpanm").stage do
      copy 'cpanmin.us', buildpath+'cpanm'
    end

    system 'perl', "cpanm", '--notest', '--local-lib-contained', perllib, '--installdeps', '.'

    cd "src" do
      # mpi = if build.with?("mpi") then "yes" else "no" end
      mpi = "yes"
      system "(echo #{mpi}; yes '') |perl Build.PL"
      system *%w[./Build install]
    end

    bin.install 'src/bin/gff3_merge'
    bin.install 'src/bin/maker'
    libexec.install Dir["*"]
    bin.env_script_all_files(libexec/'bin', :PERL5LIB => "#{bioperl.libexec}:#{libexec}/src/perl-libs/lib/perl5")
  end

  def caveats; <<-EOS.undent
    Optional components of MAKER
      GeneMarkS and GeneMark-ES. Download from http://exon.biology.gatech.edu
      FGENESH 2.4 or higher. Purchase from http://www.softberry.com

    MAKER is available for academic use under either the Artistic
    License 2.0 developed by the Perl Foundation or the GNU General
    Public License developed by the Free Software Foundation.

    MAKER is not available for commercial use without a license. Those
    wishing to license MAKER for commercial use should contact Beth
    Drees at the University of Utah TCO to discuss your needs.
    EOS
  end

  test do
    system "#{bin}/maker", "--version"
  end
end
