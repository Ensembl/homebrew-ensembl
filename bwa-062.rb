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

class Bwa062 < Formula
  desc "Burrow-Wheeler Aligner for pairwise alignment of DNA"
  homepage "https://github.com/lh3/bwa"
  # doi "10.1093/bioinformatics/btp324"
  # tag "bioinformatics"

  url "https://github.com/lh3/bwa.git", :using => :git, :revision => '0.6.2'
  version '0.6.2'

  keg_only 'bwa 0.6.2 creates binaries with the same name as all other bwa installs'
  
  def install
    inreplace 'Makefile', '-g -Wall -O2', '-std=gnu89 -g -Wall -O2'
    system "make"
    bin.install "bwa"
    man1.install "bwa.1"
  end

  test do
    (testpath/"test.fasta").write ">0
AGATGTGCTG
"
    system "#{bin}/bwa", "index", "test.fasta"
    assert File.exist?("test.fasta.bwt")
    system "#{bin}/bwa", "aln", "-f", "test.bwa", "test.fasta", "test.fasta"
    system "#{bin}/bwa", "samse", "-f", "test.sam", "test.fasta", "test.bwa", "test.fasta"
    assert File.exist?("test.sam");
  end
end
