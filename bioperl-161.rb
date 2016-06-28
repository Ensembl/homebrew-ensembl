class Bioperl161 < Formula
  homepage 'http://bioperl.org/'
  desc 'Perl library for bioinformatic applications'
  url 'https://github.com/bioperl/bioperl-live/archive/bioperl-release-1-6-1.tar.gz'
  sha256 'a7eb4bafd014ebd55462d7020fffa265ece764d8f5699723bc4493b2da04ece1'
  version '1.6.1'

  def install
    libexec.install Dir['*']
  end
end
