# Copyright [2016] EMBL-European Bioinformatics Institute
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class MysqlClient < Formula
  desc "Open source relational database management system minus the server"
  homepage "https://dev.mysql.com/doc/refman/5.6/en/"
  url "http://cdn.mysql.com/archives/mysql-5.6/mysql-5.6.33.tar.gz"
  sha256 "60776ec27d78b59f597e71738c5bcdea64dcba33c36fede320d5930320b1fef0"

  option "with-debug", "Build with debug support"

  depends_on "cmake" => :build
  depends_on "openssl"
  depends_on "homebrew/dupes/libedit"

  conflicts_with "mysql-cluster", "mariadb", "percona-server",
    :because => "mysql, mariadb, and percona install the same client binaries"
  conflicts_with "mysql-connector-c",
    :because => "both install MySQL client libraries"
  conflicts_with "mariadb-connector-c",
    :because => "both install plugins"

  fails_with :llvm do
    build 2326
    cause "https://github.com/Homebrew/homebrew/issues/issue/144"
  end

  def datadir
    var/"mysql"
  end

  def install
    # Reduce memory usage below 4 GB for Circle CI.
    ENV["MAKEFLAGS"] = "-j3" if ENV["CIRCLECI"]

    # Don't hard-code the libtool path. See:
    # https://github.com/Homebrew/homebrew/issues/20185
    inreplace "cmake/libutils.cmake",
      "COMMAND /usr/bin/libtool -static -o ${TARGET_LOCATION}",
      "COMMAND libtool -static -o ${TARGET_LOCATION}"

    # Build without compiler or CPU specific optimization flags to facilitate
    # compilation of gems and other software that queries `mysql-config`.
    ENV.minimal_optimization

    # -DINSTALL_* are relative to `CMAKE_INSTALL_PREFIX` (`prefix`)
    args = %W[
      -DMYSQL_DATADIR=#{datadir}
      -DINSTALL_INCLUDEDIR=include/mysql
      -DINSTALL_MANDIR=share/man
      -DINSTALL_DOCDIR=share/doc/#{name}
      -DINSTALL_INFODIR=share/info
      -DINSTALL_MYSQLSHAREDIR=share/mysql
      -DWITH_SSL=yes
      -DWITH_SSL=system
      -DDEFAULT_CHARSET=utf8
      -DDEFAULT_COLLATION=utf8_general_ci
      -DSYSCONFDIR=#{etc}
      -DCOMPILATION_COMMENT=Homebrew
      -DWITH_EDITLINE=system
      -DWITH_BOOST=boost
      -DWITH_UNIT_TESTS=OFF
      -DENABLED_LOCAL_INFILE=1
      -DWITHOUT_SERVER=1
    ]

    # Build with debug support
    args << "-DWITH_DEBUG=1" if build.with? "debug"

    system "cmake", ".", *std_cmake_args, *args
    system "make"
    system "make", "install"

    # Don't create databases inside of the prefix!
    # See: https://github.com/Homebrew/homebrew/issues/4975
    rm_rf prefix/"data"
  end

  test do
    system bin+'mysql', '--version'
  end
end