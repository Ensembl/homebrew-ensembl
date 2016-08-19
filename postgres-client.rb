class PostgresClient < Formula
  desc "PostgreSQL client libraries and binaries"
  url "https://ftp.postgresql.org/pub/source/v9.5.4/postgresql-9.5.4.tar.gz"
  sha256 "31c2aa8b6de0e767a047a585a3dec762b1051d0041525497dd1579ba5a861e68"
  version '9.5.4'

  depends_on "openssl"
  depends_on "readline"
  depends_on "libxml2"
  depends_on "libxslt"
  depends_on "util-linux"

  def install 
    ENV.libxml2
    ENV["XML2_CONFIG"] = "xml2-config --exec-prefix=/usr"
    ENV.prepend "LDFLAGS", "-L#{Formula["openssl"].opt_lib} -L#{Formula["readline"].opt_lib}"
    ENV.prepend "CPPFLAGS", "-I#{Formula["openssl"].opt_include} -I#{Formula["readline"].opt_include}"

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
