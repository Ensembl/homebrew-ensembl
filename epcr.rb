
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Epcr < Formula
  desc "In-silico PCR from NCBI"
  homepage "https://sourceforge.net/projects/simulatepcr/"

  url "ftp://ftp.ncbi.nlm.nih.gov/pub/schuler/e-PCR/e-PCR-2.3.12-1-src.tar.gz"
  sha256 "92613a09cbba3eab66916488063b56e2a3b50a82e5308b1731b6b90d232b8275"

  env :std

  def install
    ENV.deparallelize
    ENV.delete('CFLAGS')
    ENV.delete('CXXFLAGS')
    ENV.delete('LDFLAGS')
    system 'make links depend all OPTIMIZE=6'
    bin.install %w(e-PCR re-PCR famap fahash)
  end

  test do
    assert_match "amplicon", shell_output("#{bin}/simulate_PCR 2>&1", 255)
  end
end
