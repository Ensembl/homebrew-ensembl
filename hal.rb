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

class Hal < Formula
  desc 'Hierarchical Alignment Format library'
  homepage 'https://github.com/ComparativeGenomicsToolkit/hal'
  url 'https://github.com/ComparativeGenomicsToolkit/hal.git', :using => :git
  version '451788f'

  depends_on 'ensembl/ensembl/sonlib'
  depends_on 'homebrew/science/hdf5'

  keg_only 'Use directly because of large numbers of installed bianries and headers'

  def install
    ENV.deparallelize
    sonlib = Formula['ensembl/ensembl/sonlib']
    system 'make', "sonLibRootPath=#{sonlib.opt_prefix}/sonLib"

    bin.install Dir['bin/*']
    lib.install Dir['lib/*']
  end
end
