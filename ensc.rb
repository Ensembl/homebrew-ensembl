class Ensc < Formula
  desc 'C bindings to Ensembl DBs and useful utils'
  homepage 'https://github.com/Ensembl/ensc-core'

  url 'https://github.com/Ensembl/ensc-core/archive/1.0.0.zip'
  sha256 'b05e9bc5950d07cd410b4eebf6354bb9ed3c8387afd97043109225a3db09a813'
  version '1.0.0'

  depends_on "ensembl/ensembl/mysql-client"
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
