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

class GvfValidator < Formula
  desc "A syntactic validator for GVF files"
  homepage "http://www.sequenceontology.org/software/GAL.html"
  url "https://raw.githubusercontent.com/The-Sequence-Ontology/GAL/2bf7645f22119ad16ce3e568e71428f1087b8f52/bin/gvf_validator"
  sha256 "e1a09b1d14be1dd6d9d345f6cd78f984e1ae961089359e40241e5ce941019d5b"
  version "2bf7645"

  resource "List::Util" do
    url "https://cpan.metacpan.org/authors/id/P/PE/PEVANS/Scalar-List-Utils-1.48.tar.gz"
    sha256 "0e5318308789ba3625e053001da0a6c5218dc73e561a207d1b91131d06c0d09f"
  end

  resource "List::MoreUtils" do
    url "https://cpan.metacpan.org/authors/id/R/RE/REHSACK/List-MoreUtils-0.419.tar.gz"
    sha256 "5f8e65608f5dc583faa6a703d19d277ad46dfc1816e51f8ff34fb8322ed48615"
  end

  resource "List::MoreUtils::XS" do
    url "https://cpan.metacpan.org/authors/id/R/RE/REHSACK/List-MoreUtils-XS-0.422.tar.gz"
    sha256 "b9d3565331ae92121a0d20bff1f02787af11d7a8f67954c842bf4aafed4588df"
  end

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV.prepend_path "PERL5LIB", libexec/"lib"

    %w[List::Util List::MoreUtils List::MoreUtils::XS].each do |r|
      resource(r).stage do
        # Force the system perl. We will fill in for other perls via another mechanism
        system "/usr/bin/perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
        system "make"
        system "make", "install"
      end
    end

    inreplace 'gvf_validator', '#!/usr/bin/perl', '#!/usr/bin/env perl'
    chmod 0555, 'gvf_validator'
    bin.install 'gvf_validator'
    bin.env_script_all_files(libexec/"bin", :PERL5LIB => ENV["PERL5LIB"])
  end

  test do
    system bin/'gvf_validator'
  end
end
