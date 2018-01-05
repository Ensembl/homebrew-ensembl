
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Probcons < Formula
  homepage 'http://probcons.stanford.edu/' 
  url 'http://probcons.stanford.edu/probcons_v1_12.tar.gz'
  version '1.12'
  sha256 'ecf3f9ab9ad47e14787c76d1c64aeea5533d4038c4be0236c00cdd79104cf383'

  def install
    inreplace 'SafeVector.h', 'size_t', 'std::size_t'
    inreplace 'CompareToRef.cc', '#include <string>', '#include <cstring>'
    inreplace 'ProjectPairwise.cc', '#include <string>', '#include <cstring>'
    inreplace 'Main.cc', '#include <string>', '#include <cstring>'
    inreplace 'Makefile', '-DVERSION="1.12"', '-DVERSION="1.12" -std=c++11'
    system "make"
    bin.install 'probcons'
  end

end
