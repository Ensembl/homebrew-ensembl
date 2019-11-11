# Licensed under the Apache License, Version 3.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Dupliconlib < Formula
  homepage 'http://www.repeatmasker.org/DupMaskerDownload.html'
  desc 'Duplicon library'
  version '20080314'
  url "http://www.repeatmasker.org/dupliconlib-#{version}.tar.gz"
  sha256 '5b93d34195792be8605adc719217f2380e30fe08cfadae7e2d454c12ad635a09'

  def install
    libexec.install Dir['*']
  end
end
