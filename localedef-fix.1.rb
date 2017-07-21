# Copyright [2016] EMBL-European Bioinformatics Institute
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

  desc "Brew formula to fix localedef issues as not all required locales are installed by brew (only en_US.UTF-8)"
  homepage "http://www.linuxfromscratch.org/lfs/view/development/chapter06/glibc.html"
  # We know this is not the real location of this but it pins into the infrastructure/dependencies required
  url "https://raw.githubusercontent.com/Ensembl/homebrew-ensembl/master/subfiles/localefix"
  sha256 "7ac78fa34c46dde81ae38067facca7789dd06aff74ea865e9b536fdd847017fb"
  version '1.0.0'

  depends_on 'glibc'

  def install
    glibc = Formula['glibc']
    [
      ["cs_CZ", "UTF-8", "cs_CZ.UTF-8"],
      ["de_DE", "ISO-8859-1", "de_DE"],
      ["de_DE@euro", "ISO-8859-15", "de_DE@euro"],
      ["de_DE", "UTF-8", "de_DE.UTF-8"],
      ["en_GB", "UTF-8", "en_GB.UTF-8"],
      ["en_HK", "ISO-8859-1", "en_HK"],
      ["en_PH", "ISO-8859-1", "en_PH"],
      ["en_US", "ISO-8859-1", "en_US"],
      ["en_US", "UTF-8", "en_US.UTF-8"],
      ["es_MX", "ISO-8859-1", "es_MX"],
      ["fa_IR", "UTF-8", "fa_IR"],
      ["fr_FR", "ISO-8859-1", "fr_FR"],
      ["fr_FR@euro", "ISO-8859-15", "fr_FR@euro"],
      ["fr_FR", "UTF-8", "fr_FR.UTF-8"],
      ["it_IT", "ISO-8859-1", "it_IT"],
      ["it_IT", "UTF-8", "it_IT.UTF-8"],
      ["ja_JP", "EUC-JP", "ja_JP"],
      ["ru_RU", "KOI8-R", "ru_RU.KOI8-R"],
      ["ru_RU", "UTF-8", "ru_RU.UTF-8"],
      ["tr_TR", "UTF-8", "tr_TR.UTF-8"],
      ["zh_CN", "GB18030", "zh_CN.GB18030"]
    ].each do | l |
      system glibc.bin+'localedef', "-i", l[0], "-f", l[1], l[2]
    end
  end

  test do
    system "true"
  end
end
