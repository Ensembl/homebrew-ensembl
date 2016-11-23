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

  bottle do
    cellar :any
    sha256 "6d4886d7286af7ba1c7f4615bd1aab9af0a87a72d72767d8659b836649059a10" => :yosemite
    sha256 "0f9f835ab42cace506d68c8e90e47d5a558a0387297672592a1736057666c6bd" => :mavericks
    sha256 "7b0a93079fdbb1f063c940cb054dbba66267c06e6238fa40b5d96bbe67d77201" => :mountain_lion
  end

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
