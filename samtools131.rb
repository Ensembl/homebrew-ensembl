class Samtools131 < Formula
  desc "Tools (written in C using htslib) for manipulating next-generation sequencing data"
  homepage "http://www.htslib.org/"
  # doi "10.1093/bioinformatics/btp352"
  # tag "bioinformatics"
  # tag origin homebrew-science
  # tag dervied

  url "https://github.com/samtools/samtools/releases/download/1.3.1/samtools-1.3.1.tar.bz2"
  sha256 "6c3d74355e9cf2d9b2e1460273285d154107659efa36a155704b1e4358b7d67e"
  head "https://github.com/samtools/samtools.git"

  keg_only 'Old version set to 1.3.1'

  depends_on "homebrew/dupes/ncurses" unless OS.mac?
  depends_on "ensembl/ensembl/htslib131"

  def install
    htslib = Formula["ensembl/ensembl/htslib131"].opt_prefix
    if build.without? "curses"
      ohai "Building without curses"
      system "./configure", "--with-htslib=#{htslib}", "--without-curses"
    else
      system "./configure", "--with-htslib=#{htslib}"
    end

    system "make"

    bin.install "samtools"
    bin.install %w[misc/maq2sam-long misc/maq2sam-short misc/md5fa misc/md5sum-lite misc/wgsim]
    bin.install Dir["misc/*.pl"]
    lib.install "libbam.a"
    man1.install %w[samtools.1]
    (share+"samtools").install %w[examples]
    (include+"bam").install Dir["*.h"]
  end

  test do
    system "samtools 2>&1 |grep -q samtools"
  end
end
