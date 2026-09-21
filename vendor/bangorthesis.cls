%%% bangorthesis.cls — Bangor University thesis and dissertation class
% A thin orchestrator over the bangor module family: loads the report
% class, applies the brand layer, the document identity, the regulation
% layout with strict validation, and the statutory declarations, then
% adds only thesis-specific behaviour. Derived in part from the
% bangorcsthesis class by Cameron Gray, Bangor University. Released
% under the LaTeX Project Public License, version 1.3c or later.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bangorthesis}[2026/09/21 v5.3.5 Bangor University thesis and dissertation class]

\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=bts,prefix=bts@}

% Submission wording: research awards submit a thesis, taught awards
% submit a dissertation. The explicit options override the keywords.
\def\bts@submission{thesis}
\DeclareVoidOption{thesis}{\def\bts@submission{thesis}}
\DeclareVoidOption{dissertation}{\def\bts@submission{dissertation}}
\DeclareVoidOption{phd}{\def\bts@submission{thesis}}
\DeclareVoidOption{mphil}{\def\bts@submission{thesis}}
\DeclareVoidOption{mres}{\def\bts@submission{thesis}}
\DeclareVoidOption{mscres}{\def\bts@submission{thesis}}
\DeclareVoidOption{engd}{\def\bts@submission{thesis}}
\DeclareVoidOption{profdoc}{\def\bts@submission{thesis}}
\DeclareVoidOption{msc}{\def\bts@submission{dissertation}}
\DeclareVoidOption{ma}{\def\bts@submission{dissertation}}
\DeclareVoidOption{mba}{\def\bts@submission{dissertation}}
\DeclareVoidOption{llm}{\def\bts@submission{dissertation}}
\DeclareVoidOption{mmus}{\def\bts@submission{dissertation}}
\DeclareVoidOption{pgcert}{\def\bts@submission{dissertation}}
\DeclareVoidOption{pgdip}{\def\bts@submission{dissertation}}
\DeclareVoidOption{bsc}{\def\bts@submission{dissertation}}
\DeclareVoidOption{ba}{\def\bts@submission{dissertation}}
\DeclareVoidOption{beng}{\def\bts@submission{dissertation}}
\DeclareVoidOption{meng}{\def\bts@submission{dissertation}}
\DeclareVoidOption{msci}{\def\bts@submission{dissertation}}

% Citation style passed to biblatex through \bibliographysetup. Any
% biblatex style name is valid; ieee is the default because the
% founding use is computer science.
\DeclareStringOption[ieee]{citations}[ieee]

% Font choice and strict validation, forwarded to bangorlayout.
\DeclareStringOption[termes]{font}[termes]
\DeclareBoolOption[true]{strict}

% Print submission: leading blank page for duplex binding. Digital is
% the default state; the option exists to state it explicitly.
\DeclareBoolOption[false]{print}
\DeclareBoolOption[false]{digital}

% Welsh submission: statutory declaration in Welsh plus babel.
\DeclareBoolOption[false]{welsh}

% Running headers and footers. headers=chapter-section shows the chapter
% name on the left and the section name on the right of the header, with
% the page number in the footer. headers=chapter shows the chapter name
% and the page number in the header. Each rule is hairline, visible, or
% none, and the two rules are set separately. pageofm is on by default and
% prints the page number as "Page N of M"; pageofm=false prints the
% number alone.
\DeclareStringOption[chapter-section]{headers}[chapter-section]
\DeclareStringOption[hairline]{headrule}[hairline]
\DeclareStringOption[hairline]{footrule}[hairline]
\DeclareBoolOption[true]{pageofm}

% Page numbering. The title page carries no number, the front matter is numbered in roman numerals, and the numbering restarts in arabic at the first numbered chapter. The count restarts at each appendix and prints "Appendix A - Page n of m" with pageofm, and appendixpages=false continues the arabic sequence of the main text through the appendices instead.
\DeclareBoolOption[true]{appendixpages}

