%%% bangorthesis.cls — Bangor University thesis and dissertation class
% A thin orchestrator over the bangor module family: loads the report
% class, applies the brand layer, the document identity, the regulation
% layout with strict validation, and the statutory declarations, then
% adds only thesis-specific behaviour. Derived in part from the
% bangorcsthesis class by Cameron Gray, Bangor University. Released
% under the LaTeX Project Public License, version 1.3c or later.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bangorthesis}[2026/09/20 v4.1.1 Bangor University thesis and dissertation class]

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
\RequirePackage{microtype}
\RequirePackage{environ}
\RequirePackage{etoolbox}
\RequirePackage{amsmath}
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
\RenewEnviron{abstract}{%
  \btsabstractcheck{\BODY}%
  \begin{singlespace}
    \chapter*{Abstract}
    \addcontentsline{toc}{chapter}{Abstract}
    \BODY
    \par\end{singlespace}}

\newenvironment{acknowledgements}{%
  \begin{singlespace}
    \chapter*{Acknowledgements}
    \addcontentsline{toc}{chapter}{Acknowledgements}
    }{%
    \par\end{singlespace}}

\newcommand{\tables}{%
  \tableofcontents
  \listoffigures
  \listoftables}

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
  \ifbts@pageofm~of~\pageref{bts@appendix@\thechapter}\fi
  \else
  \ifbts@pageofm Page~\thepage~of~\pageref{bts@lastpage}\else\thepage\fi
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

% Float numbering. The switch runs at the very end of the begindocument hook because packages such as listings create their counters lazily and would fail on a counter that already exists. Counters whose package is not loaded are skipped, so the same list serves every document. A shared counter is another name for the figure register, and the number format of each shared type is defined as a call to \thefigure, because a copy of \thefigure taken before it is redefined would keep the old format.
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
        \expandafter\gdef\csname the\bts@floatcounter\endcsname{\thefigure}}}%
    \bts@numberfloat{figure}%
  \else
    \@for\bts@floatcounter:=figure,table,lstlisting,algorithm\do{%
      \@ifundefined{c@\bts@floatcounter}{}{\expandafter\bts@numberfloat\expandafter{\bts@floatcounter}}}%
  \fi}
\AddToHook{begindocument/end}{\bts@shareorfloat}

% cleveref does not auto-detect the listings package's lstlisting
% counter because listings loads after cleveref (it is a template-level
% concern). Declaring the format here means templates that use listings
% get "Listing 1" cross-references out of the box.
\crefname{lstlisting}{Listing}{Listings}
\Crefname{lstlisting}{Listing}{Listings}

\endinput
