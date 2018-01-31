
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
diff --git a/old/EstimateTree.py b/old/EstimateTree.py
index aa35889..95749bf 100644
--- a/old/EstimateTree.py
+++ b/old/EstimateTree.py
@@ -344,7 +344,7 @@ def estimateTreeAlign(seqFiles, outputTreeFile, treeArgs):
             j = origSeqFileOrder.index(seqFiles[i[0]])
             return "%s_%s" % (treeArgs.LEAF_SPECIES[j], str(i[0]))
         labelTree(tree, fn)
-        tree, dupCount, lossCount = calculateProbableRootOfGeneTree(speciesTree, tree, processID=lambda x : x.split("_")[0])
+        dupCount, lossCount, tree = calculateProbableRootOfGeneTree(speciesTree, tree, processID=lambda x : x.split("_")[0])
         def fn2(tree):
             if tree.internal:
                 fn2(tree.left)
