class Wiggletools < Formula
  desc "Basic, efficient and lazy evaulators on the genome"
  homepage "https://github.com/Ensembl/WiggleTools"
  url "https://github.com/Ensembl/WiggleTools/archive/v1.1.tar.gz"
  sha256 "201ee53e8ef67ec20043e26e8deab3f254219e0e0262d26e855ffe5041f63051"

  depends_on "andrewyatz/ensembl/kent"
  depends_on "gsl"
  depends_on 'andrewyatz/ensembl/tabix-lib'

  def install
    tabix_lib = Formula["andrewyatz/ensembl/tabix-lib"]
    kent = Formula["andrewyatz/ensembl/kent"]

    # remove -ltinfo. Not needed on this OS. It's in ncurses
    inreplace "samtools/Makefile", "-ltinfo", ""
    # Need to point to the right lib locations as linuxbrew/us have placed things
    inreplace "src/Makefile", "-L${KENT_SRC}/lib/${MACHTYPE}", "-L${KENT_SRC}/inc"
    inreplace "src/Makefile", "${KENT_SRC}/lib/local/jkweb.a", "${KENT_SRC}/lib/${MACHTYPE}/jkweb.a"
    args = ["TABIX_SRC=#{tabix_lib.prefix}", "KENT_SRC=#{kent.prefix}"]
    args << "MACHTYPE=#{`uname -m`.chomp}"
    system "make", *args
    bin.install Dir['bin/*']
    lib.install 'lib/libwiggletools.a'
  end

  test do
    system "make", "test"
  end
end
