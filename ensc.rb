class Ensc < Formula
  desc 'C bindings to Ensembl DBs and useful utils'
  homepage 'https://github.com/Ensembl/ensc-core'

  url 'https://github.com/Ensembl/ensc-core/archive/master.zip'
  sha256 '388575886468805da8f335ab7cb8a42bd55924eb7db81ea838ca3057c049960d'
  version '1.1.0'

  depends_on "mysql-connector-c"
  depends_on "ensembl/ensembl/htslib" => :recommended
  depends_on "libconfig" => :recommended

  def install 
    chdir 'src'
    system './autogen.sh'
    system "./configure --prefix=#{prefix}"
    system 'make'
    system 'make install'
    mv "#{prefix}/bin/fastasplit", "#{prefix}/bin/fastasplit_random"
  end

  test do
    system 'indicate'
    system 'testdbc'
    system 'translate'
  end

end
