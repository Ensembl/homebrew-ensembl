class NinjaCluster < Formula
  desc 'Nearly Infinite Neighbor Joining Application'
  homepage 'https://github.com/TravisWheelerLab/NINJA'
  # tag 'bioinformatics'

  version '0.95'
  url "https://github.com/TravisWheelerLab/NINJA/archive/#{version}-cluster_only.tar.gz"
  sha256 '9ed2eb2d8fa72bf1d297185d9154cbe5b0b4d1f03984d950f4f4548ccc4c0d7c'

  def install
    cd 'NINJA' do
      system 'make all'
      bin.install 'Ninja'
    end
  end

  test do
    assert_match "Ninja - Version #{version}-cluster_only", shell_output("#{bin}/Ninja -h", 0)
  end
end
