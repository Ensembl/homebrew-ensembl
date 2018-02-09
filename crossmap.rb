
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Crossmap < Formula
  desc "Genomic feature liftover tool"
  homepage "http://crossmap.sourceforge.net/"
  url "https://files.pythonhosted.org/packages/05/e4/a5ba7b144b855637d6888ddaa2dddded2729340eeb8f7aaa866b8d0568bf/CrossMap-0.2.3.tar.gz"
  sha256 "8e4110156770add1c149b6d839c86422eef5098e3ebe3fe9e5f006264f2375fd"

  depends_on "python" if MacOS.version <= :snow_leopard
  depends_on "homebrew/science/openblas"

  resource "nose" do
    url "https://pypi.python.org/packages/source/n/nose/nose-1.3.7.tar.gz"
    sha256 "f1bffef9cbc82628f6e7d7b40d7e255aefaa1adb6a1b1d26c69a8b79e6208a98"
  end

  resource "numpy" do
    url "https://pypi.python.org/packages/e0/4c/515d7c4ac424ff38cc919f7099bf293dd064ba9a600e1e3835b3edefdb18/numpy-1.11.1.tar.gz"
    sha256 "dc4082c43979cc856a2bf352a8297ea109ccb3244d783ae067eb2ee5b0d577cd"
  end

  resource "bx-python" do
    url "https://files.pythonhosted.org/packages/55/db/fa76af59a03c88ad80494fc0df2948740bbd58cd3b3ed5c31319624687cc/bx-python-0.7.3.tar.gz"
    sha256 "518895e2dca313d7634c5cf48190b4020a463d6aa6adb42a261630bbd7e0e297"
  end

  resource "Cython" do
    url "https://files.pythonhosted.org/packages/b1/51/bd5ef7dff3ae02a2c6047aa18d3d06df2fb8a40b00e938e7ea2f75544cac/Cython-0.24.tar.gz"
    sha256 "6de44d8c482128efc12334641347a9c3e5098d807dd3c69e867fa8f84ec2a3f1"
  end

  resource "pysam" do
    url "https://files.pythonhosted.org/packages/76/62/908776209238850eca22e7139cc23ce2ba14b2941ceb438b1572f84e8d82/pysam-0.9.1.2.tar.gz"
    sha256 "da49d15c3adca67c46d0aa418e8d2b27d1667890a444886dd95d6da55e6e5e2b"
  end

  def install
    openblas_dir = Formula["openblas"].opt_prefix
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"
    ENV.append "LDFLAGS", "-shared"
    ENV["ATLAS"] = "None"
    ENV["BLAS"] = ENV["LAPACK"] = "#{openblas_dir}/lib/libopenblas.so"
    config = <<~EOS
      [openblas]
      libraries = openblas
      library_dirs = #{openblas_dir}/lib
      include_dirs = #{openblas_dir}/include
    EOS
    (buildpath/"site.cfg").write config

    #nose_path = libexec/"nose/lib/python#{version}/site-packages"
    resource("nose").stage do
      system "python", *Language::Python.setup_install_args(libexec/"nose")
      #(dest_path/"homebrew-numpy-nose.pth").write "#{nose_path}"
    end
    resource("numpy").stage do
      system "python", "setup.py",
        "build", "--fcompiler=gnu95", "--parallel=#{ENV.make_jobs}",
        "install", "--prefix=#{libexec}/vendor",
        "--single-version-externally-managed", "--record=installed.txt"
    end

    %w[bx-python Cython pysam].each do |r|
      resource(r).stage do
        system "python", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end

    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"
    system "python", *Language::Python.setup_install_args(libexec)

    bin.install Dir[libexec/"bin/*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end

  test do
    false
  end
end
