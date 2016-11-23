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

class Quicktree < Formula
  desc "Efficient NJ implementation"
  homepage "http://www.sanger.ac.uk/science/tools/quicktree"
  url "ftp://ftp.sanger.ac.uk/pub/resources/software/quicktree/quicktree.tar.gz"
  sha256 "3b5986a8d7b8e59ad5cdc30bd7c7d91431909c25230e8fed13494f21337da6ef"
  version '1.1.0'

  def install
    system "make"
    bin.install 'bin/quicktree'
  end

  test do
    system "true"
  end
end
