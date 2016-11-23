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

class Noisy < Formula
  desc 'Identify homo-plastic characters in multiple sequence alignments'
  homepage 'http://www.bioinf.uni-leipzig.de/Software/noisy/'
  url 'http://www.bioinf.uni-leipzig.de/Software/noisy/Noisy-1.5.12.tar.gz'
  sha256 'd0e388506147999aa8920cad03dc86dcd606c53ec8b14acafa5cd4957b96d609'
  version '1.5.12'

  def install
    system './configure', "--prefix=#{prefix}"
    system 'make'
    system 'make', 'install'
  end
end
