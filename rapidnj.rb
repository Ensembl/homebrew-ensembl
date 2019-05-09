
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
  sha256 "80a30a42cb5390920b4dd2132801083ae67146f9821807b40a4ee9160292e070"

  def install
    inreplace 'src/distanceCalculation/KimuraDistance.cpp', '#ifdef __SSE4_2__', '#ifdef _DISABLE_THIS_'
    system "make"

    cd "bin" do
      bin.install "rapidnj"
    end
  end

  test do
    system "#{bin}/rapidnj"
  end
end
