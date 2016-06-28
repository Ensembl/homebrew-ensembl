class Bioperl169 < Formula
  homepage 'http://bioperl.org/'
  desc 'Perl library for bioinformatic applications'
  url 'https://github.com/bioperl/bioperl-live/archive/release-1-6-924.tar.gz'
  sha256 '547a65a1c083bd40345514893cf91491d49318f2290dd8d0a539b742327cbe25'
  version '1.6.924'

  def install
    libexec.install Dir['*']
  end
end
