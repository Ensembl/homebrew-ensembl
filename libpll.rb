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

class Libpll < Formula
  homepage "http://www.libpll.org/"
  url "http://www.libpll.org/Downloads/libpll-1.0.2.tar.gz"
  sha256 "64cb110237a454b9e36749634f07744d4ce12a7438cf5f143d6e73aec8b637c7"
  head "https://git.assembla.com/phylogenetic-likelihood-library.git"

  depends_on "libtool" => :build
  depends_on "automake" => :build
  depends_on "autoconf" => :build

  option "without-check", "Disable build-time checking (not recommended)"

  def install
    system "autoreconf", "-fvi"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "check" if build.with? "check"
    system "make", "install"
  end
end
