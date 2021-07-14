
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#required because for some reason CurlDownloadStrategy attempts to resolve the 
#url to a HTML page
class IgnoreRedirectionsDownloadStrategy < CurlDownloadStrategy
  def actual_urls(url)
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
  revision 1

  depends_on "gcc@6"

  fails_with gcc: "7"
  fails_with gcc: "8"
  fails_with gcc: "9"
  fails_with gcc: "10"

  def install
    system './configure', "--prefix=#{prefix}", "--without-doc-pdf", "--without-perl", "--without-python"
    system 'make'
    system 'make install'
  end
end
