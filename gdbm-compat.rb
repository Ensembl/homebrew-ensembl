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

class GdbmCompat < Formula
  desc "GNU database manager with compat layer"
  homepage "https://www.gnu.org/software/gdbm/"
  url "https://ftpmirror.gnu.org/gdbm/gdbm-1.12.tar.gz"
  mirror "https://ftp.gnu.org/gnu/gdbm/gdbm-1.12.tar.gz"
  sha256 "d97b2166ee867fd6ca5c022efee80702d6f30dd66af0e03ed092285c3af9bcea"

  def install

    args = %W[
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --enable-libgdbm-compat
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    pipe_output("#{bin}/gdbmtool --norc --newdb test", "store 1 2
quit
")
    assert File.exist?("test")
    assert_match /2/, pipe_output("#{bin}/gdbmtool --norc test", "fetch 1
quit
")
  end
end
