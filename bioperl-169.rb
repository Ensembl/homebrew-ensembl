
# Licensed under the Apache License, Version 2.0 (the License);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Bioperl169 < Formula
  homepage 'http://bioperl.org/'
  desc 'Perl library for bioinformatic applications'
  url 'https://github.com/bioperl/bioperl-live/archive/release-1-6-924.tar.gz'
  sha256 '547a65a1c083bd40345514893cf91491d49318f2290dd8d0a539b742327cbe25'
  version '1.6.924'
  revision 1

  patch :DATA

  def install
    libexec.install Dir['*']
  end
end
__END__
diff -aur a/Bio/DB/Flat/BinarySearch.pm a/Bio/DB/Flat/BinarySearch.pm
--- a/Bio/DB/Flat/BinarySearch.pm
+++ a/Bio/DB/Flat/BinarySearch.pm
@@ -363,7 +363,7 @@
         );
     }
     else {
-        $self->{_seqio}->fh($fh);
+        $self->{_seqio}->_fh($fh);
     }

     return $self->{_seqio}->next_seq;
