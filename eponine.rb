class Eponine < Formula
  homepage 'http://www.sanger.ac.uk/science/tools/eponine'
  desc '?'
  url 'ftp://ftp.sanger.ac.uk/pub/resources/software/eponine/eponine-scan.jar'
  sha256 '4435e07abcfca1d1513ff6e7e162b1522a2a42ae1a07427dd4cad7966ffa6f99'
  version '1.0'

  resource 'eponine-tss2' do
    url 'ftp://ftp.sanger.ac.uk/pub/resources/software/eponine/eponine-tss2.xml'
    sha256 '5007a7b4effca86b50e07c2d88c2124275d65a7803f534e8998f054a2702df1b'
  end

  def install
    libexec.install 'eponine-scan.jar'
    resource("eponine-tss2").stage do
      libexec.install 'eponine-tss2.xml'
    end
  end
end
