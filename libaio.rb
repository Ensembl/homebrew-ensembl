class Libaio < Formula
  desc 'Native Asynchronous I/O interface library'
  homepage 'https://git.fedorahosted.org/cgit/libaio.git'
  url 'https://git.fedorahosted.org/cgit/libaio.git/snapshot/libaio-0.3.110-1.tar.gz'
  sha256 '5c69f43b71d0979b870f49a6cb9e2547ae2344575d8428698ebf5fde13b33529'
  version '0.3.110-1'

  def install
    system 'make', "prefix=#{prefix}", 'install'
  end
end

