class Interproscan < Formula

  desc 'Scan sequences (protein and nucleic) against InterPro signatures'
  homepage 'http://www.ebi.ac.uk/interpro/interproscan.html'
  url 'ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/5.19-58.0/interproscan-5.19-58.0-64-bit.tar.gz'
  sha256 'aca23a9461536f81b27081c0df70c7813fe20cfba19f084cf5ab45202c0eef84'

  resource 'panther-models' do
    url 'ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/data/panther-data-10.0.tar.gz'
    sha256 '231581055bd038312d67fa1adc90c721cd286b7c571f7b3314ee531bac4b9764'
  end

  def install
    prefix.install Dir['*']
    resource('panther-models').stage do
      (prefix+'data').mkdir
      (prefix+'data'+'panther').install '10.0'
    end
  end
end
