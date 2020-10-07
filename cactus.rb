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

require 'fileutils'

class Cactus < Formula
  include Language::Python::Virtualenv

  desc 'Official home of genome aligner based upon notion of Cactus graphs'
  homepage 'https://github.com/ComparativeGenomicsToolkit/cactus'
  url 'https://github.com/ComparativeGenomicsToolkit/cactus/releases/download/v1.2.3/cactus-v1.2.3.tar.gz'
  sha256 '49e686f3381e3cf7f7a7696a8506fb1edadc21468f7ac56f8ea49e4d1618c8c2'
  head 'https://github.com/ComparativeGenomicsToolkit/cactus.git'

  bottle :unneeded

  depends_on 'pkg-config' => :build
  depends_on 'gcc@7' => :build
  depends_on 'hdf5' => 'enable-cxx'
  depends_on 'lzo'
  depends_on 'python3'

  def install
    ENV.deparallelize

    # create virtual environment
    venv = virtualenv_create(libexec, 'python3')

    # fix `pip` command because Cactus has nested-pip calls for sonLib
    inreplace 'setup.py',
              'pip',
              "#{libexec}/bin/pip"

    # Extracting python dependencies from setup.py because
    # the pip call Python.rb use --no-dependencies flag
    extract_python_dependencies(libexec)

    # Forcing the installment of cactus python (binary) dependencies without using
    # invidual package source code (.tar.gz) via `venv.pip_install resources`
    system "#{libexec}/bin/pip",
           'install',
           '-r',
           'toil-requirement.txt'

    # install cactus python dependencies
    venv.pip_install_and_link buildpath

    # Compilation adjustments
    inreplace 'submodules/sonLib/include.mk',
              '.h',
              '.h.inv'
    ENV['CXX_ABI_DEF'] = '-D_GLIBCXX_USE_CXX11_ABI=1'

    # Cactus compilation
    system 'make'

    # installation
    bin.install Dir['bin/*']
    lib.install Dir['lib/*.a']
    include.install Dir['include/*.h']
    share.install Dir['share/*']

    # create symbolic links for Cactus be able to use toil
    bin.install_symlink "#{libexec}/bin/_toil_worker"
    bin.install_symlink "#{libexec}/bin/_toil_kubernetes_executor"
    bin.install_symlink "#{libexec}/bin/_toil_mesos_executor"

    # copy python script from submodules to be included at VirtualEnv's lib
    path = `#{libexec}/bin/python3 -c \"import sysconfig; print(sysconfig.get_paths()['purelib'])\"`.strip
    FileUtils.cp_r 'submodules/hal',
                   path
  end

  private def extract_python_dependencies(libexec)
    wrapper = 'from distutils.core import run_setup;
    result = run_setup("setup.py", stop_after="init");
    f = open("toil-requirement.txt","a");
    f.write("\n".join(result.install_requires));
    f.close();'
    File.write('toil-requirement.py', wrapper.split(/\s*;\s*/).join("\n"), mode: 'a')
    system "#{libexec}/bin/python3",
           'toil-requirement.py'
  end

  def caveats
    <<-EOS
      Cactus Python scripts are already configured to use Cactus' own virtualenv.
      If you need to use it, do this:

      source #{libexec}/bin/activate
      python3 -c "import hal"
      deactivate
      
    EOS
  end

  test do
    system "#{bin}/cactus", '--help'
  end
end
