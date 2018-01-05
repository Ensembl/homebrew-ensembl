
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Rapidnj < Formula
  desc "RapidNJ: fast neighbour-joining trees"
  homepage "https://birc.au.dk/software/rapidnj/"
  url "http://users-birc.au.dk/cstorm/software/rapidnj/rapidnj-src-2.3.2.zip"
  sha256 "9245e84a0d0b412572571ac85dd4599f0b0417718aef687fa014ec119d67b67a"

  def install
    system "make"

    cd "bin" do
      bin.install "rapidnj"
    end
  end

  test do
    system "#{bin}/rapidnj"
  end
end
