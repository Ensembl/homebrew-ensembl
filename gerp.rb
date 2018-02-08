
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Gerp < Formula
  desc 'Identification of constrained elements'
  homepage "http://mendel.stanford.edu/SidowLab/downloads/gerp"
  url "http://mendel.stanford.edu/SidowLab/downloads/gerp/GERPv2.1b_20080211.tar.gz"
  sha256 "0053c47e4ace5ede83959d70ddbffad94e81ccbe6392ac3a4a389e0700e90ce0"
  revision 1

  patch :DATA
  def install
    system "make"
    bin.install 'gerpcol', 'gerpelem'
  end

  test do
    system "#{bin}/gerpcol"
  end
end
__END__
diff --git a/etree.cc b/etree.cc
index dc2b708..98c8cfc 100644
--- a/etree.cc
+++ b/etree.cc
@@ -25,6 +25,7 @@
 #include <iostream>
 #include <fstream>
 #include <string>
+#include <cstdlib>
 
 ETree::ETree(string filename) {
   ifstream ifs(filename.c_str());
diff --git a/gerpcol.cc b/gerpcol.cc
index 6513d97..b833cef 100644
--- a/gerpcol.cc
+++ b/gerpcol.cc
@@ -25,6 +25,7 @@
 #include <string>
 #include <map>
 #include <cmath>
+#include <cstdlib>
 
 #include "etree.h"
 #include "emodel.h"
diff --git a/gerpelem.cc b/gerpelem.cc
index 6f67c9b..e3f54ac 100644
--- a/gerpelem.cc
+++ b/gerpelem.cc
@@ -27,6 +27,7 @@
 #include <ctime>
 #include <algorithm>
 #include <cmath>
+#include <cstring>
 
 #include "Mseq.h"
 #include "MIter.h"
diff --git a/gerpelem.cc b/gerpelem.cc
index e3f54ac..dd4c94e 100644
--- a/gerpelem.cc
+++ b/gerpelem.cc
@@ -245,6 +245,11 @@ void computeP(Vec<pos> &a, Vec<elem> &found, Vec<elem> sfound[],
   }
 
   int n = MAX_LEN * SC_RANGE;
+  long true_size = 2 * (long)MAX_LEN * (long)SC_RANGE;
+  if ((2 * n) != true_size) {
+    cerr << "The matrix is too big (" << true_size << " elements) and is causing an integer overflow. Aborting !" << endl;
+    exit(1);
+  }
   double *p = new double[2 * n];
   double *gp = new double[2 * n];
   memset(p, 0, 2 * n * sizeof(double));
