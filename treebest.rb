
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Treebest < Formula
  desc "Tree Building guided by Species Tree"
  homepage "https://github.com/Ensembl/treebest"
  url "https://github.com/Ensembl/treebest/archive/ensembl_release_candidate_5.zip"
  sha256 "9b58573d26153eafdbab4af80d04418e7e9d0047ad5f70753bb8f0260dbfde09"
  version 'rc5'

  depends_on 'bison'
  depends_on 'flex'
  depends_on "gcc@6" => :build

  fails_with gcc: "7"
  fails_with gcc: "8"
  fails_with gcc: "9"
  fails_with gcc: "10"


  def install
    system "make", "CC=#{ENV.cc}"
    bin.install 'treebest'
  end

  test do
    system "true"
  end
end
