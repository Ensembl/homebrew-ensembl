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

class Bcftools < Formula
  desc "Tools (written in C using htslib) for manipulating VCF and BCF"
  homepage "http://www.htslib.org/"
  # doi "10.1093/bioinformatics/btp352"
  # tag "bioinformatics"

  url "https://github.com/samtools/bcftools/releases/download/1.3.1/bcftools-1.3.1.tar.bz2"
  sha256 "12c37a4054cbf1980223e2b3a80a7fdb3fd850324a4ba6832e38fdba91f1b924"
  
  def install
    system "make" 
    system 'make', "prefix=#{prefix}", 'install'
  end

  test do
    system "bcftools 2>&1 |grep -q bcftools"
  end
end
