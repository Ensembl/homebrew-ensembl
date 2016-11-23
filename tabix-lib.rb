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

class TabixLib < Formula
  desc "Legacy binding to the Tabix index format"
  homepage "https://github.com/samtools/tabix"
  url "https://github.com/samtools/tabix/archive/master.tar.gz"
  version '0.2.4'
  sha256 "3505356e143305fcfd6d92daee14b3c129cb1bbd1cc96ff741abdbd8b2ac62b5"

  def install
    system "make", "lib"
    prefix.install 'libtabix.a'
    prefix.install 'tabix.h'
  end

  test do
    system "false"
  end
end
