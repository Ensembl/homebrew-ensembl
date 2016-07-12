class Cvs2svn < Formula
  desc "Migrate a CVS repository to Subversion, git, or Bazaar"
  homepage "http://cvs2svn.tigris.org/"
  url "http://cvs2svn.tigris.org/files/documents/1462/49237/cvs2svn-2.4.0.tar.gz"
  sha256 ""

  def install
    prefix.install Dir['*']
    (etc+'cvs2svn.bash').write <<-EOF.undent
      export CVS2SVN_INST=#{prefix}
    EOF
  done
end
