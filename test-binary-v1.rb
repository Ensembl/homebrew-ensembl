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

# Documentation: https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class TestBinaryV1 < Formula
  desc "Description"
  homepage "https://github.com/andrewyatz/test-binary"
  url "https://github.com/andrewyatz/test-binary/archive/1.0.0.tar.gz"
  version "1.0.0"
  sha256 "78cd490c1e24b164edadea8d1d3563e9ca0504245571b3c6da49a74a864310a9"

  def install
    bin.install 'bin/helloworld'
  end

  test do
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "#{bin}/helloworld"
  end
end
