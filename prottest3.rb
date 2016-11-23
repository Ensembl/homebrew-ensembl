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

class Prottest3 < Formula
  desc 'Selection of best-fit models of amino acid replacement'
  homepage 'https://github.com/ddarriba/prottest3'
  url 'https://github.com/ddarriba/prottest3/releases/download/3.4.2-release/prottest-3.4.2-20160508.tar.gz'
  sha256 'd5afd55972e5b9903942eab4f0273f9614848bf4b6747a7839d3c675dc9067e6'
  version '3.4.2'

  def install
    jarfile='prottest-3.4.2.jar'
    original='find . -name "prottest-3.*.jar" | sort | tail -n 1'
    replace="#{libexec}/#{jarfile}"
    inreplace 'prottest3', original, replace
    inreplace 'runXProtTestHPC.sh', original, replace
    inreplace 'prottest.properties', '= bin', "= #{libexec}/bin"
    
    bin.install 'prottest3', 'runXProtTestHPC.sh'
    libexec.install jarfile 
    libexec.install 'bin'
    libexec.install 'prottest.properties'
  end
end