% Float numbering, on by default. sharedfloats puts every float type on one counter, so the sequence reads Figure 1, Table 2, Listing 3, and sharedfloats=false gives each type its own counter. sectionfloats numbers floats within their section, so the first float in section 5.1 is 5.1.1. Its value says what a float before the first section of a chapter is called: chapter numbers it by the chapter alone (5.1), zero numbers it by section zero (5.0.1), and none turns section numbering off so floats are numbered within their chapter. The two options combine.
\DeclareBoolOption[true]{sharedfloats}
\DeclareStringOption[chapter]{sectionfloats}[chapter]

% Contents entries. The contents lists the numbered chapters, the bibliography and the appendices. The unnumbered front matter (the abstract, the acknowledgements, the list of abbreviations and the lists of figures and tables) is not entered in it unless frontmattertoc is set, which enters all of them.
\DeclareBoolOption[false]{frontmattertoc}

% Everything else (12pt, a4paper, oneside, twoside, draft, final)
% passes through to the report class.
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{report}}

\ProcessKeyvalOptions{bts}

% Forward font, strict, and welsh settings to the modules that own
% them, before those modules load. The font value is expanded first:
% the class stores it as a macro, and the option list must carry the
% literal text.
\edef\bts@fontpass{font=\bts@font}
\expandafter\PassOptionsToPackage\expandafter{\bts@fontpass}{bangorlayout}
\ifbts@strict
  \PassOptionsToPackage{strict=true}{bangorlayout}
\else
  \PassOptionsToPackage{strict=false}{bangorlayout}
\fi
\ifbts@welsh
  \PassOptionsToPackage{welsh}{bangordeclarations}
\fi

\LoadClass{report}

\RequirePackage{bangor}
\bangorstamppart{bangorthesis}{bangorthesis.cls}
\RequirePackage{bangoridentity}
\RequirePackage{bangorlayout}
\RequirePackage{bangordeclarations}
% Protrusion only. The typographic benefit the class wants is
% protrusion; expansion instantiates extra stretched copies of every
% font size the document uses, which is real compile work whose cost
% scales with the font count and the runner, so it follows the
% estate's rule for extras: off by default, on per document with
% \microtypesetup{expansion=true} in the preamble. Interleaved
% measurement on a quiet machine showed no reliable difference either
% way at this document size; the setting is a conservatism choice, not
% a measured saving.
\RequirePackage[expansion=false]{microtype}
\RequirePackage{environ}
\RequirePackage{etoolbox}
\RequirePackage{amsmath}
% float is loaded first because a package that loads it after hyperref, as algorithm does, leaves every table and figure with a duplicate PDF destination, and the class cannot control what a document loads later.
\RequirePackage{float}
% plainpages=false keeps the page anchors of the roman, arabic and per-appendix numberings distinct.
\RequirePackage[hidelinks,plainpages=false]{hyperref}
% cleveref must load after hyperref AND amsmath. nameinlink makes the reference
% text itself a hyperlink. Capitalisation is left to the document:
% \cref produces lowercase type names mid-sentence, \Cref produces
% uppercase at a sentence opening, and the capitalise package option
% is deliberately not imposed here because no regulation mandates a
% reference style.
\RequirePackage[nameinlink]{cleveref}
\ifbts@welsh
  \RequirePackage[welsh]{babel}
\fi

% Bake the version stamp into the PDF metadata.
\AtBeginDocument{%
  \hypersetup{pdfsubject={\bangorversionstamp},
  pdfkeywords={Bangor University; \bangorversionstamp}}}

