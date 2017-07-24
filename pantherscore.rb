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

class Pantherscore < Formula
  desc 'Score protein sequences against the PANTHER HMM library'
  homepage 'ftp://ftp.pantherdb.org/hmm_scoring/10.0/1.03/'
  url 'https://github.com/Ensembl/pantherScore/raw/master/pantherscore-1.03.zip'
  sha256 'dad3aea7290e52372fd048a9de9242f80a52888a238eefb48919592b89e280be'
  version '1.03'

  def install
    cd 'pantherScore1.03' do
      system 'wget', 'https://raw.githubusercontent.com/Ensembl/pantherScore/master/pantherScore1.03.patch'
      system 'patch', '-p1', '-i', 'pantherScore1.03.patch'
      inreplace 'pantherScore.pl', '#!/usr/bin/env perl', "#!/usr/bin/env perl
use lib '#{libexec}';"
      bin.install 'pantherScore.pl'
      libexec.install Dir['lib/*']
    end
  end
end
