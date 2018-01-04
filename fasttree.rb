class Fasttree < Formula
  homepage "http://microbesonline.org/fasttree/"
  # doi "10.1371/journal.pone.0009490"
  # tag "bioinformatics"
  # tag origin homebrew-science
  # tag dervied

  url "http://microbesonline.org/fasttree/FastTree-2.1.8.c"
  sha256 "b172d160f1b12b764d21a6937c3ce01ba42fa8743d95e083e031c6947762f837"

  def install
    opts = %w[-O3 -finline-functions -funroll-loops]
    opts << "-DUSE_DOUBLE" 
    system ENV.cc, "-o", "FastTree", "FastTree-#{version}.c", "-lm", *opts
    bin.install "FastTree"
  end

  test do
    (testpath/"test.fa").write <<-EOF.undent
      >1
      LCLYTHIGRNIYYGSYLYSETWNTTTMLLLITMATAFMGYVLPWGQMSFWGATVITNLFSAIPYIGTNLV
      >2
      LCLYTHIGRNIYYGSYLYSETWNTGIMLLLITMATAFMGYVLPWGQMSFWGATVITNLFSAIPYIGTNLV
      >3
      LCLYTHIGRNIYYGSYLYSETWNTGIMLLLITMATAFMGTTLPWGQMSFWGATVITNLFSAIPYIGTNLV
    EOF
    assert_match(/1:0.\d+,2:0.\d+,3:0.\d+/, `#{bin}/FastTree test.fa`)
  end
end
