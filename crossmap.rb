
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
  url "https://files.pythonhosted.org/packages/d5/ba/d3025c812acc530509f410faa37734d103b66a3787cc466b703517dc6a03/CrossMap-0.2.8.tar.gz"
  sha256 "783a89f7378495dc0f1dbbb1b56b780cc4aeeb20d683c2721560952305083c47"

  depends_on "openblas"

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
    url "https://files.pythonhosted.org/packages/be/70/16cdd6c5ef799b2db2af4fd5f9720df0f3206b0a06ed40e03692aa80ae25/pysam-0.11.1.tar.gz"
    sha256 "fbc710f82cb4334b3b88be9b7a9781547456fdcb2135755b68e041e96fc28de1"
  end
  
  # Patch CrossMap's lack of reverse complementing bases from VCF files when target mapped strand is negative
  patch do
    url "https://raw.githubusercontent.com/Ensembl/CrossMap-Patch/ec5042fef9d7e714ac92f23314fa2c350c4b3d49/CrossMap-0.2.8.patch"
    sha256 "6517d3caa3d78d2f72a95c45f9fc59b9c71d586b9ed0eaa8c0230ee1b22e60f5"
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
