
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class PostgresClient < Formula
  desc "PostgreSQL client libraries and binaries"
  url "https://ftp.postgresql.org/pub/source/v9.5.25/postgresql-9.5.25.tar.gz"
  sha256 "b7a900932f5a1e439956436b10a587bd9ee7023424e5fa7e8c483bff3940c334"
  version '9.5.4'

  depends_on "ensembl/external/openssl@1.0"
  depends_on "readline"
  depends_on "libxml2"
  depends_on "libxslt"
  depends_on "util-linux"
  depends_on "gcc@6"

  fails_with gcc: "7"
  fails_with gcc: "8"
  fails_with gcc: "9"
  fails_with gcc: "10"

  def install 
    ENV["XML2_CONFIG"] = "xml2-config --exec-prefix=/usr"
    ENV.prepend "LDFLAGS", "-L#{Formula["ensembl/external/openssl@1.0"].opt_lib} -L#{Formula["readline"].opt_lib}"
    ENV.prepend "CPPFLAGS", "-I#{Formula["ensembl/external/openssl@1.0"].opt_include} -I#{Formula["readline"].opt_include}"

    args = %W[
      --disable-debug
      --prefix=#{prefix}
      --datadir=#{HOMEBREW_PREFIX}/share/postgresql
      --libdir=#{lib}
      --sysconfdir=#{etc}
      --docdir=#{doc}
      --enable-thread-safety
      --with-libxml
      --with-libxslt
      --with-openssl
    ]

    args << "--with-uuid=e2fs"

    system "./configure", *args
    system "make"
    system "make", "-C", "src/bin", "install"
    system "make", "-C", "src/include", "install"
    system "make", "-C", "src/interfaces", "install"
    system "make", "-C", "doc", "install"

    test do
      system 'false'
    end
  end
end
