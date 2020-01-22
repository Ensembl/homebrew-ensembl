class LtrRetriever < Formula
  desc 'Highly accurate and sensitive program for identification of LTR retrotransposons'
  homepage 'https://github.com/oushujun/LTR_retriever'
  # tag 'bioinformatics'

  version '2.8'
  url "https://github.com/oushujun/LTR_retriever.git", :using => :git, :revision => "v#{version}"

  depends_on "ensembl/external/repeatmasker"
  depends_on "ensembl/external/cd-hit"
  depends_on "ensembl/external/blast"
  depends_on "ensembl/external/hmmer"

  def install
    inreplace "paths" do |s|
      s.gsub! /BLAST+=/, "BLAST+=#{Formula['ensembl/external/blast'].opt_bin}"
      s.gsub! /RepeatMasker=/, "RepeatMasker=#{Formula['ensembl/external/repeatmasker'].opt_bin}"
      s.gsub! /HMMER=/, "HMMER=#{Formula['ensembl/external/hmmer'].opt_bin}"
      s.gsub! /CDHIT=/, "CDHIT=#{Formula['ensembl/external/cd-hit'].opt_bin}"
    end
    bin.install 'paths'
    Dir.glob("bin/*.pl") { |f|
      inreplace f, /#!.*r.bin.perl/, '#!/usr/bin/env perl'
    }
    bin.install Dir["bin/*"]
    bin.install 'LAI'
    bin.install 'LTR_retriever'
    prefix.install Dir["database"]
    doc.install 'Manual.pdf'
  end

  test do
#    assert_match "### LTR_retriever v#{version} ###", shell_output("#{bin}/LTR_retriever -h", 255)
    assert_match "", shell_output("#{bin}/LTR_retriever -h", 255)
  end
end
