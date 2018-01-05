
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class SiftVar < Formula
  desc "Predicting how amino acid substitution affects protein function"
  homepage "http://sift.bii.a-star.edu.sg/"
  url "http://sift.bii.a-star.edu.sg/www/sift4.0.5.tar.gz"
  sha256 '8cb313fcd3958c91e4312d4987202db3326def08e183b5be0b12937eeb2077dd'

  #requires Module::CPANfile
  resource "cpanm" do
    url "https://cpanmin.us/"
    sha256 "d2221f1adb956591fa43cd61d0846b961be1fffa222210f097bfd472a11e0539"
  end

  #Code from Sift claims it needs legacy (talks about blastpgp) but other docs claim the converse
  depends_on 'ensembl/external/blast'
  depends_on 'ensembl/external/blimps'

  keg_only 'Source the appropriate env files to bring in'

  def install
    resource("cpanm").stage do
      mv 'cpanmin.us', 'cpanm'
      perl_libs = %w(Getopt::Std POSIX Class::Struct LWP::Simple Tie::IxHash DBI File::Copy List::Util File::Basename File::Path)
      system '/usr/bin/env', 'perl', "cpanm", '--notest', '--local-lib-contained', libexec, *perl_libs
    end

    perl_version = `which perl`.chomp
    blast = Formula['ensembl/external/blast']
    blimps = Formula['ensembl/external/blimps']
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
    bsh = etc+'sift.bash'
    rm bsh if bsh.exist?
    bsh.write <<-EOF.undent
      export PERL5LIB=#{libexec}/lib/perl5:$PERL5LIB
      export SIFT_HOME=#{prefix}
      export PATH=$SIFT_HOME/bin:$PATH
    EOF
  end

  test do
    system "#{bin}/true"
  end
end
