
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
