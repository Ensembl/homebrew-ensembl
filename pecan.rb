class Pecan < Formula
  desc 'Probabilistic consistency based aligner'
  homepage 'http://hgwdev.cse.ucsc.edu/~benedict/code/Pecan.html'
  url 'https://github.com/benedictpaten/pecan.git', :using => :git
  version '0.8.0'

  def install
    system 'javac', 'bp/pecan/Pecan.java'
    system 'javac', 'bp/trawler/Trawler.java'
    libexec.install 'bp'
    doc.install Dir['doc/*']
  end
end
