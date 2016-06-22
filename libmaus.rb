class Libmaus < Formula
  desc 'libmaus'
  homepage 'https://github.com/gt1/libmaus'
  url 'https://github.com/gt1/libmaus/archive/0.0.196-release-20150326095654.tar.gz'
  sha256 'ab44d18ba34556415e1d7585c5b82cc5f833d912d67611dffc174576065d223d'
  version '0.0.196'
  
  def install
    system 'autoreconf, '-i', '-f'
    system './configure', "--prefix=#{prefix}"
    system 'make'
    system 'make install'
  end
end
