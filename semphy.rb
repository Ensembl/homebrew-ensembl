class Semphy < Formula
  desc 'Structural EM Phylogenetic Reconstruction'
  homepage 'http://www.cs.huji.ac.il/labs/compbio/semphy/'
  url 'http://compbio.cs.huji.ac.il/semphy/semphy-2.0/semphy-2.0b3.tgz'
  version '2.0b3'
  sha256 'c57a834abd20596b682eec491532a2063618fc9f35821b528d35e388e2a666d6'


  def install
    #Manual in-replace as diff/patch did not work and created bad line terminators
    cd 'lib' do
      inreplace 'cmdline2EvolObjs.h', '"recognizeFormat.h"', "\"recognizeFormat.h\"\n#include <cstdlib>"
      inreplace 'computeUpAlg.cpp', "<cassert>", "<cassert>\n#include <cstdlib>"
      inreplace 'computeUpAlgFactors.cpp', "<cmath>", "<cmath>\n#include <cstdlib>"
      inreplace 'errorMsg.cpp', "<errno.h>", "<errno.h>\n#include <cstdlib>\n#include <cstring>"
      inreplace 'seqContainerTreeMap.cpp', "seqContainerTreeMap.h\"", "seqContainerTreeMap.h\"\n#include <cstdlib>"
    end
    inreplace 'programs/randGamma/randGamma.cpp', "<string>", "<cstring>"
    inreplace 'programs/rate4site/rate4site.cpp', "<iomanip>", "<iomanip>\n#include <cstring>"
    inreplace 'programs/rate4site/rate4siteOptions.cpp', "<iostream>", "<iostream>\n#include <cstdlib>\n#include <getopt.h>"
    inreplace 'programs/semphy/semphyStep.cpp', 'someUtil.h"', "someUtil.h\"\n#include <cstdlib>"
    inreplace 'programs/simulateSequance/simulateSequnce.cpp', '<string>', '<cstring>'
    inreplace 'programs/treeUtil/sametree.cpp', '"sametree_cmdline.h"', "\"sametree_cmdline.h\"\n#include <cstdlib>"

    system 'make', 'all'
    system 'make', 'install'
    bin.install Dir['bin/*']
  end
end
