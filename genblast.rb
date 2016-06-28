class Genblast < Formula
  desc 'Splice aware aligner for transcript models'
  homepage 'http://genome.sfu.ca/genblast/'
  url 'http://genome.sfu.ca/genblast/latest/genblast_v139.zip'
  version '1.39'
  sha256 '7934ef446d9b2f8fa80a6b53a2f001e2531edf2a2749545390e739ffa878e8d4'

  def install
    system 'make', 'all'
    bin.install 'genblast'
    File.open((etc+'genblast.bash'), 'w') { |file| file.write("export PATH=#{bin}:$PATH\n") }
  end

  test do
    system "#{bin}/genblast"
  end
end
