class Hclustersg < Formula
  desc 'Hierarchically clustering on a sparse graph'
  homepage 'https://sourceforge.net/projects/treesoft/'
  url 'svn://svn.code.sf.net/p/treesoft/code/trunk', :using => :svn
  version '0.5.0'

  def install
    cd 'hcluster' do
      system 'make'
      bin.install 'hcluster_sg'
    end
  end
end
