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

class Sonlib < Formula
  desc 'Small general purpose library for C and Python with focus on bioinformatics'
  homepage 'https://github.com/benedictpaten/sonLib'
  url 'https://github.com/benedictpaten/sonLib.git', :using => :git
  version '0.1'

  patch :DATA

  def install
    system 'make', 'all'
    lib.install Dir['lib/*.a']
    include.install Dir['lib/*.h']
    mkpath (prefix+'sonLib')
    (prefix+'sonLib').install Dir['*']
  end
end
__END__
diff --git a/include.mk b/include.mk
index d536d07..6472c36 100644
--- a/include.mk
+++ b/include.mk
@@ -41,17 +41,17 @@ endif
 # linker input files. See <http://stackoverflow.com/a/8266512/402891>.
 
 #Release compiler flags
-cflags_opt = -O3 -g -Wall --pedantic -funroll-loops -DNDEBUG 
+cflags_opt = -O3 -g -Wall --pedantic -funroll-loops -DNDEBUG -fPIC
 #-fopenmp
-cppflags_opt = -O3 -g -Wall -funroll-loops -DNDEBUG
+cppflags_opt = -O3 -g -Wall -funroll-loops -DNDEBUG -fPIC
 
 #Debug flags (slow)
-cflags_dbg = -Wall -O0 -Werror --pedantic -g -fno-inline -UNDEBUG -Wno-error=unused-result
-cppflags_dbg = -Wall -g -O0 -fno-inline -UNDEBUG
+cflags_dbg = -Wall -O0 -Werror --pedantic -g -fno-inline -UNDEBUG -Wno-error=unused-result -fPIC
+cppflags_dbg = -Wall -g -O0 -fno-inline -UNDEBUG -fPIC
 
 #Ultra Debug flags (really slow, checks for memory issues)
-cflags_ultraDbg = -Wall -Werror --pedantic -g -O1 -fno-inline -fno-omit-frame-pointer -fsanitize=address
-cppflags_ultraDbg = -g -O1 -fno-inline -fno-omit-frame-pointer -fsanitize=address
+cflags_ultraDbg = -Wall -Werror --pedantic -g -O1 -fno-inline -fno-omit-frame-pointer -fsanitize=address -fPIC
+cppflags_ultraDbg = -g -O1 -fno-inline -fno-omit-frame-pointer -fsanitize=address -fPIC
 
 #Profile flags
 cflags_prof = -Wall -Werror --pedantic -pg -O3 -g -Wno-error=unused-result
