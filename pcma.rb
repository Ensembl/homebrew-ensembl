class Pcma < Formula
  homepage "http://prodata.swmed.edu/pcma/pcma.php"
  url 'http://prodata.swmed.edu/download/pub/PCMA/pcma.tar.gz'
  version '2.0'
  sha256 '4b92d412126d393baa3ede501cafe9606ada9a66af6217d56befd6ec2e0c01ba'

  def install
    system "make", "pcma"
    bin.install 'pcma'
  end

end
