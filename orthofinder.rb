# frozen_string_literal: true

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
  include Language::Python::Virtualenv

  desc 'OrthoFinder: phylogenetic orthology inference for comparative genomics'
  homepage 'https://davidemms.github.io/'
  url 'https://github.com/davidemms/OrthoFinder/releases/download/2.5.4/OrthoFinder_source.tar.gz'
  sha256 'a735c81999e8e3026ad62536b14e5b0391c9fc632f872f99857936ac60003ba5'
  version '2.5.4'

  depends_on 'python@3'
  depends_on 'ensembl/external/diamond'
  depends_on 'ensembl/external/mcl'
  depends_on 'fastme'

  def install
    virtualenv_create(libexec, 'python3')
    system "#{libexec}/bin/pip", 'install', 'numpy', 'scipy'

    # detected_python_shebang won't work below because it will point to "#!/usr/local/opt/python@3.9/bin/python3"
    # and we need to point to "<linuxbrew_dir>/opt/orthofinder/libexec/bin/python3"
    # can't use built-in "rewrite_shebang" function because Travis uses a very old version of Linuxbrew
    files = ['orthofinder.py',
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
             'tools/make_ultrametric.py']
    inreplace files do |s|
      s.gsub! %r{^#! ?/usr/bin/(?:env )?python(?:[23](?:\.\d{1,2})?)?( |$)}, "#!#{opt_libexec}/bin/python3"
    end

    # Remove local binaries so the homebrew ones are used instead
    system 'rm', '-rf', 'scripts_of/bin'
    bin.install 'orthofinder.py' => 'orthofinder'
    bin.install Dir['scripts_of']
    bin.install Dir['tools']
  end

  test do
    system "#{bin}/orthofinder", '-h'
  end
end
