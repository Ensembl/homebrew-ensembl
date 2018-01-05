
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Zopfli < Formula
  desc "New zlib (gzip, deflate) compatible compressor"
  homepage "https://github.com/google/zopfli" 
  url "https://github.com/google/zopfli/archive/zopfli-1.0.1.tar.gz"
  version "1.0.1"
  sha256 "29743d727a4e0ecd1b93e0bf89476ceeb662e809ab2e6ab007a0b0344800e9b4"
  head "https://github.com/google/zopfli.git", :using => :git

  def install
    # Makefile hardcodes gcc
    inreplace "Makefile", "gcc", ENV.cc
    system "make"
    bin.install "zopfli"
    if build.head?
      system "make", "zopflipng"
      bin.install "zopflipng"
    end
  end

  test do
    system "#{bin}/zopfli"
  end
end
