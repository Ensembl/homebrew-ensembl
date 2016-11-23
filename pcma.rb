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

class Pcma < Formula
  homepage "http://prodata.swmed.edu/pcma/pcma.php"
  url 'http://prodata.swmed.edu/download/pub/PCMA/pcma.tar.gz'
  version '2.0'
  sha256 '4b92d412126d393baa3ede501cafe9606ada9a66af6217d56befd6ec2e0c01ba'

  def install
    system "make", "pcma"
    bin.install 'pcma'
  end

end
