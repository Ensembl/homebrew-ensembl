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

class Ktreedist < Formula
  desc 'Calculates the K tree score from one phylogenetic tree to another'
  homepage 'http://molevol.cmima.csic.es/castresana/Ktreedist.html'
  url 'http://molevol.cmima.csic.es/castresana/Ktreedist/Ktreedist_v1.tar.gz'
  sha256 'cb414bcd5309d13cc6dbe3a8d03db37dcae87dd221038285f865d42518a40402'
  version '1.0.0'

  def install
    inreplace 'Ktreedist.pl', '#!/usr/bin/perl', '#!/usr/bin/env perl'
    bin.install 'Ktreedist.pl'
    doc.install 'Documentation/Ktreedist_documentation.html'
  end
end
