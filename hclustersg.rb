
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Hclustersg < Formula
  desc 'Hierarchically clustering on a sparse graph'
  homepage 'https://sourceforge.net/projects/treesoft/'
  url 'svn://svn.code.sf.net/p/treesoft/code/trunk', :using => :svn
  version '0.5.0'

  def install
    cd 'hcluster' do
      system 'make', "CXX=#{ENV.cxx}", "CFLAGS=-std=c++98"
      bin.install 'hcluster_sg'
    end
  end
end
