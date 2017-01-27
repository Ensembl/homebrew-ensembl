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
  url 'https://github.com/EnsemblGenomes/mysqlnaga/archive/v1.0.tar.gz'
  sha256 '83a3585cb7d875fe62e740295e64ecdd15c7c81faea387cba4fd91ae090f86a4'
  version '1.0'

  def install
    bin.install Dir["bin/*"]
  end
end

