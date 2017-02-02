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

class R2r < Formula

  homepage "http://www.bioinf.uni-leipzig.de/~zasha/R2R/"
  # tag "bioinformatics"

  url "http://www.bioinf.uni-leipzig.de/~zasha/R2R/R2R-1.0.5.tgz"
  sha256 "c36859749cd40d59c4fd1dd9153e425984eeba8eb5d8ce1fbdcb8e1fdfa0f300"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    bin.install "src/r2r"
  end
end
