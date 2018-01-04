class Mafft < Formula
  desc "Multiple alignments with fast Fourier transforms"
  homepage "https://mafft.cbrc.jp/alignment/software/"
  # doi "10.1093/nar/gkf436"
  # tag "bioinformatics"

  url "https://mafft.cbrc.jp/alignment/software/mafft-7.305-with-extensions-src.tgz"
  sha256 "26fccbd7091edfe6528a0535d33738546ee57b4a3b6e43332ffc3323e29ff4d1"

  fails_with :clang do
    build 421
    cause <<-EOS.undent
      Clang does not allow default arguments in out-of-line definitions of
      class template members.
      EOS
  end

  def install
    make_args = %W[CC=#{ENV.cc} CXX=#{ENV.cxx} CFAGS=#{ENV.cflags}
                   CXXFLAGS=#{ENV.cxxflags} PREFIX=#{prefix} MANDIR=#{man1}]
    make_args << "ENABLE_MULTITHREAD=" if MacOS.version <= :snow_leopard
    make_args << "install"
    cd "core" do
      system "make", *make_args
    end

    cd "extensions" do
      system "make", *make_args
    end
  end

  def caveats
    if MacOS.version <= :snow_leopard
      <<-EOS.undent
        This build of MAFFT is not multithreaded on Snow Leopard
        because its compiler does not support thread-local storage.
      EOS
    end
  end

  test do
    (testpath/"test.fa").write ">1\nA\n>2\nA"
    system "mafft", "test.fa"
  end
end