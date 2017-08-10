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
    sha256 "d2221f1adb956591fa43cd61d0846b961be1fffa222210f097bfd472a11e0539"
  end
  
  resource "polyphen-databases" do
    url "ftp://genetics.bwh.harvard.edu/pph2/bundled/polyphen-2.2.2-databases-2011_12.tar.bz2"
    sha256 ""
  end

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV.prepend_create_path 'PPH', prefix

    #PolyPhen claims not to muck around with the install path once there. So we won't
    prefix.install Dir['*']
    
    resource("polyphen-databases").stage do
      prefix.install Dir['*']
    end

    #Install Perl libs
    resource("cpanm").stage do
      mv 'cpanmin.us', 'cpanm'
      system '/usr/bin/env', 'perl', "cpanm", '--notest', '--local-lib-contained', libexec, 'XML::Simple', 'LWP::Simple', 'DBD::SQLite'
    end

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
    rm(env_file) if env_file.exist?
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
