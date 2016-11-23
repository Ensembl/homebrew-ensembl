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

class Semphy < Formula
  desc 'Structural EM Phylogenetic Reconstruction'
  homepage 'http://www.cs.huji.ac.il/labs/compbio/semphy/'
  url 'http://compbio.cs.huji.ac.il/semphy/semphy-2.0/semphy-2.0b3.tgz'
  version '2.0b3'
  sha256 'c57a834abd20596b682eec491532a2063618fc9f35821b528d35e388e2a666d6'


  def install
    #Manual in-replace as diff/patch did not work and created bad line terminators
    cd 'lib' do
      inreplace 'cmdline2EvolObjs.h', '"recognizeFormat.h"', "\"recognizeFormat.h\"
#include <cstdlib>"
      inreplace 'computeUpAlg.cpp', "<cassert>", "<cassert>
#include <cstdlib>"
      inreplace 'computeUpAlgFactors.cpp', "<cmath>", "<cmath>
#include <cstdlib>"
      inreplace 'errorMsg.cpp', "<errno.h>", "<errno.h>
#include <cstdlib>
#include <cstring>"
      inreplace 'seqContainerTreeMap.cpp', "seqContainerTreeMap.h\"", "seqContainerTreeMap.h\"
#include <cstdlib>"
    end
    inreplace 'programs/randGamma/randGamma.cpp', "<string>", "<cstring>"
    inreplace 'programs/rate4site/rate4site.cpp', "<iomanip>", "<iomanip>
#include <cstring>"
    inreplace 'programs/rate4site/rate4siteOptions.cpp', "<iostream>", "<iostream>
#include <cstdlib>
#include <getopt.h>"
    inreplace 'programs/semphy/semphyStep.cpp', 'someUtil.h"', "someUtil.h\"
#include <cstdlib>"
    inreplace 'programs/simulateSequance/simulateSequnce.cpp', '<string>', '<cstring>'
    inreplace 'programs/treeUtil/sametree.cpp', '"sametree_cmdline.h"', "\"sametree_cmdline.h\"
#include <cstdlib>"

    system 'make', 'all'
    system 'make', 'install'
    bin.install Dir['bin/*']
  end
end
