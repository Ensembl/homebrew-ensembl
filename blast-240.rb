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

class Blast240 < Formula
  desc "Basic Local Alignment Search Tool"
  homepage "http://blast.ncbi.nlm.nih.gov/"
  # doi "10.1016/S0022-2836(05)80360-2"
  # tag "bioinformatics"

  option 'with-src', 'Build Blast from SRC not using precompiled binaries provided by NCBI'

  if build.with? 'src'
    url "ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.4.0/ncbi-blast-2.4.0+-src.tar.gz"
    version "2.4.0"
    sha256 ""

    fails_with :gcc => "5"
    
    fails_with :llvm do
      build 2335
      cause "Dropped arguments to functions when linking with boost"
    end
  else
    if OS.linux? 
      url 'ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.4.0/ncbi-blast-2.4.0+-x64-linux.tar.gz'
      version "2.4.0"
      sha256 '21aa7ca60954ce9c6d3f572e427fee804291fcad41447d554033a81d5af96a2b'
    elsif OS.mac?
      url 'ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.4.0/ncbi-blast-2.4.0+-universal-macosx.tar.gz'
      version '2.4.0'
      sha256 ''
    else
      onoe 'Do not know how to support the current OS'
    end
  end

  option "with-static", "Build without static libraries and binaries"
  option "with-dll", "Build dynamic libraries"

  depends_on "freetype" => :optional
  depends_on "gnutls" => :optional
  depends_on "homebrew/science/hdf5" => :optional
  depends_on "jpeg" => :recommended
  depends_on "libpng" => :recommended
  depends_on "lzo" => :optional
  depends_on :mysql => :optional
  depends_on "pcre" => :recommended
  depends_on :python if MacOS.version <= :snow_leopard

  def install

    if build.with? 'src'
      ohai 'Building from source'
      # The libraries and headers conflict with ncbi-c++-toolkit so use libexec.
      args = %W[
        --prefix=#{prefix}
        --libdir=#{libexec}
        --without-debug
        --with-mt
        --without-boost
      ]
  
      args << (build.with?("mysql") ? "--with-mysql" : "--without-mysql")
      args << (build.with?("freetype") ? "--with-freetype=#{Formula["freetype"].opt_prefix}" : "--without-freetype")
      args << (build.with?("gnutls") ? "--with-gnutls=#{Formula["gnutls"].opt_prefix}" : "--without-gnutls")
      args << (build.with?("jpeg")   ? "--with-jpeg=#{Formula["jpeg"].opt_prefix}" : "--without-jpeg")
      args << (build.with?("libpng") ? "--with-png=#{Formula["libpng"].opt_prefix}" : "--without-png")
      args << (build.with?("pcre")   ? "--with-pcre=#{Formula["pcre"].opt_prefix}" : "--without-pcre")
      args << (build.with?("hdf5")   ? "--with-hdf5=#{Formula["homebrew/science/hdf5"].opt_prefix}" : "--without-hdf5")
  
      if build.without? "static"
        args << "--with-dll" << "--without-static" << "--without-static-exe"
      else
        args << "--with-static"
        args << "--with-static-exe" unless OS.linux?
        args << "--with-dll" if build.with? "dll"
      end
  
      cd "c++"
  
      # The build invokes datatool but its linked libraries aren't installed yet.
      ln_s buildpath/"c++/ReleaseMT/lib", prefix/"libexec" if build.without? "static"
  
      system "./configure", *args
      system "make"
  
      rm prefix/"libexec" if build.without? "static"
  
      system "make", "install"
  
      # The libraries and headers conflict with ncbi-c++-toolkit.
      libexec.install include
    else
      ohai 'Using NCBI precompiled binaries'
      bin.install Dir['bin/*']
      doc.install 'doc/README.txt'
    end
  end

  def caveats; <<-EOS.undent
    Using the option "--with-static" will create static binaries instead of
    dynamic. The NCBI Blast static installation is approximately 7 times larger
    than the dynamic.

    Static binaries should be used for speed if the executable requires fast
    startup time, such as if another program is frequently restarting the blast
    executables.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/blastn -version")
  end
end
