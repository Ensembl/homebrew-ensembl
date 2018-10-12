
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Ensc < Formula
  desc 'C bindings to Ensembl DBs'
  homepage 'https://github.com/Ensembl/ensc-core'

  version '1.3.1'
  url "https://github.com/Ensembl/ensc-core/archive/#{version}.zip"
  sha256 '8af37cbc92bb13eb147411bbe520bbbea09d3142e2d92edfe93c952bb145d7f6'

  depends_on "ensembl/external/percona-client"
  depends_on 'libtool'

  def install 
    chdir 'src'
    system './autogen.sh'
    system "./configure --prefix=#{prefix}"
    system 'make'
    system 'make install'
  end

end
