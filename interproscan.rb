
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Interproscan < Formula

  desc 'Scan sequences (protein and nucleic) against InterPro signatures'
  homepage 'http://www.ebi.ac.uk/interpro/interproscan.html'
  version '5.50-84.0'
  url 'ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/5.50-84.0/interproscan-5.50-84.0-64-bit.tar.gz'
  sha256 '3b792b33a14091a144a13ba35d70fbaa45abb8102f240a6da4e24bb07babaac4'

  depends_on 'ensembl/moonshine/tmhmm'
  depends_on 'ensembl/moonshine/signalp'
  depends_on 'ensembl/moonshine/phobius'
  depends_on 'ensembl/external/emboss'

  def install
    tmhmm = Formula['ensembl/moonshine/tmhmm']
    signalp = Formula['ensembl/moonshine/signalp']
    phobius = Formula['ensembl/moonshine/phobius']
    emboss = Formula['ensembl/external/emboss']

    inreplace 'interproscan.properties' do |s|
      # Handle tmhmm config
      s.gsub! '${bin.directory}/tmhmm/2.0c/decodeanhmm', "#{tmhmm.bin}/decodeanhmm.Linux_x86_64"
      s.gsub! '${data.directory}/tmhmm/2.0c/TMHMM2.0c.model', "#{tmhmm.lib}/TMHMM2.0.model"

      # Handle signalp dependencies
      s.gsub! '${bin.directory}/signalp/4.1/signalp', "#{signalp.bin}/signalp"
      s.gsub! '${bin.directory}/signalp/4.1/lib', "#{signalp.lib}"

      # Handle phobius dependencies
      s.gsub! '${bin.directory}/phobius/1.01/phobius.pl', "#{phobius.prefix}/phobius.pl"

      # Use emboss for getorf not bundled version
      s.gsub! '${bin.directory}/nucleotide/getorf', "#{emboss.bin}/getorf"
    end

    inreplace 'interproscan.sh', 'cd "$(dirname "$INSTALL_DIR")"', "cd #{prefix}"
    mv 'interproscan.sh', 'bin/.'

    prefix.install Dir['*']
  end
end
