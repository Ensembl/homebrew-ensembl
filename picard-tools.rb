class PicardTools < Formula
  desc 'Java tools to manipulate BAM/SAM/CRAM files'
  homepage 'https://broadinstitute.github.io/picard'

  url 'https://github.com/broadinstitute/picard/releases/download/2.6.0/picard.jar'
  sha256 '671d9e86e6bf0c28ee007aea55d07e2456ae3a57016491b50aab0fd2fd0e493b'
  version '2.6.0'

  def install
    lib.install "picard.jar"
  end

end
