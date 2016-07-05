class PhyloCsf < Formula
  desc "Determine if a multi-species nucleotide sequence alignment is likely to represent a protein-coding region"
  homepage "http://compbio.mit.edu/PhyloCSF/"
  url "https://github.com/mlin/PhyloCSF.git", :using => :git, :revision => 'c5cb773265d3e1f06f1ebd173582ff1ecb55617b'
  version '20150118'

  depends_on 'ocaml'
  depends_on 'opam'
  depends_on 'gsl'

  resource "batteries" do
    url "https://github.com/ocaml-batteries-team/batteries-included/archive/v2.5.2.tar.gz"
    sha256 "649038b47cdc2b7d4d4331fdb54b1e726212ce904c3472687a86aaa8d6006451"
  end

  resource "ocaml+twt" do
    url "https://github.com/mlin/twt/archive/v0.94.0.tar.gz"
    sha256 "7d2ab7181f00d41283cebc3bd0e6e51a2dd9195fe0b89a23437edd07608488e5"
  end

  resource "gsl" do
    url "https://github.com/mmottl/gsl-ocaml/archive/v1.19.1.tar.gz"
    sha256 "05891594ed3b4ea0c2f201531aeafce1280b937a18ba76d818760252c2b34b66"
  end

  def install
    ENV.deparallelize # Not related to F* : OCaml parallelization

    opamroot = buildpath/"opamroot"
    ENV["OPAMROOT"] = opamroot
    ENV["OPAMYES"] = "1"
    system "opam", "init", "--no-setup"
    archives = opamroot/"repo/default/archives"
    modules = []
    resources.each do |r|
      r.verify_download_integrity(r.fetch)
      original_name = File.basename(r.url)
      cp r.cached_download, archives/original_name
      modules << "#{r.name}=#{r.version}"
    end

    system "opam", "install", *modules
    system 'git', 'init'
    system "opam", "config", "exec", "--", "make"
    bin.install Dir['PhyloCSF*']
  end

  test do
    system "#{bin}/PhyloCSF"
  end
end
