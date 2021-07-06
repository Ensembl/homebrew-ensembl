# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Orthofinder < Formula
  include Language::Python::Shebang
  include Language::Python::Virtualenv

  desc "OrthoFinder: phylogenetic orthology inference for comparative genomics"
  homepage "https://davidemms.github.io/"
  url "https://github.com/davidemms/OrthoFinder/releases/download/2.5.2/OrthoFinder_source.tar.gz"
  sha256 "e0752b66866e23a11f0592e880fac5f67258f9cf926f926dec8849564c41b8f7"
  version "2.5.2"

  bottle :unneeded

  depends_on 'python@3'
  depends_on 'ensembl/external/diamond'
  depends_on 'ensembl/external/mcl'
  depends_on 'ensembl/external/fastme'

  def install
    venv = virtualenv_create(libexec, 'python3')
    system "#{libexec}/bin/pip", 'install', 'numpy', 'scipy'
    rewrite_shebang detected_python_shebang, 'orthofinder.py',
                                             'scripts_of/__main__.py',
                                             'scripts_of/consensus_tree.py',
                                             'scripts_of/files.py',
                                             'scripts_of/orthologues.py',
                                             'scripts_of/program_caller.py',
                                             'scripts_of/stag.py',
                                             'scripts_of/stride.py',
                                             'scripts_of/trim.py',
                                             'scripts_of/trees_msa.py',
                                             'tools/convert_orthofinder_tree_ids.py',
                                             'tools/make_ultrametric.py'
    # Remove local binaries so the homebrew ones are used instead
    system 'rm', '-rf', 'scripts_of/bin'
    bin.install "orthofinder.py" => "orthofinder"
    bin.install Dir['scripts_of']
    bin.install Dir['tools']
  end

  test do
    system "#{bin}/orthofinder", '-h'
  end
end
