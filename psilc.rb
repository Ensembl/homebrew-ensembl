class Psilc < Formula
  desc 'Pseudogene inference from Loss of Constraint'
  homepage 'http://www.imperial.ac.uk/people/l.coin'
  url 'https://workspace.imperial.ac.uk/medicine/Public/PWPs/lcoin/psilc1.21.zip'
  sha256 '8954375f43dcfc01f4270f55fa6597c17b4e64a5f7c74c1d2a2b1e765541fd70'
  version '1.26'

  def install
    libexec.install 'psilc.jar'
  end
end
