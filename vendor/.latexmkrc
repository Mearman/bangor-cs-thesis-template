# latexmk defaults for this repository: PDF output via pdflatex with
# biber for biblatex, matching the CI and Overleaf behaviour. latexmk
# reruns only the passes the auxiliary files require, which gives
# incremental builds locally without any extra configuration.
$pdf_mode = 1;
$bibtex_use = 2;
