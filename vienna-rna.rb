#required because for some reason CurlDownloadStrategy attempts to resolve the 
#url to a HTML page
class IgnoreRedirectionsDownloadStrategy < CurlDownloadStrategy
  def actual_urls
    urls = []
    urls << @url
    urls
  end
end

class ViennaRna < Formula
  desc 'Programs for the prediction and comparison of RNA secondary structures'
  homepage 'http://www.tbi.univie.ac.at/RNA'
  url 'http://www.tbi.univie.ac.at/RNA/download/sourcecode/2_2_x/ViennaRNA-2.2.6.tar.gz', :using => IgnoreRedirectionsDownloadStrategy
  sha256 '7bd2d385ef7496ed54fd0576c6664cd88b93543d30932a13a2e3354d9ccdb530'
  version '2.2.6'
  
  def install
    system './configure', "--prefix=#{prefix}"
    system 'make'
    system 'make install'
  end
end
