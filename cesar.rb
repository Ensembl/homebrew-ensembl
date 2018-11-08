
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Cesar < Formula
  desc "Coding Exon Structure Aware Realigner 2.0"
  homepage "https://github.com/hillerlab/CESAR2.0"
  url "https://github.com/hillerlab/CESAR2.0.git", :using => :git
  version "eee348664a912c8b0e570129b28366697add5d4e"

  def install
    system 'make'
    bin.install 'cesar'
  end
end
