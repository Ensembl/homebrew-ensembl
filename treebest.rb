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

class Treebest < Formula
  desc "Tree Building guided by Species Tree"
  homepage "https://github.com/Ensembl/treebest"
  url "https://github.com/Ensembl/treebest/archive/master.zip"
  sha256 "54e30fd2561ed3b2489440b62ea0050148da07be00a8abec9020e0e0b8315e10"
  version '88'

  def install
    system "make"
    bin.install 'treebest'
  end

  test do
    system "true"
  end
end
