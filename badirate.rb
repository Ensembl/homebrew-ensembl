
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Badirate < Formula
  desc "Phylogenetic estimations"
  homepage "http://www.ub.edu/softevol/badirate/"
  url "https://github.com/fgvieira/badirate/archive/7e32c1cdcaaa0de52abb65a9df251cce73a8886b.zip"
  sha256 "1819fda76d3819c11584b3176adf24b15175bf62827ecc8938e692879a2b6297"
  version '1.35'

  def install
    inreplace 'BadiRate.pl', 'use lib $FindBin::Bin."/lib";', 'use lib $FindBin::Bin."/../libexec";';
    bin.install 'BadiRate.pl'
    libexec.install Dir['lib/*']
  end
end
