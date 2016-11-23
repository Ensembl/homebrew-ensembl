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

class Badirate < Formula
  desc "Phylogenetic estimations"
  homepage "http://www.ub.edu/softevol/badirate/"
  url "http://www2.ub.es/softevol/badirate/badirate-1.35.tar.gz"
  sha256 "9ec70a8a727e8bfb25e5fc58136db60f3c67b54de7fc729adda8ba58325d30b0"
  def install
    inreplace 'BadiRate.pl', 'use lib $FindBin::Bin."/lib";', 'use lib $FindBin::Bin."/../libexec";';
    bin.install 'BadiRate.pl'
    libexec.install Dir['lib/*']
  end
end
