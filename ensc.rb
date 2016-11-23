# Copyright [2016] EMBL-European Bioinformatics Institute
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
  desc 'C bindings to Ensembl DBs and useful utils'
  homepage 'https://github.com/Ensembl/ensc-core'

  url 'https://github.com/Ensembl/ensc-core/archive/8a0feab034441203e5f81e9f6cfa27b9e24d9252.zip'
  sha256 '7d099851bc4975bf45c2e1d59af36acb216e0dd4fb390928ddb4e662abe94dfa'
  version '8a0feab'

  depends_on "ensembl/ensembl/mysql-client"
  depends_on "ensembl/ensembl/htslib" => :recommended
  depends_on "libconfig" => :recommended

  def install 
    chdir 'src'
    system './autogen.sh'
    system "./configure --prefix=#{prefix}"
    system 'make'
    system 'make install'
    mv "#{prefix}/bin/fastasplit", "#{prefix}/bin/fastasplit_random"
  end

  test do
    system 'indicate'
    system 'testdbc'
    system 'translate'
  end

end
