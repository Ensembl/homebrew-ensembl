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

class Enredo < Formula
  desc 'Graph-based method to detect co-linear segments among multiple genomes'
  homepage 'https://github.com/jherrero/enredo'
  url 'https://github.com/jherrero/enredo.git', :using => :git
  version '0.5.0'

  def install
    inreplace 'src/link.h', '#include <vector>', "#include <vector>
#include <sys/types.h>"
    inreplace 'src/link.cpp', '#include <vector>', "#include <vector>
#include <sys/types.h>"
    system './configure', "--prefix=#{prefix}"
    system 'make'
    system 'make', 'install'
  end
end
