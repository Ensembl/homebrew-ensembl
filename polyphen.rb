class Polyphen < Formula
  desc "Amino-acid impact assessment on protein structure and function"
  homepage "http://genetics.bwh.harvard.edu/pph2/dokuwiki/start"
  url "http://genetics.bwh.harvard.edu/pph2/dokuwiki/_media/polyphen-2.2.2r405c.tar.gz"
  sha256 'cfad3092ae7f40b490847a2d6b5c85c4d648a855b5d89c16a980f77c585b1bb9'

  depends_on 'ensembl/ensembl/blast'
  depends_on 'ensembl/ensembl/kent'

  keg_only 'Code creates conflicting binaries with existing packages. Must be self-contained'
  
  resource "cpanm" do
    url "https://cpanmin.us/"
    sha256 "453e68066f2faba5c9fe04b4ca47f915fe0001f71405560093a23919e5e30d65"
  end

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV.prepend_create_path 'PPH', prefix

    resource("cpanm").stage do
      mv 'cpanmin.us', 'cpanm'
      system '/usr/bin/env', 'perl', "cpanm", '--notest', '--local-lib-contained', libexec, 'XML::Simple', 'LWP::Simple', 'DBD::SQLite'
    end

    #PolyPhen claims not to muck around with the install path once there. So we won't
    prefix.install Dir['*']
    
    #Setting up blast
    blast = Formula['ensembl/ensembl/blast']
    blastdir=(prefix+'blast'+'bin')
    blastdir.mkdir
    ln_s((blast.bin+'blastp'), (blastdir+'blastp'))
    ln_s((blast.bin+'blastdbcmd'), (blastdir+'blastdbcmd'))

    #Setting up blat
    kent = Formula['ensembl/ensembl/kent']
    ln_s((kent.bin+'blat'), (bin+'blat'))
    ln_s((kent.bin+'twoBitToFa'), (bin+'twoBitToFa'))

    #Compile the rest
    cd prefix+'src' do
      system 'make', 'download'
      system 'make', 'clean'
      system 'make'
      system 'make', 'install'
      system 'make', 'clean'
    end
    env_file = etc+'polyphen.env'
    env_file.rm if env_file.exist?
    env_file.write <<-EOF.undent
export PPH=#{prefix}
export PERL5LIB=#{libexec}/lib/perl5:#{prefix}/perl:$PERL5LIB
export PATH=#{bin}:$PATH
    EOF
  end

  test do
    system "#{bin}/true"
  end
end
