
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class OracleDbd < Formula

  desc 'Perl module for accessing Oracle databases'
  homepage 'https://metacpan.org/release/DBD-Oracle'
  url 'https://cpan.metacpan.org/authors/id/P/PY/PYTHIAN/DBD-Oracle-1.74.tar.gz'
  sha256 '4a676ff28193303ea92f4660cd4889063480837a2c2a59a43744ac1e74b795d4'

  depends_on 'ensembl/moonshine/oracle-instant-client'
  depends_on 'ensembl/ensembl/libaio'

  def run_cpan(perl_cmd)
    oci = Formula['ensembl/moonshine/oracle-instant-client']
    ENV['ORACLE_HOME'] = oci.prefix
    system perl_cmd, 'Makefile.PL', '-m', "#{oci}/sdk/demo/demo.mk", '-l'
    system 'make'
    system 'make', 'install'
  end
  
  def install
    if ENV.has_key?('PLENV_ROOT')
      %x{#{ENV['PLENV_ROOT']}/bin/plenv versions --bare}.chomp.split.each do | ver |
        ENV['PLENV_VERSION'] = ver
        perl_cmd = %x{#{ENV['PLENV_ROOT']}/bin/plenv which perl}.chomp
        run_cpan(perl_cmd)
      end
    else
      run_cpan('/usr/bin/perl')
    end
    script = Pathname.new 'oracle-dbd-version'
    (script).write <<-EOF.undent
      #!/bin/sh
      perl -MDBD::Oracle -e 'print $DBD::Oracle::VERSION."\n"'
    EOF
    bin.install script
  end

  def caveats; <<~EOS
    This package installs DBD::Oracle to your current Perl's library directory. 
    If you did not want to do this then do not run this program.
    EOS
  end
end
