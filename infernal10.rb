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

class Infernal10 < Formula
  desc "Search DNA databases for RNA structure and sequence similarities"
  homepage "http://eddylab.org/infernal/"
  # doi "10.1093/bioinformatics/btp157"
  # tag "bioinformatics"

  version "1.0"
  url "http://eddylab.org/software/infernal/infernal-#{version}.tar.gz"
  sha256 "099d322c1aa1434f9a37379375f24e02cf4eceb102b12690ba1c65958a73999f"

  keg_only "Genebuild uses version #{version}"

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
