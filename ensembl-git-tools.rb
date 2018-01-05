
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class EnsemblGitTools < Formula
  desc "Library of extended Git functions for working with Ensembl"
  homepage "https://github.com/ensembl/ensembl-git-tools"

  url "https://github.com/Ensembl/ensembl-git-tools/archive/1.0.6.tar.gz"
  sha256 "9f2d1859a0b9ad6889aaa505518170969d433c09dd1dece5a02f5ce177a9aaef"

  def install
    bin.install Dir["bin/*"]
    prefix.install "advanced_bin/"
    lib.install "lib/EnsEMBL"
    prefix.install "hooks"
  end

  test do
    system 'git-ensembl'
  end
end
