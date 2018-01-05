
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Phast < Formula
  desc ' Phylogenetic analysis with space/time models'
  homepage 'https://github.com/CshlSiepelLab/phast'
  url 'https://github.com/CshlSiepelLab/phast/archive/v1.3.tar.gz'
  sha256 'db4e58b694274b08a5265630eb8c0620e84d10a49149929dddd5ef6f65924b2f'
  version '1.3'
  
  depends_on 'ensembl/ensembl/clapack'
  
  def install
    lapack = Formula['ensembl/ensembl/clapack'].opt_prefix
    inreplace 'src/Makefile', '${PWD}', "#{buildpath}/src"
    cd 'src' do
      system 'make', "CLAPACKPATH=#{lapack}", "PHAST=#{buildpath}"
    end
    bin.install Dir['bin/*']
    lib.install 'lib/libphast.a'
    prefix.install 'data'
  end
end
