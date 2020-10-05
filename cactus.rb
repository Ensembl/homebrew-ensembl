
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
  
  desc "Official home of genome aligner based upon notion of Cactus graphs" 
  homepage "https://github.com/ComparativeGenomicsToolkit/cactus" 
  url "https://github.com/ComparativeGenomicsToolkit/cactus/releases/download/v1.2.1/cactus-v1.2.1.tar.gz"
  sha256 "15482b6d07e5d1ed3984ad89dc89f71886ae052cdd25e7688a635ab672a75bd3"
  version "1.2.1" 

  bottle :unneeded


  depends_on "pkg-config" => :build
  depends_on "gcc@7" => :build
  depends_on "hdf5" => "enable-cxx"
  depends_on "lzo"
  depends_on "python3"


  def install
  	ENV.deparallelize
  	
  	# create virtual environment
	venv = virtualenv_create(libexec, "python3")

	# fix `pip` command because Cactus has nested-pip calls for sonLib
	inreplace "setup.py", 
		"pip", 
		"#{libexec}/bin/pip"


	#Extracting python dependencies from setup.py because
	#the pip call Python.rb use --no-dependencies flag
	extract_python_dependencies(libexec)
	

	# Forcing the installment of cactus python (binary) dependencies without using
	# invidual package source code (.tar.gz) via `venv.pip_install resources` 
	system "#{libexec}/bin/pip", 
		"install", 
		"-r", 
		"toil-requirement.txt" 


	# install cactus python dependencies
	venv.pip_install_and_link buildpath

	
	# Compilation adjustments
    inreplace "submodules/sonLib/include.mk",
    	".h",
    	".h.inv"
    ENV['CXX_ABI_DEF']="-D_GLIBCXX_USE_CXX11_ABI=1"
    
    # Cactus compilation
    system "make"

    # installation
    bin.install Dir['bin/*']
    lib.install Dir['lib/*.a']
    include.install Dir['include/*.h']
    share.install Dir['share/*']

	# create symbolic links for Cactus be able to use toil 
	bin.install_symlink "#{libexec}/bin/_toil_worker"
	bin.install_symlink "#{libexec}/bin/_toil_kubernetes_executor"
	bin.install_symlink "#{libexec}/bin/_toil_mesos_executor"

	#copy python script from submodules to be included at PYTHONPATH
	FileUtils.cp_r "submodules",
		"#{prefix}"

  end

  private def extract_python_dependencies(libexec)
    wrapper = 'from distutils.core import run_setup;
    result = run_setup("setup.py", stop_after="init");
    f = open("toil-requirement.txt","a");
    f.write("\n".join(result.install_requires));
    f.close();'
    File.write('toil-requirement.py', wrapper.split(/\s*;\s*/).join("\n"), mode: "a")
    system "#{libexec}/bin/python3",
    	"toil-requirement.py"
  end

  def caveats
    <<~EOS
      To use HAL python scripts such as hal2mafMP.py, add the submodules directory to the PYTHONPATH with

        export PYTHONPATH=#{prefix}/submodules:$PYTHONPATH
    EOS
  end

  test do
    system "#{bin}/cactus", "--help"
  end
end
