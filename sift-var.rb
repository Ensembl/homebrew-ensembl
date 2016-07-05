class SiftVar < Formula
  desc "Predicting how amino acid substitution affects protein function"
  homepage "http://sift.bii.a-star.edu.sg/"
  url "http://sift.bii.a-star.edu.sg/www/sift4.0.5.tar.gz"
  sha256 '8cb313fcd3958c91e4312d4987202db3326def08e183b5be0b12937eeb2077dd'

  #requires Module::CPANfile
  resource "cpanm" do
    url "https://cpanmin.us/"
    sha256 "453e68066f2faba5c9fe04b4ca47f915fe0001f71405560093a23919e5e30d65"
  end

  #Code from Sift claims it needs legacy (talks about blastpgp) but other docs claim the converse
  depends_on 'ensembl/ensembl/blast'
  depends_on 'ensembl/ensembl/blimps'

  keg_only 'Source the appropriate env files to bring in'

  def install
    resource("cpanm").stage do
      mv 'cpanmin.us', 'cpanm'
      perl_libs = %w(Getopt::Std POSIX Class::Struct LWP::Simple Tie::IxHash DBI File::Copy List::Util File::Basename File::Path)
      system '/usr/bin/env', 'perl', "cpanm", '--notest', '--local-lib-contained', libexec, *perl_libs
    end

    perl_version = `which perl`.chomp
    blast = Formula['ensembl/ensembl/blast']
    blimps = Formula['ensembl/ensembl/blimps']
    rm buildpath/'config/config_env.txt'
    (buildpath/'config/config_env.txt').write  <<-EOF.undent
SITE_PERL=#{perl_version}
SIFT_HOME=#{prefix}
TMP_DIR=/tmp
BLAST_HOME=#{blast.prefix}
BLIMPS_HOME=#{blimps.prefix}
PERL_LIB=#{libexec}/lib/perl5/
    EOF
    cd 'config' do
      system perl_version, 'setup_env.pl', 'linux'
    end
    cd 'src' do
      inreplace 'cccb' do |s|
        s.gsub! '/usr/bin/gcc', ENV['CC']
        s.gsub! '/usr/local/web/packages/blimps/', blimps.prefix
      end
      system 'csh', 'compile.csh'
    end
    cd 'bin' do
      Dir['*.pl'].each do |s| 
        if File.open(s).grep(/#!\/usr\/local\/bin\/perl/).size > 0
          inreplace s, '#!/usr/local/bin/perl', '#!'+perl_version 
        end
      end
    end
    bin.install Dir['bin/*']
    prefix.install 'db'
    prefix.install 'web'
    (etc+'sift.bash').write <<-EOF.undent
      export PERL5LIB=#{libexec}/lib/perl5:$PERL5LIB
      export SIFT_HOME=#{prefix}
      export PATH=$SIFT_HOME/bin:$PATH
    EOF
  end

  test do
    system "#{bin}/true"
  end
end
