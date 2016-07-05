class CpanfileDumper < Formula
  desc "Dump a cpanfile into targets for Pinto"
  homepage "https://gist.github.com/thaljef/52840fd60dfabc94f151"
  url "https://gist.github.com/thaljef/52840fd60dfabc94f151/archive/b154d1c3853334388e2cc5a74b3742b834ba69cd.zip"
  version '1.0.0'
  sha256 "7c97c6df71ffb243d4602aefe2d11722c4a3f1861fee0acf60a309d5485300da"

  #requires Module::CPANfile
  resource "cpanm" do
    url "https://cpanmin.us/"
    sha256 "453e68066f2faba5c9fe04b4ca47f915fe0001f71405560093a23919e5e30d65"
  end

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    
    resource("cpanm").stage do
      mv 'cpanmin.us', 'cpanm'
      system '/usr/bin/env', 'perl', "cpanm", '--notest', '--local-lib-contained', libexec, 'Module::CPANfile'
    end
    (libexec+"bin").install 'cpanfile-dumper'
    chmod 0755, (libexec+'bin/cpanfile-dumper')
    bin.install Dir[libexec/"bin/cpanfile-dumper"]
    bin.env_script_all_files(libexec/"bin", :PERL5LIB => ENV["PERL5LIB"])
  end

  test do
    (testpath/"cpanfile").write <<-EOS.undent
      requires 'JSON'
    EOS
    system bin/'cpanfile-dumper', (testpath/'cpanfile')
  end
end
