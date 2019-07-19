
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Libaio < Formula
  desc 'Native Asynchronous I/O interface library'
  homepage 'https://pagure.io/libaio'
  version '0.3.110-1'
  url "https://pagure.io/libaio/archive/libaio-#{version}/libaio-libaio-#{version}.tar.gz"
  sha256 '2241532aeec68f816c66dc0c1c753bda5398ee0ff72189a71206cd87cf1026c0'

  def install
    system 'make', "prefix=#{prefix}", 'install'
  end
end
