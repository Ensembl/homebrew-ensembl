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

class Genblast < Formula
  desc 'Splice aware aligner for transcript models'
  homepage 'http://genome.sfu.ca/genblast/'
  url 'http://genome.sfu.ca/genblast/latest/genblast_v139.zip'
  version '1.39'
  sha256 '7934ef446d9b2f8fa80a6b53a2f001e2531edf2a2749545390e739ffa878e8d4'

  def install
    system 'make', 'all'
    bin.install 'genblast'
    File.open((etc+'genblast.bash'), 'w') { |file| file.write("export PATH=#{bin}:$PATH
") }
  end

  test do
    system "#{bin}/genblast"
  end
end
