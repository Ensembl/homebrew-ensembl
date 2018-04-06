
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Maftools < Formula
  desc 'Bioinformatics tools for dealing with Multiple Alignment Format (MAF) files.'
  homepage 'https://github.com/dentearl/mafTools'
  url 'https://github.com/dentearl/mafTools.git', :using => :git
  version '0.1'

  keg_only "mafFilter conflicts with kent"
  
  depends_on "python@2" if MacOS.version <= :snow_leopard
  #depends_on "ensembl/ensembl/sonlib"
  
  # Patch needed until the pull-request is accepted
  patch :DATA

  resource "numpy" do
    url "https://pypi.python.org/packages/e0/4c/515d7c4ac424ff38cc919f7099bf293dd064ba9a600e1e3835b3edefdb18/numpy-1.11.1.tar.gz"
    sha256 "dc4082c43979cc856a2bf352a8297ea109ccb3244d783ae067eb2ee5b0d577cd"
  end

  resource "scipy" do
    url "https://files.pythonhosted.org/packages/01/a1/dce70d47377d662aa4b0895df8431aee92cea6faefaab9dae21b0f901ded/scipy-0.18.0.tar.gz"
    sha256 "f01784fb1c2bc246d4211f2482ecf4369db5abaecb9d5afb9d94f6c59663286a"
  end

  def install
    ENV.deparallelize
    system 'make all'
    prefix.install Dir['*']
  end
  test do
    system "#{bin}/mafValidator.py --version"
  end
end
__END__
diff --git a/mafExtractor/Makefile b/mafExtractor/Makefile
index 2a2821b..500f92f 100644
--- a/mafExtractor/Makefile
+++ b/mafExtractor/Makefile
@@ -22,12 +22,12 @@ src/buildVersion.c: ${sources} ${dependencies}
 
 ${bin}/mafExtractor: src/mafExtractor.c ${dependencies} ${API}
 	mkdir -p $(dir $@)
-	${cxx} ${cflags} -O3 $< ${API} -o $@.tmp
+	${cxx} ${cflags} -O3 $< ${API} -o $@.tmp -lm
 	mv $@.tmp $@
 
 test/mafExtractor: src/mafExtractor.c ${dependencies} ${testAPI}
 	mkdir -p $(dir $@)
-	${cxx} ${cflags} -g -O0 $< ${testAPI} -o $@.tmp
+	${cxx} ${cflags} -g -O0 $< ${testAPI} -o $@.tmp -lm
 	mv $@.tmp $@
 
 %.o: %.c %.h
