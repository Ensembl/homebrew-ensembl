class Ktreedist < Formula
  desc 'Calculates the K tree score from one phylogenetic tree to another'
  homepage 'http://molevol.cmima.csic.es/castresana/Ktreedist.html'
  url 'http://molevol.cmima.csic.es/castresana/Ktreedist/Ktreedist_v1.tar.gz'
  sha256 'cb414bcd5309d13cc6dbe3a8d03db37dcae87dd221038285f865d42518a40402'
  version '1.0.0'

  def install
    inreplace 'Ktreedist.pl', '#!/usr/bin/perl', '#!/usr/bin/env perl'
    bin.install 'Ktreedist.pl'
    doc.install 'Documentation/Ktreedist_documentation.html'
  end
end
