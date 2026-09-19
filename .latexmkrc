# Resolve the vendored package modules and the crest without any
# install step. Overleaf runs latexmk, so this file is the whole
# integration.
$ENV{'TEXINPUTS'} = 'vendor//:' . ($ENV{'TEXINPUTS'} || '');
$pdf_mode = 1;
$bibtex_use = 2;
