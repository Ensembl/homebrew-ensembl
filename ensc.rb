class Ensc < Formula
  desc 'C bindings to Ensembl DBs and useful utils'
  homepage 'https://github.com/Ensembl/ensc-core'

  url 'https://github.com/Ensembl/ensc-core/archive/8a0feab034441203e5f81e9f6cfa27b9e24d9252.zip'
  sha256 '7d099851bc4975bf45c2e1d59af36acb216e0dd4fb390928ddb4e662abe94dfa'
  version '8a0feab'

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
