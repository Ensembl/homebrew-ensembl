class Ortheus < Formula
  desc 'Probabilistic method for the inference of ancestor (aka tree) alignments'
  homepage 'http://hgwdev.cse.ucsc.edu/~benedict/code/Ortheus.html'
  url 'https://github.com/benedictpaten/ortheus.git', :using => :git
  version '0.5.0'

  depends_on 'ensembl/ensembl/sonlib'
  depends_on 'ensembl/ensembl/semphy'

  def install
    sonlib = Formula['ensembl/ensembl/sonlib']
    ENV.deparallelize
    inreplace 'include.mk', '${rootPath}../sonLib', "#{sonlib.prefix}"
    inreplace 'include.mk', '-I ${sonLibPath}', "-I #{sonlib.include}"
    inreplace 'include.mk', '${sonLibRootPath}/include.mk', "#{sonlib.prefix}/sonLib/include.mk"

    ENV["PYTHONPATH"] = sonlib.prefix
    ENV["PATH"] = "#{buildpath}/bin"+':'+ENV["PATH"]
    system 'make'
    cd 'bin' do
      bin.install %w(ortheus_core Ortheus.py)
    end
    (prefix+'ortheus').mkpath
    (prefix+'ortheus').install Dir['*']
  end
end
