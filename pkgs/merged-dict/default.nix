{
  lib,
  runCommand,
  iconv,
  skkDictionaries,
  skktools,
}:
runCommand "skk-merged-dict" { } ''
  ${iconv}/bin/iconv -f euc-jp -t utf-8 ${skkDictionaries.l}/share/skk/SKK-JISYO.L > SKK-JISYO.L
  cp ${skkDictionaries.emoji}/share/skk/SKK-JISYO.emoji .

  mkdir -p $out/share/skk
  echo ';;; -*- coding: utf-8 -*-' > $out/share/skk/SKK-JISYO.L
  ${skktools}/bin/skkdic-expr2 SKK-JISYO.L + SKK-JISYO.emoji >> $out/share/skk/SKK-JISYO.L
''
