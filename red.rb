# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Red < Formula
  desc "Red (REpeat Detector): an intelligent, rapid, accurate tool for detecting repeats de-novo on the genomic scale."
  homepage "http://toolsmith.ens.utulsa.edu/"
  url "http://toolsmith.ens.utulsa.edu/red/data/DataSet2Unix64.tar.gz"
  version "05.22.2015"
  sha256 "3be62e399b7e321b3e82da6e9e33d7af060d23e97d5fd22f8b3cfcc0d140f8bb"

  def install
    cd "redUnix64" do
      bin.install "Red"
    end
  end

  test do
    system "#{bin}/Red"
  end
end
