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

class Fasttree < Formula
  homepage "http://microbesonline.org/fasttree/"
  # doi "10.1371/journal.pone.0009490"
  # tag "bioinformatics"

  url "http://microbesonline.org/fasttree/FastTree-2.1.8.c"
  sha256 "b172d160f1b12b764d21a6937c3ce01ba42fa8743d95e083e031c6947762f837"

  def install
    opts = %w[-O3 -finline-functions -funroll-loops]
    opts << "-DUSE_DOUBLE" 
    system ENV.cc, "-o", "FastTree", "FastTree-#{version}.c", "-lm", *opts
    bin.install "FastTree"
  end

  test do
    (testpath/"test.fa").write <<-EOF.undent
      >1
      LCLYTHIGRNIYYGSYLYSETWNTTTMLLLITMATAFMGYVLPWGQMSFWGATVITNLFSAIPYIGTNLV
      >2
      LCLYTHIGRNIYYGSYLYSETWNTGIMLLLITMATAFMGYVLPWGQMSFWGATVITNLFSAIPYIGTNLV
      >3
      LCLYTHIGRNIYYGSYLYSETWNTGIMLLLITMATAFMGTTLPWGQMSFWGATVITNLFSAIPYIGTNLV
    EOF
    assert_match(/1:0.\d+,2:0.\d+,3:0.\d+/, `#{bin}/FastTree test.fa`)
  end
end
