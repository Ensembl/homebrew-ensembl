
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Cafe < Formula
  desc "Computational Analysis of gene Family Evolution"
  homepage "https://hahnlab.github.io/CAFE/"
  url "https://github.com/hahnlab/CAFE/archive/v4.2.1.tar.gz"
  sha256 "c9f0bdb9071105c1d23162f355632cab1a017e5798b95042b86c04bae86ff4aa"
  version "4.2.1"

  depends_on "gcc"
  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    inreplace "cafe/cafe_commands.cpp",
      "std::abs",
      "fabs"
    system "autoreconf -i configure.ac"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    bin.install "release/cafe"
  end
  test do
      system "#{bin}/cafe"
  end
end
