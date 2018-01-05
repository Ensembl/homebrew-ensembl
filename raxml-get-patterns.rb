
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class RaxmlGetPatterns < Formula
  homepage 'https://github.com/Ensembl/RAxML-number_of_patterns'
  desc 'Fork of RAxML that has been hacked to only display the "number of patterns"'
  #Master on 2016/06/30
  url 'https://github.com/Ensembl/RAxML-number_of_patterns/archive/90985c04befb82c3a2771b2f95aae0f2eff3e623.zip'
  sha256 'bac8fbc564487f6ccb163b8dfc2e90af13b1b33cc02b8a52fce910a23c842e69'
  version '1.0'
  
  def install
    system 'make', '-f', 'Makefile.gcc'
    mv 'raxmlHPC', 'getPatterns'
    bin.install 'getPatterns'
  end
end
