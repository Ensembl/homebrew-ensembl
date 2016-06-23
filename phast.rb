class Phast < Formula
  desc ' Phylogenetic analysis with space/time models'
  homepage 'https://github.com/CshlSiepelLab/phast'
  url 'https://github.com/CshlSiepelLab/phast/archive/v1.3.tar.gz'
  sha256 'db4e58b694274b08a5265630eb8c0620e84d10a49149929dddd5ef6f65924b2f'
  version '1.3'
  
  depends_on 'ensembl/ensembl/clapack'
  
  def install
    lapack = Formula['ensembl/ensembl/clapack'].opt_prefix
    inreplace 'src/Makefile', '${PWD}', "#{buildpath}/src"
    cd 'src' do
      system 'make', "CLAPACKPATH=#{lapack}", "PHAST=#{buildpath}"
    end
    bin.install Dir['bin/*']
    lib.install 'lib/libphast.a'
    prefix.install 'data'
  end
end
