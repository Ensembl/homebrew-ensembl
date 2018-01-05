
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class BioperlRun169 < Formula
  homepage 'http://bioperl.org/'
  desc 'Perl library for bioinformatic applications'
  url 'https://github.com/bioperl/bioperl-run/archive/release-1-6-9.tar.gz'
  sha256 'e93693e816ad65f03bebe769f0f5885ecbfeafb6c63e62619e2fa57a3778bd78'
  version '1.6.9'

  def install
    libexec.install Dir['*']
  end
end
