
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
  url 'https://github.com/ComparativeGenomicsToolkit/hal.git', :using => :git, :revision => 'd864ed8ba23f402e9a8a0f26d0daf0d7b5ca89de'
  version 'd864ed8'

  depends_on 'ensembl/ensembl/sonlib'
  depends_on 'ensembl/external/kent'
  depends_on 'hdf5@1.10'

  def install
    ENV.deparallelize
    
    sonlib = Formula['ensembl/ensembl/sonlib']
    kent = Formula['ensembl/external/kent']
    hdf5 = Formula['hdf5@1.10']

    # Add hdf5 onto PATH so we find the 1.8 compiler
    ENV.prepend_create_path "PATH", hdf5.bin
    ENV['h5prefix'] = "-prefix=#{hdf5.prefix}"
    # These disabled for the moment because of samtabix dependency
    # ENV['ENABLE_UDC'] = '1'
    # ENV['KENTSRC'] = kent.prefix
    system 'make', "sonLibRootPath=#{sonlib.opt_prefix}/sonLib"

    bin.install Dir['bin/*']
    lib.install Dir['lib/*.a']
    include.install Dir['lib/*.h']
  end
end
