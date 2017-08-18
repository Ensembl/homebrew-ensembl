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

class TCoffee < Formula
  homepage "http://www.tcoffee.org/"
  version '9.03.r1336'
  url "http://www.tcoffee.org/Packages/Beta/Version_9.03.r1336/T-COFFEE_distribution_Version_9.03.r1336.tar.gz"
  sha256 "02147aa10c033b75658e360dc45ed1deaca4b6edc4c95b8bedde169e69568aac"
  # doi "10.1006/jmbi.2000.4042"
  revision '2'

  depends_on 'poa'
  depends_on 'dialign-tx'
  depends_on 'dialign-t'
  depends_on 'pcma'
  depends_on 'probcons'
  depends_on 'clustal-w'
  depends_on 'mafft'
  depends_on 'muscle'
  depends_on 'kalign'

  def install
    cd 't_coffee_source' do
      system *%w[make t_coffee]
      bin.install 't_coffee'
      #prefix.install "lib" => "libexec"
      #prefix.install Dir["*"]
      #bin.install_symlink "../compile/t_coffee"
    end
    (prefix+'plugins').install 'mcoffee'
    File.open((etc+'tcoffee.bash'), 'w') { |file| file.write("export MCOFFEE_4_TCOFFEE=#{prefix}/plugins/mcoffee
") }
  end

  test do
    system "#{bin}/t_coffee -version"
  end
end
