class Augustus < Formula
  desc "predict genes in eukaryotic genomic sequences"
  homepage "http://bioinf.uni-greifswald.de/augustus/"
  # doi "10.1093/nar/gkh379"
  # tag "bioinformatics"

  url "http://bioinf.uni-greifswald.de/augustus/binaries/augustus-3.2.2.tar.gz"
  mirror "http://bioinf.uni-greifswald.de/augustus/binaries/old/augustus-3.2.2.tar.gz"
  sha256 "bb36fcaaaab32920908e794d04e6cb57a0c61d689bfbd31b9b6315233ea3559e"

  depends_on "bamtools"
  depends_on "ensembl/ensembl/boost"
  #These 3 needed for CGP
  depends_on "gsl"
  depends_on "lp_solve"
  depends_on "suite-sparse"

  def install
    args = []
    # Turns on CGP
    args << "COMPGENEPRED=true"

    system "make", "-C", "auxprogs/filterBam/src", "BAMTOOLS=#{Formula["bamtools"].opt_include}/bamtools", *args
    system "make", "INCLUDES=#{Formula["bamtools"].opt_include}/bamtools", *args

    rm_r %w[include src]
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  def caveats; <<-EOS.undent
    Set the environment variable AUGUSTUS_CONFIG_PATH:
      export AUGUSTUS_CONFIG_PATH=#{opt_prefix}/libexec/config
    EOS
  end

  test do
    system "#{bin}/augustus", "--version"
  end
end