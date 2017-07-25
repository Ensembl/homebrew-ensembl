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

class Bioperl161 < Formula
  homepage 'http://bioperl.org/'
  desc 'Perl library for bioinformatic applications'
  url 'https://github.com/bioperl/bioperl-live/archive/bioperl-release-1-6-1.tar.gz'
  sha256 'a7eb4bafd014ebd55462d7020fffa265ece764d8f5699723bc4493b2da04ece1'
  version '1.6.1'
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
@@ -353,7 +353,7 @@
     $self->{_seqio} = Bio::SeqIO->new(-fh => $fh,
                      -format => $self->format);
     } else {
-	$self->{_seqio}->fh($fh);
+  $self->{_seqio}->_fh($fh);
     }

     return $self->{_seqio}->next_seq;
