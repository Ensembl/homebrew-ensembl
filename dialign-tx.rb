
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class DialignTx < Formula
  homepage "http://dialign-tx.gobics.de"
  url "http://dialign-tx.gobics.de/DIALIGN-TX_1.0.2.tar.gz"
  sha256 "fb3940a48a12875332752a298f619f0da62593189cd257d28932463c7cebcb8f"

  depends_on "gcc@6"

  fails_with gcc: "7"
  fails_with gcc: "8"
  fails_with gcc: "9"
  fails_with gcc: "10"

  def install
    cd 'source' do
      system "make", "CPPFLAGS=-O3 -funroll-loops -std=gnu89 -pedantic"
      bin.install 'dialign-tx'
    end
  end

end
