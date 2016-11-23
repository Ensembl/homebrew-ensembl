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

class R2r< Formula
  homepage "http://breaker.research.yale.edu/R2R/"
  # tag "bioinformatics"

  url "http://breaker.research.yale.edu/R2R/R2R-1.0.4.tgz"
  sha256 ""

  def install
    cd 'NotByZasha/infernal-0.7' do
      system './configure'
      system 'make'
    end
    cd 'src' do
      system 'make'
      bin.install 'r2r'
    end
  end
end
