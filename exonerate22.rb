class Exonerate22 < Formula
  desc "Pairwise sequence alignment of DNA and proteins"
  homepage "http://www.ebi.ac.uk/about/vertebrate-genomics/software/exonerate"
  # doi "10.1186/1471-2105-6-31"
  # tag "bioinformatics"
  url "http://ftp.ebi.ac.uk/pub/software/vertebrategenomics/exonerate/exonerate-2.2.0.tar.gz"
  sha256 "0ea2720b1388fa329f889522f43029b416ae311f57b229129a65e779616fe5ff"

  depends_on "pkg-config" => :build
  depends_on "glib"

  def install
    # Fix the following error. This issue is fixed upstream in 2.4.0.
    # /usr/bin/ld: socket.o: undefined reference to symbol 'pthread_create@@GLIBC_2.2.5'
    # /lib/x86_64-linux-gnu/libpthread.so.0: error adding symbols: DSO missing from command line
    inreplace "configure", 'LDFLAGS="$LDFLAGS -lpthread"', 'LIBS="$LIBS -lpthread"' unless build.devel?

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    ENV.deparallelize
    system "make"
    system "make", "install"

    #UNCOMMENT TO CREATE VERSIONED BINARIES
    #
    #Dir["#{bin}/*"].each do |entry|
    #  newEntry = entry+"-"+version
    #  mv entry, newEntry
    #end

    #Dir["#{man1}/*"].each do |entry|
    #  newEntry = entry.sub(/\.1/, '-'+version+'.1')
    #  mv entry, newEntry
    #end
  end

  test do
    system "#{bin}/exonerate-#{version} --version |grep exonerate"
  end
end