% Template version hook: a release-stamped version.tex may call this in
% the preamble so the template version is baked in alongside the
% package versions.
\newcommand{\templateversion}[1]{%
  \g@addto@macro\bangorversionstamp{; template #1}}

% Bibliography setup. Call once in the preamble, optionally with a
% biblatex style name; the default comes from the citations option.
\newcommand{\bibliographysetup}[1][\bts@citations]{%
  \RequirePackage[backend=biber,style=#1]{biblatex}}

% Title page. Its pages are numbered in letters, so that their page anchors differ from those of the front matter, but the empty page style prints no number. In print mode a blank page precedes it so that duplex printing leaves the title on a recto.
\renewcommand{\maketitle}{%
  \ifbts@print
    \pagenumbering{Alph}%
    \null\thispagestyle{empty}\newpage
  \fi
  \pagenumbering{alph}%
  \begin{titlepage}
    \centering
    \bangoridentityblock[3.5cm]
    \vfill
    {\LARGE\bfseries \@title \par}
    \vfill
    {A \bts@submission{} submitted to Bangor University\par
      for the degree of \bgi@degree\par}
    \vfill
    {\large \@author \par}
    \ifx\bgi@supervisors\@empty\else
      \vspace{1em}%
      \begin{minipage}{0.8\linewidth}
        \centering Supervisors:\par\bgi@supervisors
      \end{minipage}\par
    \fi
    \ifx\bgi@wordcount\@empty\else
      \vspace{1em}{Word count: \bgi@wordcount\par}%
    \fi
    \vfill
    {\ifx\bgi@date\@empty\@date\else\bgi@date\fi\par}
  \end{titlepage}
  \pagenumbering{roman}}

% Front matter conveniences. The abstract is single spaced, which the
% regulation permits, and its word count is checked against the
% regulation's 600-word cap. The count splits the body on spaces and
% counts the parts, so runs of spaces inflate it slightly: it is an
% approximate, conservative check, and a result near the cap deserves
% a precise recount before submission.
\ExplSyntaxOn
\int_const:Nn \c_bts_abstract_max_int { 600 }
\tl_new:N \l_bts_abstract_body_tl
\seq_new:N \l_bts_abstract_words_seq
\cs_new_protected:Npn \btsabstractcheck #1
{
  \tl_set:No \l_bts_abstract_body_tl {#1}
  \seq_set_split:NnV \l_bts_abstract_words_seq { ~ } \l_bts_abstract_body_tl
  \int_compare:nNnT { \seq_count:N \l_bts_abstract_words_seq }
  > \c_bts_abstract_max_int
  {
    \exp_args:Nee \use:c { bts@reportabstract }
    { \seq_count:N \l_bts_abstract_words_seq }
  }
}
\ExplSyntaxOff
\newcommand{\bts@reportabstract}[1]{%
  \bangorregulationviolation{The abstract is approximately
    #1\space words. The regulation caps the abstract at 600 words.
    Count the abstract precisely before you submit.}}
% An unnumbered chapter heading for the front matter. With frontmattertoc it is entered in the contents, after a phantom section so that the link lands on the heading. Without it the heading still gets a PDF bookmark, so the navigation pane lists it.
\newcounter{bts@front}
\newcommand{\bangorfrontheading}[1]{%
  \chapter*{#1}%
  \ifbts@frontmattertoc
    \phantomsection
    \addcontentsline{toc}{chapter}{#1}%
  \else
    \stepcounter{bts@front}%
    \pdfbookmark[0]{#1}{bts@front\arabic{bts@front}}%
  \fi}

\RenewEnviron{abstract}{%
  \btsabstractcheck{\BODY}%
  \begin{singlespace}
    \bangorfrontheading{Abstract}
    \BODY
    \par\end{singlespace}}

\newenvironment{acknowledgements}{%
  \begin{singlespace}
    \bangorfrontheading{Acknowledgements}
    }{%
    \par\end{singlespace}}

% The lists of figures and tables print only when the document has figures or tables. Each caption written to the list file marks the document in the auxiliary file, so the marker exists from the second run. The lists are headed like the rest of the front matter.
\newcommand{\bts@hasfloats}[1]{\global\@namedef{bts@has@#1}{}}
\@namedef{bts@marks@lof}{}
\@namedef{bts@marks@lot}{}
\let\bts@orig@addcontentsline\addcontentsline
\renewcommand{\addcontentsline}[3]{%
  \@ifundefined{bts@marks@#1}{}{%
    \@ifundefined{bts@seen@#1}{%
      \global\@namedef{bts@seen@#1}{}%
      \immediate\write\@auxout{\string\bts@hasfloats{#1}}}{}}%
  \bts@orig@addcontentsline{#1}{#2}{#3}}
\renewcommand{\listoffigures}{\bangorfrontheading{\listfigurename}\@starttoc{lof}}
\renewcommand{\listoftables}{\bangorfrontheading{\listtablename}\@starttoc{lot}}
\newcommand{\tables}{%
  \tableofcontents
  \@ifundefined{bts@has@lof}{}{\listoffigures}%
  \@ifundefined{bts@has@lot}{}{\listoftables}}

% Headers and footers. The option values are checked first so that a typo fails with a clear message instead of silently falling back to a default.
\RequirePackage{fancyhdr}
\RequirePackage{truncate}

\def\bts@rule@hairline{1sp}
\def\bts@rule@visible{0.4pt}
\def\bts@rule@none{0pt}
\newcommand{\bts@checkrule}[2]{%
  \@ifundefined{bts@rule@#2}{%
    \ClassError{bangorthesis}{Unknown #1 value `#2'}{The permitted values are hairline, visible, and none.}}{}}
\bts@checkrule{headrule}{\bts@headrule}
\bts@checkrule{footrule}{\bts@footrule}

\newif\ifbts@chapteronly
\def\bts@hd@chapter{chapter}
\def\bts@hd@chaptersection{chapter-section}
\ifx\bts@headers\bts@hd@chapter
  \bts@chapteronlytrue
\else
  \ifx\bts@headers\bts@hd@chaptersection\else
    \ClassError{bangorthesis}{Unknown headers value `\bts@headers'}{The permitted values are chapter-section and chapter.}%
  \fi
\fi

% The blank page that \cleardoublepage inserts before a chapter on a right-hand page is empty, so it prints no number and no running header.
\renewcommand{\cleardoublepage}{%
  \clearpage
  \if@twoside
    \ifodd\c@page\else
      \hbox{}\thispagestyle{empty}\newpage
      \if@twocolumn\hbox{}\newpage\fi
    \fi
  \fi}

% Where the numbering stands. The document opens in the front matter. The first numbered chapter starts the main matter, and the first appendix chapter starts the appendices when appendixpages is set. Each switch runs inside \@chapter, after the page break that precedes the chapter, so the last page before the switch keeps the old numbering.
\newif\ifbts@main
\newif\ifbts@appendixstyle
\newif\ifbts@appendixnumbering
\newcommand{\bts@startmain}{%
  \bts@maintrue
  \pagenumbering{arabic}%
  \gdef\thepage{\ifbts@appendixnumbering\thechapter-\fi\@arabic\c@page}%
  \pagestyle{bts@main}}
\newcommand{\bts@chapterhook}{%
  \ifbts@main\else\bts@startmain\fi
  \ifbts@appendixstyle\bts@appendixnumberingtrue\fi
  \ifbts@appendixnumbering\setcounter{page}{1}\fi}
\pretocmd{\@chapter}{\bts@chapterhook}{}{}

% The labels that supply M in "Page N of M". Each is written to the auxiliary file after the last page it names has shipped, because a label placed in the text is lost when the document ends on a float page, where nothing follows it to carry it onto a page. Without appendix numbering there is one, on the last page of the document. With it, bts@lastpage names the last page before the appendices, and each appendix has its own, bts@appendix@A and so on, naming its last page in the appendix count. A chapter command closes the section before it, and the end of the document closes the last one. Each label is written once, so a starred chapter after the appendices does not write a second.
\newcommand{\bts@writelast}[1]{%
  \@ifundefined{bts@written@#1}{%
    \global\@namedef{bts@written@#1}{}%
    \clearpage
    \addtocounter{page}{-1}%
    \immediate\write\@auxout{\string\newlabel{#1}{{}{\@arabic\c@page}{}{}{}}}%
    \addtocounter{page}{1}}{}}
\newcommand{\bts@closesection}{%
  \ifbts@appendixstyle
    \ifbts@appendixnumbering
      \bts@writelast{bts@appendix@\thechapter}%
    \else
      \bts@writelast{bts@lastpage}%
    \fi
  \fi}
\pretocmd{\chapter}{\bts@closesection}{}{}
\apptocmd{\appendix}{\ifbts@appendixpages\bts@appendixstyletrue\fi}{}{}
\AtEndDocument{%
  \ifbts@appendixnumbering
    \bts@writelast{bts@appendix@\thechapter}%
  \else
    \bts@writelast{bts@lastpage}%
  \fi}

% The page number in the main matter, optionally as "Page N of M". In an appendix the number and the total count within that appendix.
\newcommand{\bts@pagenumber}{%
  \ifbts@appendixnumbering
  Appendix~\thechapter{} - Page~\arabic{page}%
  \ifbts@pageofm~of~\pageref*{bts@appendix@\thechapter}\fi
  \else
  \ifbts@pageofm Page~\thepage~of~\pageref*{bts@lastpage}\else\thepage\fi
  \fi}

% Names in the header may use this share of the text width each. Chapter and section names that repeat one another (contents, bibliography) show once.
\newcommand{\bts@maxheader}{0.42\textwidth}

% \truncate always sets its text in a box of the full width it is given, aligned to the left, so it is used only for text that does not fit. Text that fits keeps its natural width and takes the alignment of its header field, which puts the section name flush right.
\newcommand{\bts@fit}[1]{%
  \settowidth{\@tempdima}{#1}%
  \ifdim\@tempdima>\bts@maxheader\relax
    \truncate{\bts@maxheader}{#1}%
  \else
    #1%
  \fi}
\newcommand{\bts@headleft}{\small\itshape\nouppercase{\bts@fit{\leftmark}}}
\newcommand{\bts@headright}{%
  \small\itshape\nouppercase{%
    \edef\bts@leftcopy{\leftmark}\edef\bts@rightcopy{\rightmark}%
    \ifx\bts@leftcopy\bts@rightcopy\else\bts@fit{\rightmark}\fi}}

% fancyhdr needs enough vertical space for the running header text; the report class default is too small for 12pt italic chapter names.
\setlength{\headheight}{14pt}

% Each layout is a named style that sets every field it uses. A fancypagestyle applies its settings without grouping them, so a style that relied on fields left by another would inherit them.
\fancypagestyle{bts@main}{%
  \fancyhf{}
  \renewcommand{\headrulewidth}{\csname bts@rule@\bts@headrule\endcsname}
  \renewcommand{\footrulewidth}{\csname bts@rule@\bts@footrule\endcsname}
  \fancyhead[L]{\bts@headleft}
  \fancyfoot[L]{\footnotesize\itshape\truncate{0.4\textwidth}{\bts@footertext}}
  \ifbts@chapteronly
    \fancyhead[R]{\small\bts@pagenumber}
  \else
    \fancyhead[R]{\bts@headright}
    \fancyfoot[R]{\small\bts@pagenumber}
  \fi}

% Chapter openings have no header. The page number keeps the place it has on the other pages of the same layout, and in the front matter it is the centred roman numeral.
\fancypagestyle{plain}{%
  \fancyhf{}
  \fancyfoot[C]{\ifbts@main\ifbts@chapteronly\small\bts@pagenumber\fi\else\small\thepage\fi}
  \fancyfoot[R]{\ifbts@main\ifbts@chapteronly\else\small\bts@pagenumber\fi\fi}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{\csname bts@rule@\bts@footrule\endcsname}}
% The front matter has no running header, and its page number is a centred roman numeral. The document opens in this style, and \bts@startmain switches to the main style at the first numbered chapter.
\fancypagestyle{bts@front}{%
  \fancyhf{}
  \fancyfoot[C]{\small\thepage}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{\csname bts@rule@\bts@footrule\endcsname}}
\pagestyle{bts@front}
\AtBeginDocument{\pagenumbering{roman}}

% A name too wide for the header is a build error in strict mode and is truncated with a warning otherwise. The kernel short-title syntax, \chapter[Short]{Long}, passes the short title to these marks, so the check runs on the title that will be printed.
\newcommand{\bts@checkwidth}[3]{%
  \begingroup
  \settowidth{\@tempdima}{\small\itshape #2}%
  \ifdim\@tempdima>\bts@maxheader\relax
    \bangorregulationviolation{#1 is too wide for the running header (\the\@tempdima, and the maximum is \the\dimexpr\bts@maxheader\relax). #3}%
  \fi
  \endgroup}
\renewcommand{\chaptermark}[1]{%
  \bts@checkwidth{Chapter \thechapter}{\thechapter.\ #1}{Use \string\chapter[Short title]\string{Long title\string} to set a shorter running title.}%
  \markboth{\thechapter.\ #1}{}}
\renewcommand{\sectionmark}[1]{%
  \bts@checkwidth{Section \thesection}{\thesection.\ #1}{Use \string\section[Short title]\string{Long title\string} to set a shorter running title.}%
  \markright{\thesection.\ #1}}

% The footer shows the short title when one is set, and otherwise the full title with its line breaks turned into spaces. Either is checked against the footer width.
\def\bts@skipbracket[#1]{\space}
\newcommand{\bts@checkfooter}[2]{%
  \begingroup
  \settowidth{\@tempdima}{\footnotesize\itshape\bts@footertext}%
  \ifdim\@tempdima>0.4\textwidth\relax
    \bangorregulationviolation{#1 (\the\@tempdima, and the maximum is \the\dimexpr0.4\textwidth\relax). #2}%
  \fi
  \endgroup}
\AtBeginDocument{%
\ifx\bgi@shorttitle\@empty
\begingroup
\def\\{\@ifnextchar[{\bts@skipbracket}{\space}}%
\protected@xdef\bts@footertext{\@title}%
\endgroup
\bts@checkfooter{The title is too wide for the footer}{Set \string\shorttitle\string{Short title\string} in the preamble.}%
\else
\let\bts@footertext\bgi@shorttitle
\bts@checkfooter{The short title is too wide for the footer}{Use a shorter \string\shorttitle.}%
\fi}

% Float numbering. The switch runs at the very end of the begindocument hook because packages such as listings create their counters lazily and would fail on a counter that already exists. Counters whose package is not loaded are skipped, so the same list serves every document. A shared counter is another name for the figure register, and the number format and the hyperref anchor name of each shared type are defined as calls to \thefigure and \theHfigure, because a copy taken before they are redefined would keep the old format, and an anchor name built from the type's own parent counters would repeat within a chapter as the shared count restarts in each section.
\def\bts@sfv@none{}
\def\bts@sfv@chapter{}
\def\bts@sfv@zero{}
\@ifundefined{bts@sfv@\bts@sectionfloats}{%
  \ClassError{bangorthesis}{Unknown sectionfloats value `\bts@sectionfloats'}{The permitted values are none, chapter, and zero.}}{}
\newcommand{\bts@numberfloat}[1]{%
  \ifdefstring{\bts@sectionfloats}{none}{}{%
    \counterwithin{#1}{section}%
    \ifdefstring{\bts@sectionfloats}{chapter}{%
      \expandafter\gdef\csname the#1\endcsname{\ifnum\value{section}=0 \thechapter.\else\thesection.\fi\arabic{#1}}}{}}}
\newcommand{\bts@shareorfloat}{%
  \ifbts@sharedfloats
    \@for\bts@floatcounter:=table,lstlisting,algorithm\do{%
      \@ifundefined{c@\bts@floatcounter}{}{%
        \expandafter\let\csname c@\bts@floatcounter\expandafter\endcsname\csname c@figure\endcsname
        \expandafter\gdef\csname the\bts@floatcounter\endcsname{\thefigure}%
        \expandafter\gdef\csname theH\bts@floatcounter\endcsname{\theHfigure}}}%
    \bts@numberfloat{figure}%
  \else
    \@for\bts@floatcounter:=figure,table,lstlisting,algorithm\do{%
      \@ifundefined{c@\bts@floatcounter}{}{\expandafter\bts@numberfloat\expandafter{\bts@floatcounter}}}%
  \fi}
\AddToHook{begindocument/end}{\bts@shareorfloat}

% Captions with descriptions. The caption package provides the machinery; these settings pin ordinary captions to the report class look, so loading it changes nothing the reader can see.
\RequirePackage{caption}
\captionsetup{font=normal, labelfont=normal, labelsep=colon, skip=10pt}
% The description style: smaller than the body, never centred even when it fits one line (singlelinecheck=false), with a small gap under the caption above.
\DeclareCaptionStyle{bangordescription}{font=small, skip=0.35\baselineskip, justification=justified, singlelinecheck=false}
% \captiondesc[short]{title}{description} is the caption form that also carries a description paragraph beneath the title. The optional argument is the list-of-floats entry and defaults to the title, as with \caption. The description never enters any list and steps no counter. The group keeps the description style off the float's own caption.
\NewDocumentCommand { \captiondesc } { o +m +m }
{%
  \IfValueTF { #1 }
  { \caption [ #1 ] { #2 } }
  { \caption { #2 } }%
  \begingroup
  \captionsetup { style=bangordescription }%
  \caption* { #3 }%
  \endgroup}

% A list-of-floats entry that runs on is hard to scan, so the class caps its length. The threshold is 80 characters, the same figure the author's thesis settled on; no regulation sets one. The measurement fires inside \addcontentsline, so the log names the caption's source line, and it sees every float list the document produces (figures, tables, listings, algorithms). The extraction strips the wrapping packages add around the entry text before counting.
\ExplSyntaxOn
\int_const:Nn \c_bts_caption_maxlen_int { 80 }
\int_new:N \l_bts_caption_len_int
\tl_new:N \l_bts_caption_ext_tl
\tl_new:N \l_bts_caption_raw_tl
\tl_new:N \l_bts_caption_str_tl
\cs_new_protected:Npn \__bts_check_caption_len:nnn #1 #2 #3
{
  \tl_set:Nx \l_bts_caption_ext_tl {#1}
  \str_case:Vn \l_bts_caption_ext_tl
  {
    { lof } { \__bts_measure_caption:Vn \l_bts_caption_ext_tl {#3} }
      { lot } { \__bts_measure_caption:Vn \l_bts_caption_ext_tl {#3} }
      { lol } { \__bts_measure_caption:Vn \l_bts_caption_ext_tl {#3} }
      { loa } { \__bts_measure_caption:Vn \l_bts_caption_ext_tl {#3} }
  }
}
\cs_generate_variant:Nn \__bts_measure_caption:nn { Vn }
\cs_new_protected:Npn \__bts_measure_caption:nn #1 #2
{
  \tl_set:Nx \l_bts_caption_raw_tl { \tl_to_str:n {#2} }
  \tl_set_eq:NN \l_bts_caption_str_tl \l_bts_caption_raw_tl
  \regex_replace_once:nnN
  { \A .* \ignorespaces \x{20} } { } \l_bts_caption_str_tl
  \regex_replace_once:nnN
  { \x{20}* (\relax \x{20}*)? \x{7D}? \x{20}* \Z } { } \l_bts_caption_str_tl
  \regex_replace_once:nnN
  { \A .* \numberline \x{20} \x{7B} [^\x{7D}]* \x{7D} \x{20}? }
  { } \l_bts_caption_str_tl
  \int_set:Nn \l_bts_caption_len_int { \str_count:N \l_bts_caption_str_tl }
  \int_compare:nNnT { \l_bts_caption_len_int } > { \c_bts_caption_maxlen_int }
    { \__bts_report_long_entry: }
}
\cs_new_protected:Npn \__bts_report_long_entry:
{
  \exp_args:Nx \bangorregulationviolation
  { The~list-of-floats~entry~is~\int_use:N \l_bts_caption_len_int \c_space_tl characters,~and~the~maximum~is~80.~Give~the~caption~a~short~form:~
    \string\caption[short]\{title\}~or~
    \string\captiondesc[short]\{title\}\{description\}. }
}
\AddToHook { begindocument/end }
{
  \let\bts@origlen@addcontentsline\addcontentsline
  \renewcommand{\addcontentsline}[3]{%
    \__bts_check_caption_len:nnn {#1} {#2} {#3}%
    \bts@origlen@addcontentsline {#1} {#2} {#3}}
}
\ExplSyntaxOff

% cleveref does not auto-detect the listings package's lstlisting
% counter because listings loads after cleveref (it is a template-level
% concern). Declaring the format here means templates that use listings
% get "Listing 1" cross-references out of the box.
\crefname{lstlisting}{Listing}{Listings}
\Crefname{lstlisting}{Listing}{Listings}

\endinput
