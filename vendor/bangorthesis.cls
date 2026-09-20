%%% bangorthesis.cls — Bangor University thesis and dissertation class
% A thin orchestrator over the bangor module family: loads the report
% class, applies the brand layer, the document identity, the regulation
% layout with strict validation, and the statutory declarations, then
% adds only thesis-specific behaviour. Derived in part from the
% bangorcsthesis class by Cameron Gray, Bangor University. Released
% under the LaTeX Project Public License, version 1.3c or later.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bangorthesis}[2026/09/20 v1.1.1 Bangor University thesis and dissertation class]

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

% Citation style passed to biblatex through \bibliographySetup. Any
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
\RequirePackage{bangortables}
\RequirePackage{bangorglossary}
\RequirePackage[hidelinks]{hyperref}
% cleveref must load after hyperref. nameinlink makes the reference
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
\newcommand{\bibliographySetup}[1][\bts@citations]{%
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

% Running headers: chapter name on the left, page number on the
% right, with a thin rule. Chapter-opening pages use the plain
% style (page number centred at the bottom, no header), which the
% report class already applies to \chapter pages.
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\small\itshape\nouppercase{\leftmark}}
\fancyhead[R]{\small\thepage}
\renewcommand{\headrulewidth}{0.4pt}
\fancypagestyle{plain}{%
  \fancyhf{}
  \fancyfoot[C]{\thepage}
  \renewcommand{\headrulewidth}{0pt}
}

\endinput
