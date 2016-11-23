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

class BlastLegacy < Formula
  homepage "http://blast.ncbi.nlm.nih.gov/Blast.cgi?CMD=Web&PAGE_TYPE=BlastDocs&DOC_TYPE=Download"
  # tag "bioinformatics"
  # doi "10.1093/nar/25.17.3389"

  if OS.mac?
    url "ftp://ftp.ncbi.nlm.nih.gov/blast/executables/legacy/2.2.26/blast-2.2.26-universal-macosx.tar.gz"
    sha256 "eabad6b37ded329a7edd14d650e0aedf7b88aa4bd1611a228d5191952d83f3b8"
  elsif OS.linux?
    url "ftp://ftp.ncbi.nlm.nih.gov/blast/executables/legacy/2.2.26/blast-2.2.26-x64-linux.tar.gz"
    sha256 "8a2f986cf47f0f7cbdb3478c4fc7e25c7198941d2262264d0b6b86194b3d063d"
  else
    onoe "Unsupported operating system"
  end

  def install
    File.rename("bin/rpsblast", "bin/rpsblast.legacy")
    File.rename("bin/seedtop", "bin/seedtop.legacy")
    prefix.install Dir["*"]
  end

  def caveats
    <<-EOS.undent
    Tools 'rpsblast' and 'seedtop' were installed as 'rpsblast.legacy' and 'seedtop.legacy'
    to avoid conflicts with the BLAST+ executables.
    EOS
  end

  test do
    assert_match "BLOSUM62", shell_output("blastall 2>&1", 1)
    assert_match "millions", shell_output("formatdb - 2>&1", 1)
  end
end
