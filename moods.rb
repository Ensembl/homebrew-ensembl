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

class Moods < Formula
  desc "MOODS - Motif Occurrence Detection Suite"
  homepage "https://github.com/jhkorhonen/MOODS"
 
  version '1.9.3'
  sha256 "79d9ffe8acb7d32182dd190bfd55ad9e3170d1f69ab53ee7e243d2c1449f50d4"
  url "https://github.com/jhkorhonen/MOODS/releases/download/v#{version}/MOODS-python-#{version}.tar.gz"

  depends_on "python" 
  def install
    system "python", *Language::Python.setup_install_args(libexec)    
    system "python setup.py install"
    bin.install "scripts/moods_dna.py"
    doc.install "readme.MD"
    doc.install "COPYING.GPLv3"
    doc.install "COPYING.BIOPYTHON"
    doc.install "PKG-INFO"
    doc.install "scripts/example-data"
  end

  test do
    system "moods_dna.py -m #{doc}/example-data/matrices/*.{pfm,adm} -s #{doc}/example-data/seq/chr1-5k-55k.fa -p 0.0001"
  end
end
