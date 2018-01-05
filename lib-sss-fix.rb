
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class LibSssFix < Formula

  desc "Brew formula to fix glibc with libnss_sss to enable getpwent for non /etc/passwd user entries"
  homepage "https://fedorahosted.org/sssd/"
  # We know this is not the real location of this but it pins into the infrastructure/dependencies required
  url "https://fedorahosted.org/released/sssd/sssd-1.14.2.tar.gz.asc"
  sha256 "10f113a182a7464ab2b0f4bf0e99a848a64af4a5d3aa8165d4fe4eec2126ff24"
  version '1.0.0'

  depends_on 'glibc'

  def install
    glibc = Formula['glibc']
    brew_libnss_sss = Pathname.new glibc.lib+"libnss_sss.so.2"
    
    if ! brew_libnss_sss.exist?
      locations = %w[/lib /lib64 /usr/lib /usr/lib64]
      locations.each do |l|
        sys_libnss_sss = Pathname.new "#{l}/libnss_sss.so.2"

        #Skip if the library does not exist
        if ! sys_libnss_sss.exist?
          next
        end

        glibc.lib.install_symlink sys_libnss_sss
        marker = (prefix+'libnss_sss_fix')
        File.delete(marker) if File.exists?(marker)
        (marker).write <<-EOF.undent
          Installed symbolic link for glibc
        EOF
      end
    end
  end

  test do
    system "true"
  end
end
