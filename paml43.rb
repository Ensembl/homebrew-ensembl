
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Paml43 < Formula
  desc 'Phylogenetic analysis by maximum likelihood'
  homepage 'http://abacus.gene.ucl.ac.uk/software/'
  url 'http://abacus.gene.ucl.ac.uk/software/SoftOld/paml4.3.tar.gz'
  version "4.3.0"
  sha256 "e1d91af7c1ab86851395a2fc7dd7e8c2ca641d53c2f159cf5399cf18c73f6aa0"

  depends_on "gcc@6" => :build

  fails_with gcc: "7"
  fails_with gcc: "8"
  fails_with gcc: "9"
  fails_with gcc: "10"

  def install
    cd 'src' do
      system 'make', "CC=#{ENV.cc}"
      bin.install %w(chi2 pamp mcmctree basemlg evolver yn00 baseml codeml)
    end
  end
end
