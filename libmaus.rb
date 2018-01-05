
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Libmaus < Formula
  desc 'libmaus'
  homepage 'https://github.com/gt1/libmaus'
  url 'https://github.com/gt1/libmaus/archive/0.0.196-release-20150326095654.tar.gz'
  sha256 'ab44d18ba34556415e1d7585c5b82cc5f833d912d67611dffc174576065d223d'
  version '0.0.196'
  
  def install
    system 'autoreconf', '-i', '-f'
    system './configure', "--prefix=#{prefix}"
    system 'make'
    system 'make install'
  end
end
