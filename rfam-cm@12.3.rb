
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class RfamCmAT123 < Formula

  desc "Collection of RNA families, each represented by multiple sequence alignments, consensus secondary structures and covariance models (CMs)"
  homepage "http://rfam.xfam.org/"

  url "ftp://ftp.ebi.ac.uk/pub/databases/Rfam/12.3/Rfam.cm.gz"
  sha256 "84ef7279814828b6171bebc773f3eda0eecec81a5d39ef2ea941e6d25b6a87b1"
  version '12.3'

  def install
    prefix.install 'Rfam.cm'
  end
end
