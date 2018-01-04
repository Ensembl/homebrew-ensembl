class Exonerate24 < Formula
  desc "Pairwise sequence alignment of DNA and proteins"
  homepage "http://www.ebi.ac.uk/about/vertebrate-genomics/software/exonerate"
  # doi "10.1186/1471-2105-6-31"
  # tag "bioinformatics"
  # tag origin homebrew-science
  # tag dervied
  url "http://ftp.ebi.ac.uk/pub/software/vertebrategenomics/exonerate/exonerate-2.4.0.tar.gz"
  sha256 "f849261dc7c97ef1f15f222e955b0d3daf994ec13c9db7766f1ac7e77baa4042"

  depends_on "pkg-config" => :build
  depends_on "glib"
  conflicts_with 'homebrew/science/exonerate', :because => 'Both create the same binaries'
  
  keg_only "Must be a keg because otherwise it will clash with exonerate 2.2"

  def install
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
    system "#{bin}/exonerate} --version |grep exonerate"
  end
end
