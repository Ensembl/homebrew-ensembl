
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
  license "NOASSERTION"
  version "1.2.1" 

  bottle :unneeded


  depends_on "pkg-config" => :build
  depends_on "hdf5" => "enable-cxx"
  depends_on "lzo"
  depends_on "python3"



  # Cactus dependencies
#  resource "toil" do
#    url "https://files.pythonhosted.org/packages/8b/34/fc70fa71a0345deb681040620ff2106da857c33711557221d02007b9d37e/toil-4.1.0.tar.gz"
#    sha256 "3345eef1bb14fbf80dd4638bb8f0ee0c1aca2bdf89665214b4ecfb1d8965b470"
#  end

  resource "networkx" do
    url "https://files.pythonhosted.org/packages/ef/d0/f706a9e5814a42c544fa1b2876fc33e5d17e1f2c92a5361776632c4f41ab/networkx-2.5.tar.gz"
    sha256 "7978955423fbc9639c10498878be59caf99b44dc304c2286162fd24b458c1602"
  end

   resource "psutil" do
    url "https://files.pythonhosted.org/packages/aa/3e/d18f2c04cf2b528e18515999b0c8e698c136db78f62df34eee89cee205f1/psutil-5.7.2.tar.gz"
    sha256 "90990af1c3c67195c44c9a889184f84f5b2320dce3ee3acbd054e3ba0b4a7beb"
  end

   resource "decorator" do
    url "https://files.pythonhosted.org/packages/da/93/84fa12f2dc341f8cf5f022ee09e109961055749df2d0c75c5f98746cfe6c/decorator-4.4.2.tar.gz"
    sha256 "e3a62f0520172440ca0dcc823749319382e377f37f140a0b99ef45fecb84bfe7"
  end

   resource "Cython" do
    url "https://files.pythonhosted.org/packages/6c/9f/f501ba9d178aeb1f5bf7da1ad5619b207c90ac235d9859961c11829d0160/Cython-0.29.21.tar.gz"
    sha256 "e57acb89bd55943c8d8bf813763d20b9099cc7165c0f16b707631a7654be9cad"
  end

   resource "pytest" do
    url "https://files.pythonhosted.org/packages/d4/d1/61dbeb5e6d6a694c4d024043ad67a01ba236c54d253558b3019b6fac2c68/pytest-6.1.0.tar.gz"
    sha256 "d010e24666435b39a4cf48740b039885642b6c273a3f77be3e7e03554d2806b7"
  end

   resource "biopython" do
    url "https://files.pythonhosted.org/packages/89/c5/7fe326081276f74a4073f6d6b13cfa7a04ba322a3ff1d84027f4773980b8/biopython-1.78.tar.gz"
    sha256 "1ee0a0b6c2376680fea6642d5080baa419fd73df104a62d58a8baf7a8bbe4564"
  end

   resource "numpy" do
    url "https://files.pythonhosted.org/packages/bf/e8/15aea783ea72e2d4e51e3ec365e8dc4a1a32c9e5eb3a6d695b0d58e67cdd/numpy-1.19.2.zip"
    sha256 "0d310730e1e793527065ad7dde736197b705d0e4c9999775f212b03c44a8484c"
  end

   resource "py" do
    url "https://files.pythonhosted.org/packages/97/a6/ab9183fe08f69a53d06ac0ee8432bc0ffbb3989c575cc69b73a0229a9a99/py-1.9.0.tar.gz"
    sha256 "9ca6883ce56b4e8da7e79ac18787889fa5206c79dcc67fb065376cd2fe03f342"
  end

   resource "toml" do
    url "https://files.pythonhosted.org/packages/da/24/84d5c108e818ca294efe7c1ce237b42118643ce58a14d2462b3b2e3800d5/toml-0.10.1.tar.gz"
    sha256 "926b612be1e5ce0634a2ca03470f95169cf16f939018233a670519cb4ac58b0f"
  end

   resource "pluggy" do
    url "https://files.pythonhosted.org/packages/f8/04/7a8542bed4b16a65c2714bf76cf5a0b026157da7f75e87cc88774aa10b14/pluggy-0.13.1.tar.gz"
    sha256 "15b2acde666561e1298d71b523007ed7364de07029219b604cf808bfa1c765b0"
  end

   resource "iniconfig" do
    url "https://files.pythonhosted.org/packages/aa/6e/60dafce419de21f2f3f29319114808cac9f49b6c15117a419737a4ce3813/iniconfig-1.0.1.tar.gz"
    sha256 "e5f92f89355a67de0595932a6c6c02ab4afddc6fcdc0bfc5becd0d60884d3f69"
  end

  def install
  	ENV.deparallelize
  	
  	# create virtual environment
	venv = virtualenv_create(libexec, "python3")

	# install cactus python dependencies stated above
	venv.pip_install resources

	# little hack to install toil's dependencies (which are loads) => maybe a proper recipe for toil will be needed
	system "#{libexec}/bin/pip", 
		"install", 
		"--use-feature=2020-resolver",
		"-r", 
		"toil-requirement.txt" 

	
	# fix `pip` command because Cactus has nested-pip calls 
	inreplace "setup.py", 
		"pip", 
		"#{libexec}/bin/pip"

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
    lib.install Dir['lib/*']
    include.install Dir['include/*']
    share.install Dir['share/*']

	# create symbolic links for toil at Cactus bin directory
	bin.install_symlink "#{libexec}/bin/_toil_worker"
	bin.install_symlink "#{libexec}/bin/_toil_kubernetes_executor"
	bin.install_symlink "#{libexec}/bin/_toil_mesos_executor"

	#copy python script
	FileUtils.cp_r "submodules",
		"#{prefix}"

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
