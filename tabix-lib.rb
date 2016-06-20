class TabixLib < Formula
  desc "Legacy binding to the Tabix index format"
  homepage "https://github.com/samtools/tabix"
  url "https://github.com/samtools/tabix/archive/master.tar.gz"
  version '0.2.4'
  sha256 "3505356e143305fcfd6d92daee14b3c129cb1bbd1cc96ff741abdbd8b2ac62b5"

  def install
    system "make", "lib"
    prefix.install 'libtabix.a'
    prefix.install 'tabix.h'
  end

  test do
    system "false"
  end
end
