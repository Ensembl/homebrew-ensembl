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

class Blimps < Formula
  homepage "ftp://ftp.ncbi.nih.gov/repository/blocks/unix/blimps"
  url "ftp://ftp.ncbi.nih.gov/repository/blocks/unix/blimps/blimps-3.9.tar.gz"
  sha256 "7dfc62c35055a1f7e5091ef9a719184282f7780f8f360084d4035982d4dd18df"

  depends_on 'bison'

  keg_only 'Because we do not know about letting this binary out'
  def install
    if OS.linux?
      target = 'Linux'
    elsif OS.mac?
      target = 'OSX'  
    else
      onoe 'Cannot understand the current OS'
    end
    #had to remove static declarations from
    # - format_block.c
    # - papssm.c
    # - pssmdist.c
    # Also had to do some other modifications including
    # - format_block.c: replace the local function resize_block_sequences with resize_block_sequences_local as it clashed with lblimps 
    rmtree Dir['bin/*']
    rmtree Dir['lib/*']
    cd 'blimps' do
      %w(format_block.c papssm.c pssmdist.c).each do |f|
        inreplace f, 'static', ''
      end
      inreplace 'format_block.c', 'resize_block_sequences', 'resize_block_sequences_local'
      mv "Makefile.#{target}", 'Makefile'
      inreplace 'Makefile', '/usr/bin/gcc', ENV['CC']
      inreplace 'Makefile', '-O2', '-O2 -std=c99'
      inreplace 'Makefile', 'install: clean', 'install: '
      system 'make', '-j1', 'clean', 'depend'
      system 'make', '-j1', 'all', 'install'
    end
    bin.install Dir["bin/*"]
    lib.install "lib/libblimps.a"
    include.install Dir['include/*']
    prefix.install 'docs' 
  end

  test do
    system 'false'
  end
end
