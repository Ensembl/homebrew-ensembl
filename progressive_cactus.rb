
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
  url 'https://github.com/glennhickey/progressiveCactus.git', :using => :git, :revision => "f102445"
  version 'f102445'


  def install
    ENV["PWD"] = buildpath
    system 'git', 'submodule', 'update', '--init'

    cd 'submodules/jobTree' do
      system 'git', 'fetch'
      system 'git', 'checkout', '072be69'
    end
    inreplace "submodules/jobTree/batchSystems/lsf.py" do |s|
      s.gsub! /\+ \'000\'/, " "
    end

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
