class Infernal10 < Formula
  desc "Search DNA databases for RNA structure and sequence similarities"
  homepage "http://eddylab.org/infernal/"
  # doi "10.1093/bioinformatics/btp157"
  # tag "bioinformatics"
  # tag origin homebrew-science
  # tag dervied

  version "1.0"
  url "http://eddylab.org/software/infernal/infernal-#{version}.tar.gz"
  sha256 "099d322c1aa1434f9a37379375f24e02cf4eceb102b12690ba1c65958a73999f"

  keg_only "Genebuild uses version #{version}"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    bin.mkpath
    system "make", "install"
  end

  test do
    system "#{bin}/cmsearch", "-h"
  end
end
