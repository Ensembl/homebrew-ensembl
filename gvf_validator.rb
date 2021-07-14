
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class GvfValidator < Formula
  desc "A syntactic validator for GVF files"
  homepage "http://www.sequenceontology.org/software/GAL.html"
  url "https://raw.githubusercontent.com/The-Sequence-Ontology/GAL/2bf7645f22119ad16ce3e568e71428f1087b8f52/bin/gvf_validator"
  sha256 "e1a09b1d14be1dd6d9d345f6cd78f984e1ae961089359e40241e5ce941019d5b"
  version "2bf7645"

  def install
    inreplace 'gvf_validator', '#!/usr/bin/perl', '#!/usr/bin/env perl'
    chmod 0555, 'gvf_validator'
    bin.install 'gvf_validator'
  end

  def caveats; <<~EOS
    You need the list of modules below in your Perl installation
    or in your PERL5LIB to be able to run gvf_validator
      - List::Util
      - List::MoreUtils
      - List::MoreUtils::XS

    EOS
  end

  test do
    system bin/'gvf_validator'
  end
end
