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

class Emboss < Formula
  homepage "http://emboss.sourceforge.net/"
  url "ftp://emboss.open-bio.org/pub/EMBOSS/EMBOSS-6.6.0.tar.gz"
  mirror "http://mirrors.mit.edu/gentoo-distfiles/distfiles/EMBOSS-6.6.0.tar.gz"
  mirror "http://science-annex.org/pub/emboss/EMBOSS-6.6.0.tar.gz"
  sha256 "7184a763d39ad96bb598bfd531628a34aa53e474db9e7cac4416c2a40ab10c6e"

  option "with-embossupdate", "Run embossupdate after `make install`"

  depends_on "pkg-config" => :build
  depends_on "libpng"     => :recommended

  def install
    inreplace "Makefile.in", "$(bindir)/embossupdate", "" if build.without? "embossupdate"

    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --prefix=#{prefix}
      --mandir=#{man}
      --docdir=#{doc}
      --enable-64
      --with-thread
    ]
    args << "--without-x" if build.without? "x11"

    system "./configure", *args
    system "make", "install"
  end
end
