class Phast < Formula
  desc ' Phylogenetic analysis with space/time models'
  homepage 'https://github.com/CshlSiepelLab/phast'
  url 'https://github.com/CshlSiepelLab/phast/archive/v1.3.tar.gz'
  sha256 'f936897d80fba814ca30ed7671f4448ee1e5fde2f697ebf0d5ced74bf46e4972'
  version '1.3'
  
  depends_on :lapack
  
  def install
    lapack = Formula[:lapack].opt_prefix
    system 'make', 'install', "DESTDIR=#{prefix}", "CLAPACKPATH=#{lapack}"
  end
end
