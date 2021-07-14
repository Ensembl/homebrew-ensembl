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
  url 'https://github.com/ComparativeGenomicsToolkit/cactus/releases/download/v1.3.0/cactus-v1.3.0.tar.gz'
  sha256 'dba6579006221ae7482ab8f1bedffb5684f34e98f3fc73aca049078fe2a059c8'
  head 'https://github.com/ComparativeGenomicsToolkit/cactus.git'

  bottle :unneeded

  depends_on 'hiredis' => :build
  depends_on 'hdf5' => 'enable-cxx'
  depends_on 'lzo'
  depends_on 'zlib' => :build
  depends_on 'python@3.8' => :build

  def install
    ENV.deparallelize

    # creating a virtual environment
    venv = virtualenv_create(libexec, 'python3')

    # fixing `pip` command because Cactus has nested-pip calls for sonLib
    inreplace 'setup.py',
              'pip',
              "#{libexec}/bin/pip"

    # Newest version of Toil that provides --doubleMem feature
    inreplace 'toil-requirement.txt',
              '4.2.0',
              '5.3.0'

    # fixing pythion bashbang on this executable file to call virtualEnv's python
    inreplace 'submodules/sonLib/sonLib_daemonize.py',
              '/usr/bin/env python3',
              "#{libexec}/bin/python3"

    # Compilation adjustments
    inreplace 'submodules/sonLib/include.mk',
              '.h',
              '.h.inv'
    ENV['CXX_ABI_DEF'] = '-D_GLIBCXX_USE_CXX11_ABI=1'

    # Installing Cactus following: https://github.com/ComparativeGenomicsToolkit/cactus#build-from-source
    system "#{libexec}/bin/pip",
           'install',
           '--upgrade',
           'setuptools',
           'pip'

    system "#{libexec}/bin/pip",
           'install',
           '--upgrade',
           '-r',
           'toil-requirement.txt'

    system "#{libexec}/bin/pip",
           'install',
           '--upgrade',
           buildpath.to_s

    # Compiling cactus
    system 'make'

    # Final installment adjustments
    bin.install Dir['bin/*']
    lib.install Dir['lib/*.a']
    include.install Dir['include/*.h']
    share.install Dir['share/*']

    # Creating symbolic links for Cactus be able to use toil from libexec
    bin.install_symlink "#{libexec}/bin/_toil_worker"
    bin.install_symlink "#{libexec}/bin/_toil_kubernetes_executor"
    bin.install_symlink "#{libexec}/bin/_toil_mesos_executor"

    # Creating symbolic links to call Cactus from libexec
    bin.install_symlink "#{libexec}/bin/cactus"
    bin.install_symlink "#{libexec}/bin/cactus-align"
    bin.install_symlink "#{libexec}/bin/cactus-blast"
    bin.install_symlink "#{libexec}/bin/cactus-prepare"
    bin.install_symlink "#{libexec}/bin/cactus-prepare-toil"
    bin.install_symlink "#{libexec}/bin/cactus-preprocess"

    # Copying python script from submodules to be included at VirtualEnv's lib
    path = `#{libexec}/bin/python3 -c \"import sysconfig; print(sysconfig.get_paths()['purelib'])\"`.strip
    FileUtils.cp_r 'submodules/hal',
                   path

    prefix.install Dir['submodules']
  end

  def caveats
    <<~EOS
                  Cactus Python scripts are already configured to use Cactus' own virtualenv.
                  If you need to use it, do this:
      #{'      '}
                  source #{libexec}/bin/activate
                  python3 -c "import hal"
                  deactivate
      #{'      '}
                  HAL, sonLib, and other Cactus submodules are installed at: #{opt_prefix}/submodules
            #{'      '}
    EOS
  end

  test do
    system "#{bin}/cactus", '--help'
  end
end
