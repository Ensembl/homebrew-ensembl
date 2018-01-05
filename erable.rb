
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Erable < Formula
  desc "ERaBLE: Evolutionary Rates and Branch Lengths Estimation"
  homepage "https://www.atgc-montpellier.fr/erable/"
  url "http://www.atgc-montpellier.fr/download/sources/erable/erable1.0_Unix_Linux.tar.gz"
  sha256 "b03ff6f4d854a7cc064f392e428447932cdf1dba08c39712b88354d6ab1bef9a"
  version '1.0'

  def install
    cd "erable1.0_Unix_Linux" do
      system "./configure"
      system "make"
    end

    cd "erable1.0_Unix_Linux/src" do
      bin.install "erable"
    end

  end

  test do
    system "#{bin}/erable"
  end
end
