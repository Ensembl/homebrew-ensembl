class Biobambam < Formula
  desc 'Tools for BAM processing'
  homepage 'https://github.com/gt1/biobambam'
  url 'https://github.com/gt1/biobambam/archive/0.0.191-release-20150401083643.tar.gz'
  sha256 '1f5be1c5b5c703c0b03969af7d8fa85da280044f131757c76b66e9021b67ae18'
  version '0.0.191'
  
  depends_on 'ensembl/ensembl/libmaus'
  
  def install
    libmaus = Formula["ensembl/ensembl/libmaus"].opt_prefix
    system './configure', "--prefix=#{prefix}", "--with-libmaus=#{libmaus}"
    system 'make'
    system 'make install'
  end
end
