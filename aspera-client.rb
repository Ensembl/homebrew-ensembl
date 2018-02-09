
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class AsperaClient < Formula
  desc "Fast download client using the Aspera protocol"
  homepage "http://asperasoft.com"

  version "3.7.2"
  url "http://download.asperasoft.com/download/sw/cli/#{version}/aspera-cli-#{version}.354.010c3b8-linux-64-release.sh"
  sha256 "a8dda6d2159af442eaf1393d4bbc9991628d6fdd1582b4cce04441f770a9a517"

  def install
    inreplace "aspera-cli-#{version}.354.010c3b8-linux-64-release.sh", "INSTALL_DIR=~/.aspera", "INSTALL_DIR=#{buildpath}"
    system "sh", "aspera-cli-#{version}.354.010c3b8-linux-64-release.sh"
    bin.install Dir["cli/bin/*"]
    bin.install "cli/bin/.aspera_cli_conf"
    (prefix+'certs').mkpath
    (prefix+'certs').install Dir["cli/certs/*"]
    doc.install Dir["cli/docs/*"]
    (prefix+'etc').install Dir["cli/etc/*"]
    share.install Dir["cli/share/*"]
    prefix.install "cli/product-info.mf"
  end

  def caveats; <<~EOS
    You can find the file asperaweb_id_dsa.openssh in
      #{etc}/asperaweb_id_dsa.openssh
    EOS
  end

  test do
    system "#{bin}/ascp", "-A"
  end
end
