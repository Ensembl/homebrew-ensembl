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

class Clapack < Formula
  desc 'Algebra functions'
  homepage 'https://github.com/CshlSiepelLab/phast'
  url 'http://www.netlib.org/clapack/clapack-3.2.1.tgz'
  sha256 '6dc4c382164beec8aaed8fd2acc36ad24232c406eda6db462bd4c41d5e455fac'
  version '3.2.1'
  
  keg_only 'Conflicts with openblas'
  
  def install
    cp 'make.inc.example', 'make.inc'
    system 'make', 'f2clib'
    system 'make', 'blaslib'
    system 'make', 'lib'

    (prefix+'F2CLIBS').install 'F2CLIBS/libf2c.a'
    prefix.install 'INCLUDE'
    prefix.install Dir['*.a']
  end
end
