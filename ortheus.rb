
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Ortheus < Formula
  desc 'Probabilistic method for the inference of ancestor (aka tree) alignments'
  homepage 'http://hgwdev.cse.ucsc.edu/~benedict/code/Ortheus.html'
  url 'https://github.com/benedictpaten/ortheus.git', :using => :git
  version '0.5.0'
  revision 1

  depends_on 'ensembl/ensembl/sonlib'
  depends_on 'ensembl/ensembl/semphy'

  # Patch needed until the pull-request is accepted
  patch :DATA

  def install
    sonlib = Formula['ensembl/ensembl/sonlib']
    ENV.deparallelize
    inreplace 'include.mk', '${rootPath}../sonLib', "#{sonlib.prefix}"
    inreplace 'include.mk', '-I ${sonLibPath}', "-I #{sonlib.include}"
    inreplace 'include.mk', '${sonLibRootPath}/include.mk', "#{sonlib.prefix}/sonLib/include.mk"

    ENV["PYTHONPATH"] = sonlib.prefix
    ENV["PATH"] = "#{buildpath}/bin"+':'+ENV["PATH"]
    system 'make'
    cd 'bin' do
      bin.install %w(ortheus_core Ortheus.py)
    end
    (prefix+'ortheus').mkpath
    (prefix+'ortheus').install Dir['*']
  end
end
__END__
diff --git a/old/tree.py b/old/tree.py
index 9d085f1..1bcc9a4 100644
--- a/old/tree.py
+++ b/old/tree.py
@@ -709,7 +709,7 @@ def calculateProbableRootOfGeneTree(speciesTree, geneTree, processID=lambda x :
     #run dup calc on each tree
     #return tree with fewest number of dups
     if geneTree.traversalID.midEnd <= 3:
-        return (0, 0, geneTree)
+        return (geneTree, 0, 0)
     checkGeneTreeMatchesSpeciesTree(speciesTree, geneTree, processID)
     l = []
     def fn(tree):
