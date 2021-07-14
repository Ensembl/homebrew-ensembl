
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class EnscAnnotationTools < Formula
  desc 'Utils for the Ensembl Genome Annotation System'
  homepage 'https://github.com/Ensembl/ensc-annotation-tools'

  version '0.2.0'
  url "https://github.com/Ensembl/ensc-annotation-tools/archive/master.zip"
  sha256 'cc01dd4452e43f161bacb9161939a2650f74641cb2d4718a6bdb4da18b8fea76'

  depends_on "ensembl/ensembl/ensc"
  depends_on "ensembl/external/percona-client"
  depends_on "ensembl/external/htslib131" => :recommended
  depends_on "libconfig" => :recommended
  depends_on 'libtool'

  def install 
    chdir 'src'
    system './autogen.sh'
    system "./configure --prefix=#{prefix}"
    system 'make'
    system 'make install'
  end

  test do
    system 'indicate'
    system 'translate'
  end

end
