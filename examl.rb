
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Examl < Formula
  homepage 'https://github.com/stamatak/ExaML'
  desc 'Exascale Maximum Likelihood (ExaML) code for phylogenetic inference using MPI'
  url 'https://github.com/stamatak/ExaML/archive/v3.0.17.tar.gz'
  sha256 '90a859e0b8fff697722352253e748f03c57b78ec5fbc1ae72f7e702d299dac67'
  version '3.0.17'
  
  depends_on 'openmpi' => ["with-cxx-bindings"]
  needs :openmp

  def install
    cd 'examl' do
      system 'make', '-f', 'Makefile.AVX.gcc'
      bin.install 'examl-AVX'
      system 'make','-f', 'Makefile.AVX.gcc', 'clean'

      system 'make', '-f', 'Makefile.SSE3.gcc'
      bin.install 'examl'
    end

    cd 'parser' do
      system 'make', '-f', 'Makefile.SSE3.gcc'
      bin.install 'parse-examl'
    end
  end
end
