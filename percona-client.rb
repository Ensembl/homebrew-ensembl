class PerconaClient < Formula
  desc "Drop-in MySQL replacement"
  homepage "https://www.percona.com"
  url "https://www.percona.com/downloads/Percona-Server-5.6/Percona-Server-5.6.36-82.1/source/tarball/percona-server-5.6.36-82.1.tar.gz"
  version "5.6.36-82.1"
  sha256 "bebab31321e17682bc23f0f1e95211f002ba2a24c21d9a7ce9821cbe2a1ba4ba"

  option "with-test", "Build with unit tests"

  depends_on "cmake" => :build
  if OS.mac?
    depends_on "pidof" unless MacOS.version >= :mountain_lion
  end
  depends_on "openssl"
  depends_on "readline" unless OS.mac?

  conflicts_with "mysql-connector-c",
    :because => "both install `mysql_config`"

  conflicts_with "mariadb", "mysql", "mysql-cluster",
    :because => "percona, mariadb, and mysql install the same binaries."
  conflicts_with "mysql-connector-c",
    :because => "both install MySQL client libraries"
  conflicts_with "mariadb-connector-c",
    :because => "both install plugins"
    conflicts_with "ensembl/ensembl/mysql-client",
    :because => "both install the same client libraries"

  # Where the database files should be located. Existing installs have them
  # under var/percona, but going forward they will be under var/mysql to be
  # shared with the mysql and mariadb formulae.
  def datadir
    @datadir ||= (var/"percona").directory? ? var/"percona" : var/"mysql"
  end

  def install
    # Don't hard-code the libtool path. See:
    # https://github.com/Homebrew/homebrew/issues/20185
    inreplace "cmake/libutils.cmake",
      "COMMAND /usr/bin/libtool -static -o ${TARGET_LOCATION}",
      "COMMAND libtool -static -o ${TARGET_LOCATION}"

    args = std_cmake_args + %W[
      -DMYSQL_DATADIR=#{datadir}
      -DSYSCONFDIR=#{etc}
      -DINSTALL_MANDIR=#{man}
      -DINSTALL_DOCDIR=#{doc}
      -DINSTALL_INFODIR=#{info}
      -DINSTALL_INCLUDEDIR=include/mysql
      -DINSTALL_MYSQLSHAREDIR=#{share.basename}/mysql
      -DWITH_SSL=yes
      -DDEFAULT_CHARSET=utf8
      -DDEFAULT_COLLATION=utf8_general_ci
      -DCOMPILATION_COMMENT=Homebrew
      -DCMAKE_FIND_FRAMEWORK=LAST
      -DCMAKE_VERBOSE_MAKEFILE=ON
    ]
    args << "-DWITH_EDITLINE=system" if OS.mac?

    # PAM plugin is Linux-only at the moment
    args.concat %w[
      -DWITHOUT_AUTH_PAM=1
      -DWITHOUT_AUTH_PAM_COMPAT=1
      -DWITHOUT_DIALOG=1
    ]

    # TokuDB is broken on MacOsX
    # https://bugs.launchpad.net/percona-server/+bug/1531446
    args.concat %w[-DWITHOUT_TOKUDB=1]

    # To enable unit testing at build, we need to download the unit testing suite
    if build.with? "test"
      args << "-DENABLE_DOWNLOADS=ON"
    else
      args << "-DWITH_UNIT_TESTS=OFF"
    end

    # Build with local infile loading support
    args << "-DENABLED_LOCAL_INFILE=1"

    # Do not build the server
    args << "-DWITHOUT_SERVER=1"

    system "cmake", *args
    system "make"
    system "make", "install"

    # Now create symbolic links to get around libperconaserver* being the shared library name
    Dir[lib+"/libperconaserver*"].each do | entry |
      new_entry = entry.sub(/libperconaserver(.+)/, /libmysql\1/);
      File.delete(new_entry) if File.exist?(new_entry)
      ln_s entry, new_entry
    end

    # Don't create databases inside of the prefix!
    # See: https://github.com/Homebrew/homebrew/issues/4975
    rm_rf prefix+"data"
  end

  test do
    system bin+'mysql', '--version'
  end
end
