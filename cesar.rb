class Cesar < Formula
  desc "Coding Exon Structure Aware Realigner"
  homepage "https://github.com/hillerlab/CESAR"
  url "https://github.com/hillerlab/CESAR/archive/31d99ca483d929b51edbe197f9300f8ce3f8c31e.zip"
  sha256 "e096f519308bba587f429703e1167c82699ca20b32a13ced0010a4604ff344fe"
  version "31d99ca"

  depends_on :python if MacOS.version <= :snow_leopard
  depends_on "homebrew/science/openblas"
  depends_on "homebrew/science/qhull"
  depends_on "freetype"
  depends_on "libpng"
  
  keg_only 'Keep the dependency to itself because of oddness'

  resource "numpy" do
    url "https://pypi.python.org/packages/e0/4c/515d7c4ac424ff38cc919f7099bf293dd064ba9a600e1e3835b3edefdb18/numpy-1.11.1.tar.gz"
    sha256 "dc4082c43979cc856a2bf352a8297ea109ccb3244d783ae067eb2ee5b0d577cd"
  end

  resource "Cycler" do
    url "https://files.pythonhosted.org/packages/c2/4b/137dea450d6e1e3d474e1d873cd1d4f7d3beed7e0dc973b06e8e10d32488/cycler-0.10.0.tar.gz"
    sha256 "cd7b2d1018258d7247a71425e9f26463dfb444d411c39569972f4ce586b0c9d8"
  end

  resource "Cython" do
    url "https://files.pythonhosted.org/packages/c6/fe/97319581905de40f1be7015a0ea1bd336a756f6249914b148a17eefa75dc/Cython-0.24.1.tar.gz"
    sha256 "84808fda00508757928e1feadcf41c9f78e9a9b7167b6649ab0933b76f75e7b9"
  end

  resource "decorator" do
    url "https://files.pythonhosted.org/packages/13/8a/4eed41e338e8dcc13ca41c94b142d4d20c0de684ee5065523fee406ce76f/decorator-4.0.10.tar.gz"
    sha256 "9c6e98edcb33499881b86ede07d9968c81ab7c769e28e9af24075f0a5379f070"
  end

  resource "matplotlib" do
    url "https://files.pythonhosted.org/packages/15/89/240b4ebcd63bcdde9aa522fbd2e13f0af3347bea443cb8ad111e3b4c6f3a/matplotlib-1.5.2.tar.gz"
    sha256 "8875d763c9e0d0ae01fefd5ebbe2b22bde5f080037f9467126d5dbee31785913"
  end

  resource "networkx" do
    url "https://files.pythonhosted.org/packages/c2/93/dbb41b03cf7c878a7409c8e92226531f840a423c9309ea534873a83c9192/networkx-1.11.tar.gz"
    sha256 "0d0e70e10dfb47601cbb3425a00e03e2a2e97477be6f80638fef91d54dd1e4b8"
  end

  resource "pyparsing" do
    url "https://files.pythonhosted.org/packages/65/25/1bb68622ca70abc145ac9c9bcd0e837fccd2889d79cee641aa8604d18a11/pyparsing-2.1.8.tar.gz"
    sha256 "03a4869b9f3493807ee1f1cb405e6d576a1a2ca4d81a982677c0c1ad6177c56b"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/3e/f5/aad82824b369332a676a90a8c0d1e608b17e740bbb6aeeebca726f17b902/python-dateutil-2.5.3.tar.gz"
    sha256 "1408fdb07c6a1fa9997567ce3fcee6a337b39a503d80699e0f213de4aa4b32ed"
  end

  resource "pytz" do
    url "https://files.pythonhosted.org/packages/f7/c7/08e54702c74baf9d8f92d0bc331ecabf6d66a56f6d36370f0a672fc6a535/pytz-2016.6.1.tar.bz2"
    sha256 "b5aff44126cf828537581e534cc94299b223b945a2bb3b5434d37bf8c7f3a10c"
  end

  resource "scipy" do
    url "https://files.pythonhosted.org/packages/01/a1/dce70d47377d662aa4b0895df8431aee92cea6faefaab9dae21b0f901ded/scipy-0.18.0.tar.gz"
    sha256 "f01784fb1c2bc246d4211f2482ecf4369db5abaecb9d5afb9d94f6c59663286a"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/b3/b2/238e2590826bfdd113244a40d9d3eb26918bd798fc187e2360a8367068db/six-1.10.0.tar.gz"
    sha256 "105f8d68616f8248e24bf0e9372ef04d3cc10104f1980f54d57b2ce73a5ad56a"
  end

  resource "yahmm" do
    url "https://files.pythonhosted.org/packages/48/d4/35c1d2fa6fd719ccbc8b69e3af1f1633b5b173d2ee86b109b7b89c353bb7/yahmm-1.1.3.zip"
    sha256 "fe3614ef96da9410468976756fb93dc8235485242c05df01d8e5ed356a7dfb43"
  end

  def install
    openblas_dir = Formula["openblas"].opt_prefix
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"
    ENV.append "FFLAGS", "-fPIC"
    ENV.append "LDFLAGS", "-shared"
    ENV["ATLAS"] = "None"
    ENV["BLAS"] = ENV["LAPACK"] = "#{openblas_dir}/lib/libopenblas.so"
    config = <<-EOS.undent
      [openblas]
      libraries = openblas
      library_dirs = #{openblas_dir}/lib
      include_dirs = #{openblas_dir}/include
    EOS
    (buildpath/"site.cfg").write config

    resource("numpy").stage do
      system "python", "setup.py",
        "build", "--fcompiler=gnu95", "--parallel=#{ENV.make_jobs}",
        "install", "--prefix=#{libexec}/vendor",
        "--single-version-externally-managed", "--record=installed.txt"
    end

    %w[Cycler decorator matplotlib networkx pyparsing python-dateutil pytz scipy six yahmm].each do |r|
      resource(r).stage do
        system "python", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end

    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"
    ENV["MPLBACKEND"] = 'PDF'

    #system "python", *Language::Python.setup_install_args(libexec)

    #bin.install Dir[libexec/"bin/*"]
    #bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])

    prefix.install 'CESAR'
    prefix.install 'examples'
    prefix.install 'README.md'

    cesar = libexec+'CESAR'
    File.delete(cesar) if File.exists?(cesar)
    (cesar).write <<-EOF.undent
#!/bin/bash
export PYTHONPATH=#{ENV["PYTHONPATH"]} MPLBACKEND=#{ENV["MPLBACKEND"]} exec "python" "#{prefix}/CESAR/CESAR.py" "$@"
EOF
    bin.install cesar
    
    cd bin do
      system 'cesar'
    end
  end

  test do
    false
  end
end
