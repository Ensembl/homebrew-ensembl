class OracleDbd < Formula

  desc 'Perl module for accessing Oracle databases'
  homepage 'https://metacpan.org/release/DBD-Oracle'
  url 'https://cpan.metacpan.org/authors/id/P/PY/PYTHIAN/DBD-Oracle-1.74.tar.gz'
  sha256 '4a676ff28193303ea92f4660cd4889063480837a2c2a59a43744ac1e74b795d4'

  depends_on 'ensembl/moonshine/oracle-instant-client'
  depends_on 'ensembl/ensembl/libaio'

  def install
    oci = Formula['ensembl/moonshine/oracle-instant-client']
    system 'perl', 'Makefile.PL', '-m', "#{oci}/sdk/demo/demo.mk", '-l'
    system 'make'
    system 'make', 'install'
  end

  def caveats; <<-EOS.undent
    This package installs DBD::Oracle to your current Perl's library directory. 
    If you did not want to do this then do not run this program.
    EOS
  end
end
