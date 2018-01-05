
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
  homepage 'https://git.fedorahosted.org/cgit/libaio.git'
  url 'https://git.fedorahosted.org/cgit/libaio.git/snapshot/libaio-0.3.110-1.tar.gz'
  sha256 '5c69f43b71d0979b870f49a6cb9e2547ae2344575d8428698ebf5fde13b33529'
  version '0.3.110-1'

  def install
    system 'make', "prefix=#{prefix}", 'install'
  end
end
