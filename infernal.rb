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

class Infernal < Formula
  desc "Search DNA databases for RNA structure and sequence similarities"
  homepage "http://eddylab.org/infernal/"
  # doi "10.1093/bioinformatics/btp157"
  # tag "bioinformatics"

  version "0.55"
  url "http://eddylab.org/software/infernal/infernal-0.55.tar.gz"
  sha256 "935a21b14b9fa1cc91e8c46a12443d19d0b1cd8a8f5a83c5aa878fab5ba87feb"

  keg_only "Genebuild uses version 0.55"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    bin.mkpath
    system "make", "install"
  end

  test do
    system "#{bin}/cmsearch", "-h"
  end
end
