# Copyright [2017] EMBL-European Bioinformatics Institute
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class ProgressiveCactus < Formula
  desc 'Hierarchical Alignment Format library'
  homepage 'https://github.com/glennhickey/progressiveCactus'
  url 'https://github.com/glennhickey/progressiveCactus.git', :using => :git, :revision => "86d5e3f"
  version '86d5e3f'

depends_on :python if MacOS.version <= :snow_leopard

  def install

    system 'git', 'submodule', 'update', '--init'

    inreplace "submodules/hdf5/test/th5s.c", "\/\/ ret = H5Pset_alloc_time(plist_id, alloc_time);", "\/\* ret = H5Pset_alloc_time(plist_id, alloc_time);\*\/"
    inreplace "submodules/hdf5/test/th5s.c", "\/\/ CHECK(ret, FAIL, \"H5Pset_alloc_time\");", "\/\* CHECK(ret, FAIL, \"H5Pset_alloc_time\");\*\/"
    inreplace "submodules/hdf5/tools/lib/h5tools_str.c", "\/\/    ctx->need_prefix = 0;", "\/\*    ctx->need_prefix = 0;\*\/"
    inreplace "submodules/sonLib/include.mk", "cflags_opt = -O3 -g -Wall --pedantic -funroll-loops -DNDEBUG", "cflags_opt = -O3 -g -Wall --pedantic -funroll-loops -DNDEBUG -fPIC"

    ENV["PWD"] = buildpath
    system 'make'
    
    inreplace "bin/runProgressiveCactus.sh" , "binDir=\$(dirname \$0)", "binDir=\'#{libexec}/progressive_cactus/bin\'"

    inreplace "environment" do |s|
      s.gsub! "#{buildpath}", "#{libexec}/progressive_cactus"
      s.gsub! /(export LD_LIBRARY_PATH=.+)/, '\1'"#{libexec}/progressive_cactus/submodules/tokyocabinet/lib:"
    end
    

    pc = libexec+'progressive_cactus'
    pc.mkpath()
    pc.install Dir['*']

    bin.install_symlink pc+'bin/runProgressiveCactus.sh'

  end
end
