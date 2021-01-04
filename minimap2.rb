# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Minimap2 < Formula
  desc "Minimap2 is a versatile sequence alignment program that aligns DNA or mRNA sequences against a large reference database."
  homepage "https://www.github.com/lh3/minimap2"
  url "https://github.com/lh3/minimap2/releases/download/v2.17/minimap2-2.17_x64-linux.tar.bz2"
  version "2.17"
  sha256 "fe97310cf9abc165de2e17d41b68ee5a1003be3ff742179edef38fcf8a089a47"

  def install
    bin.install "k8"
    bin.install "paftools.js"
    bin.install "minimap2"
  end

  test do
    system "#{bin}/k8"
    system "#{bin}/paftools.js"
    system "#{bin}/minimap2"
  end
end
