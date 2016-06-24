class Badirate < Formula
  desc "Phylogenetic estimations"
  homepage "http://www.ub.edu/softevol/badirate/"
  url "http://www2.ub.es/softevol/badirate/badirate-1.35.tar.gz"
  sha256 "9ec70a8a727e8bfb25e5fc58136db60f3c67b54de7fc729adda8ba58325d30b0"
  def install
    inreplace 'BadiRate.pl', 'use lib $FindBin::Bin."/lib";', 'use lib $FindBin::Bin."/../libexec";';
    bin.install 'BadiRate.pl'
    libexec.install Dir['lib/*']
  end
end

