%%% bangorthesis.cls — Bangor University thesis and dissertation class
% A thin orchestrator over the bangor module family: loads the report
% class, applies the brand layer, the document identity, the regulation
% layout with strict validation, and the statutory declarations, then
% adds only thesis-specific behaviour. Derived in part from the
% bangorcsthesis class by Cameron Gray, Bangor University. Released
% under the LaTeX Project Public License, version 1.3c or later.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bangorthesis}[2026/09/20 v2.1.0 Bangor University thesis and dissertation class]

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
% none, and the two rules are set separately. pageofm prints the page
% number as "Page N of M".
\DeclareStringOption[chapter-section]{headers}[chapter-section]
\DeclareStringOption[hairline]{headrule}[hairline]
\DeclareStringOption[hairline]{footrule}[hairline]
\DeclareBoolOption[false]{pageofm}

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
\RequirePackage{amsmath}
\RequirePackage[hidelinks]{hyperref}
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

% Title page. In print mode a blank page precedes it so that duplex
% printing leaves the title on a recto.
\renewcommand{\maketitle}{%
  \ifbts@print
    \null\thispagestyle{empty}\newpage
  \fi
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
  \end{titlepage}}

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
    \markboth{Abstract}{}
    \addcontentsline{toc}{chapter}{Abstract}
    \BODY
    \par\end{singlespace}}

\newenvironment{acknowledgements}{%
  \begin{singlespace}
    \chapter*{Acknowledgements}
    \markboth{Acknowledgements}{}
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

% The page number, optionally as "Page N of M". The label that supplies M sits on the last page of the document.
\newcommand{\bts@pagenumber}{\ifbts@pageofm Page~\thepage~of~\pageref{bts@lastpage}\else\thepage\fi}
\AtEndDocument{\ifbts@pageofm\label{bts@lastpage}\fi}

% Names in the header may use this share of the text width each. Chapter and section names that repeat one another (contents, bibliography) show once.
\newcommand{\bts@maxheader}{0.42\textwidth}
\newcommand{\bts@headleft}{\small\itshape\nouppercase{\truncate{\bts@maxheader}{\leftmark}}}
\newcommand{\bts@headright}{%
  \small\itshape\nouppercase{%
    \edef\bts@leftcopy{\leftmark}\edef\bts@rightcopy{\rightmark}%
    \ifx\bts@leftcopy\bts@rightcopy\else\truncate{\bts@maxheader}{\rightmark}\fi}}

% fancyhdr needs enough vertical space for the running header text; the report class default is too small for 12pt italic chapter names.
\pagestyle{fancy}
\fancyhf{}
\setlength{\headheight}{14pt}
\renewcommand{\headrulewidth}{\csname bts@rule@\bts@headrule\endcsname}
\renewcommand{\footrulewidth}{\csname bts@rule@\bts@footrule\endcsname}
\fancyhead[L]{\bts@headleft}
\fancyfoot[L]{\footnotesize\itshape\truncate{0.4\textwidth}{\bts@footertext}}
\ifbts@chapteronly
  \fancyhead[R]{\small\bts@pagenumber}
\else
  \fancyhead[R]{\bts@headright}
  \fancyfoot[R]{\small\bts@pagenumber}
\fi

% Chapter openings have no header. The page number keeps the place it has on the other pages of the same layout.
\fancypagestyle{plain}{%
  \fancyhf{}
  \ifbts@chapteronly
    \fancyfoot[C]{\small\bts@pagenumber}%
  \else
    \fancyfoot[R]{\small\bts@pagenumber}%
  \fi
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{\csname bts@rule@\bts@footrule\endcsname}}

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

% cleveref does not auto-detect the listings package's lstlisting
% counter because listings loads after cleveref (it is a template-level
% concern). Declaring the format here means templates that use listings
% get "Listing 1" cross-references out of the box.
\crefname{lstlisting}{Listing}{Listings}
\Crefname{lstlisting}{Listing}{Listings}

\endinput
