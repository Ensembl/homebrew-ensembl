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

class Mysqlnaga  < Formula
  desc 'mysqlnaga database copying utility'
  homepage 'https://github.com/EnsemblGenomes/mysqlnaga'
  url 'https://github.com/EnsemblGenomes/mysqlnaga/archive/v1.01.tar.gz'
  sha256 'fcc96aab2c4c0e46a7bcfd674be8877894491eaf11ce0235efb475d5962b847d'
  version '1.01'

  def install
    bin.install Dir["bin/*"]
  end
end

