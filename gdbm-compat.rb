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
    pipe_output("#{bin}/gdbmtool --norc --newdb test", "store 1 2\nquit\n")
    assert File.exist?("test")
    assert_match /2/, pipe_output("#{bin}/gdbmtool --norc test", "fetch 1\nquit\n")
  end
end
