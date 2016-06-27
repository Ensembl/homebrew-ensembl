class Notung < Formula
  desc 'Notung and reconciliation with gene duplication, loss, horizontal transfer, and incomplete lineage sorting'
  homepage 'http://goby.compbio.cs.cmu.edu/Notung'
  url 'http://goby.compbio.cs.cmu.edu/Notung/distributions/Notung-2.6.zip'
  sha256 '23a42e7e464be363a48531a22b11a17a320454f6895c0e0c8c37419bd41b1311'
  version '2.6.0'

  def install
    libexec.install 'Notung-2.6.jar'
    doc.install 'Manual-2.6.pdf'
  end
end
