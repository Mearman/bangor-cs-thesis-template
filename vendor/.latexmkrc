# latexmk defaults for this repository: PDF output via pdflatex with
# biber for biblatex, matching the CI and Overleaf behaviour. latexmk
# reruns only the passes the auxiliary files require, which gives
# incremental builds locally without any extra configuration. The
# smoke tests add their directory to BIBINPUTS so biber resolves
# smoke.bib when latexmk runs from the repository root.
$pdf_mode = 1;
$bibtex_use = 2;
$ENV{'BIBINPUTS'} = 'tests/smoke//' . ($ENV{'BIBINPUTS'} ? ':' . $ENV{'BIBINPUTS'} : '');
