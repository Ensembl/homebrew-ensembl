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

class Phyldog < Formula
  desc "Simultaneously build gene and species trees when gene families have undergone duplications and losses"
  homepage "http://pbil.univ-lyon1.fr/software/phyldog/"
  url "git://dev.prabi.fr/phyldog", :using => :git, :revision => 'v2.0b1'
  version '2.0b1'

  depends_on 'cmake' => :build
  depends_on 'ensembl/ensembl/libpll'
  depends_on 'ensembl/ensembl/biopp'
  depends_on 'ensembl/ensembl/boost'
  
  patch :DATA

  def install
    biopp = Formula['ensembl/ensembl/biopp']
    boost = Formula['ensembl/ensembl/boost']
    libpll = Formula['ensembl/ensembl/libpll']

    mkdir 'build'
    args = [
      "-DCMAKE_INSTALL_PREFIX:PATH=#{prefix}",
      "-DCMAKE_LIBRARY_PATH='#{biopp.lib};#{libpll.lib};#{boost.lib}'",
      "-DCMAKE_INCLUDE_PATH='#{biopp.include};#{libpll.include};#{boost.include}'",
      "-DBoost_NO_BOOST_CMAKE=TRUE",
      "-DBoost_NO_SYSTEM_PATHS=TRUE",
      "-DBOOST_ROOT:PATHNAME=#{boost.prefix}",
      "-DBOOST_LIBRARYDIR=#{boost.lib}",
      "-DBoost_LIBRARY_DIRS:FILEPATH=#{boost.lib}",
    ]
    system 'cmake', *args
    system 'make'
    system 'make', 'install'
  end

  test do
    system 'false'
  end
end

__END__
diff --git a/tests/CMakeLists.txt b/tests/CMakeLists.txt
index ad98d5d..8cd3b1a 100755
--- a/tests/CMakeLists.txt
+++ b/tests/CMakeLists.txt
@@ -34,13 +34,15 @@ target_link_libraries(test_likelihoodEvaluator
   ${LIBS}
 )
 
-ADD_EXECUTABLE(test_SPRs test_SPRs.cpp ${PHYLDOG_SRCS})
-target_link_libraries(test_SPRs
-  ${Boost_SERIALIZATION_LIBRARY}
-  ${Boost_MPI_LIBRARY}
-  ${MPI_LIBRARIES}
-  ${PLL_LIBRARIES}
-  ${LIBS}
-)
+#ADD_EXECUTABLE(test_SPRs test_SPRs.cpp ${PHYLDOG_SRCS})
+#target_link_libraries(test_SPRs
+#  ${Boost_SERIALIZATION_LIBRARY}
+#  ${Boost_MPI_LIBRARY}
+#  ${MPI_LIBRARIES}
+#  ${PLL_LIBRARIES}
+#  ${LIBS}
+#)
+
+#install(TARGETS  test_SPRs test_likelihoodEvaluator DESTINATION tests)
+install(TARGETS test_likelihoodEvaluator DESTINATION tests)
 
-install(TARGETS  test_SPRs test_likelihoodEvaluator DESTINATION tests)
