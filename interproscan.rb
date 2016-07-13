class Interproscan < Formula

  desc 'Scan sequences (protein and nucleic) against InterPro signatures'
  homepage 'http://www.ebi.ac.uk/interpro/interproscan.html'
  url 'ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/5.19-58.0/interproscan-5.19-58.0-64-bit.tar.gz'
  sha256 ''

  resource 'panther-models' do
    url 'ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/data/panther-data-10.0.tar.gz'
    sha256 ''
  end

  def install
    prefix.install Dir['*']
    resource('panther-models').stage do
      (prefix+'data').install 'panther'
    end
  end
end
