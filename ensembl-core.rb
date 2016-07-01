class EnsemblCore < Formula
  url 'file://'+File.expand_path(__FILE__)
  desc 'Ensembl Core dependencies'
  version '1'
  
  depends_on 'ensembl/ensembl/exonerate22'
  depends_on 'homebrew/science/lastz'
  depends_on 'jdk'

  def install
    File.open('ensembl-core', 'w') { |file|
      file.write '#!/bin/sh'+"\n"
      deps.each do | dep |
        f = dep.to_formula
        file.write "echo "+[f.full_name, f.version, f.prefix].join("\t")+"\n"
      end
    }
    bin.install 'ensembl-core'
  end
end
