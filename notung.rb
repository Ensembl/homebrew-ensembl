
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Notung < Formula
  desc 'Notung and reconciliation with gene duplication, loss, horizontal transfer, and incomplete lineage sorting'
  homepage 'http://goby.compbio.cs.cmu.edu/Notung'
  url 'http://goby.compbio.cs.cmu.edu/Notung/distributions/Notung-2.6.zip'
  sha256 '23a42e7e464be363a48531a22b11a17a320454f6895c0e0c8c37419bd41b1311'
  version '2.6.0'

  def install
    libexec.install 'Notung-2.6.jar'
    doc.install 'Manual-2.6.pdf'
  end
end
