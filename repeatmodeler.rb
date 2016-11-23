# Copyright [2016] EMBL-European Bioinformatics Institute
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Repeatmodeler < Formula
  desc "De-novo repeat family identification and modeling package"
  homepage "http://www.repeatmasker.org/RepeatModeler.html"
  # tag "bioinformatics"

  url "http://www.repeatmasker.org/RepeatModeler-open-1-0-8.tar.gz"
  version "1.0.8"
  sha256 "3ac87af3fd3da0c9a2ca8e7b8885496abdf3383e413575548c1d234c15f27ecc"
  revision 1

  option "without-configure", "Do not run configure"

  depends_on "homebrew/science/recon"
  depends_on "ensembl/ensembl/repeatmasker"
  depends_on "homebrew/science/repeatscout"
  depends_on "ensembl/ensembl/rmblast"
  depends_on "homebrew/science/trf"

  # Configure RepeatModeler. The prompts are:
  # PRESS ENTER TO CONTINUE
  # PERL INSTALLATION PATH
  # REPEATMODELER INSTALLATION PATH
  # REPEATMASKER INSTALLATION PATH
  # RECON INSTALLATION PATH
  # RepeatScout INSTALLATION PATH
  # 1. RMBlast - NCBI Blast with RepeatMasker extensionst
  # RMBlast (rmblastn) INSTALLATION PATH
  # Do you want RMBlast to be your default search engine for Repeatmasker?
  # 3. Done
  def install
    prefix.install Dir["*"]
    bin.install_symlink %w[../BuildDatabase ../RepeatModeler]

    %x{plenv which perl}
    perl = if $?.exitstatus != 0
      "/usr/bin/perl"
    else
      %x{plenv which perl}.chomp
    end
    (prefix/"config.txt").write <<-EOS.undent

      #{perl}
      #{prefix}
      #{Formula["ensembl/ensembl/repeatmasker"].opt_prefix/"libexec"}
      #{Formula["homebrew/science/recon"].opt_prefix/"bin"}
      #{Formula["homebrew/science/repeatscout"].opt_prefix}
      #{Formula["homebrew/science/trf"].opt_prefix/"bin"}
      1
      #{HOMEBREW_PREFIX}/bin
      Y
      3
      EOS
  end

  def post_install
    cd prefix do
      system "perl ./configure <config.txt"
    end if build.with? "configure"
  end

  def caveats; <<-EOS.undent
    To reconfigure RepeatModeler, run
      brew postinstall repeatmodeler
    or
      cd #{prefix} && perl ./configure <config.txt
    EOS
  end

  test do
    assert_match version.to_s, shell_output("perl #{bin}/RepeatModeler -v")
  end
end
