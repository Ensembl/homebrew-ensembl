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

class Biobambam < Formula
  desc 'Tools for BAM processing'
  homepage 'https://github.com/gt1/biobambam'
  url 'https://github.com/gt1/biobambam/archive/0.0.191-release-20150401083643.tar.gz'
  sha256 '1f5be1c5b5c703c0b03969af7d8fa85da280044f131757c76b66e9021b67ae18'
  version '0.0.191'
  
  depends_on 'ensembl/ensembl/libmaus'
  
  def install
    libmaus = Formula["ensembl/ensembl/libmaus"].opt_prefix
    system './configure', "--prefix=#{prefix}", "--with-libmaus=#{libmaus}"
    system 'make'
    system 'make install'
  end
end
