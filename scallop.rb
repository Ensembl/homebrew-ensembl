class Scallop < Formula
  desc "Scallop is an accurate reference-based transcript assembler"
  homepage "https://github.com/Kingsford-Group/scallop"
  version "0.10.5"
  url "https://github.com/Kingsford-Group/scallop/releases/download/v#{version}/scallop-#{version}.tar.gz"
  sha256 "b09e3c61f1b3b1da2a96d9d8429d80326a3bb14f5fe6af9b5e87570d4b86937a"

  depends_on "boost"
  depends_on "htslib"

  def install
    system './configure', "--prefix=#{prefix}"
    system 'make'
    system 'make', 'install'
  end

  def test
    assert_true(version, shell_output(system "#{opt_prefix}/bin/scallop", "--version").strip)
  end
end
