%%% bangor.cls — Bangor University thesis, dissertation and letter class
% One self-contained class. With a degree option it typesets a thesis or
% dissertation to the regulation layout with strict validation; with the
% letter option it typesets a headed university letter. The brand layer
% (palette, crest, wordmark, version stamp) and the document identity are
% shared by both modes. The tables and glossary options add the table
% pagination and abbreviation features to a thesis. The only external
% file is the crest, bangor-crest-colour.pdf, which sits beside this file.
%
% Derived in part from the bangorcsthesis class by Cameron Gray, Bangor
% University. Released under the LaTeX Project Public License, version
% 1.3c or later (see LICENSE).
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bangor}[2026/09/24 v6.0.0 Bangor University thesis, dissertation and letter class]

%%% 1. Options and mode selection

\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=bts,prefix=bts@}

% Letter mode. The letter option loads the standard letter class and the headed letter style instead of the report class and the thesis machinery.
\DeclareBoolOption[false]{letter}

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

% Font choice and strict validation, read by the layout section.
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

% Optional thesis features: the longtabular environment, and the abbreviation list.
\DeclareBoolOption[false]{tables}
\DeclareBoolOption[false]{glossary}

% Everything else (12pt, a4paper, oneside, twoside, draft, final) passes through to the class that is loaded. Both candidates receive it, and only the one that loads uses it.
\DeclareDefaultOption{%
  \PassOptionsToClass{\CurrentOption}{report}%
  \PassOptionsToClass{\CurrentOption}{letter}}

\ProcessKeyvalOptions{bts}

% A letter has no thesis options. The raw option list is scanned, because the processed values cannot tell an option that was given from a default it happens to equal.
\ExplSyntaxOn
\clist_new:N \c__bts_thesis_only_clist
\clist_set:Nn \c__bts_thesis_only_clist
{
  thesis, dissertation, phd, mphil, mres, mscres, engd, profdoc,
  msc, ma, mba, llm, mmus, pgcert, pgdip, bsc, ba, beng, meng, msci,
  citations, font, strict, print, digital, welsh,
  headers, headrule, footrule, pageofm, appendixpages,
  sharedfloats, sectionfloats, frontmattertoc, tables, glossary
}
\tl_new:N \l__bts_optlist_tl
\cs_new_protected:Npn \__bts_check_letter_options:
{
  \cs_if_exist:NTF \@classoptionslist
  { \tl_set_eq:NN \l__bts_optlist_tl \@classoptionslist }
  { \tl_set_eq:NN \l__bts_optlist_tl \@raw@classoptionslist }
  \clist_map_inline:Nn \c__bts_thesis_only_clist
  {
    \regex_match:nVT { (\A|,) \s* ##1 \s* (,|=|\Z) } \l__bts_optlist_tl
    {
      \ClassError { bangor }
      { The~option~`##1'~cannot~be~combined~with~letter }
      { The~letter~option~selects~the~letter~mode,~which~takes~no~thesis~options. }
    }
  }
}
\ifbts@letter \__bts_check_letter_options: \fi
\ExplSyntaxOff
\ifbts@letter
  \LoadClass{letter}
\else
  \LoadClass{report}
\fi

%%% 2. Brand layer (both modes): palette, wordmark, crest, version stamp

\RequirePackage{graphicx}
\RequirePackage{xcolor}

% Primary palette from the Bangor University brand hub.
\definecolor{bangorred}{HTML}{ED0000}
\definecolor{bangorsun}{HTML}{FDB913}

% The wordmark is the institution name in bold. Black by default,
% following the brand guidance that colours should not be overused;
% formal documents such as thesis title pages expect black. Pass a
% colour name for surfaces that want the accent, for example the
% letterhead, whose rule already carries the brand red.
\newcommand{\bangorwordmark}[1][black]{%
  {\color{#1}\bfseries Bangor University}}

% The crest ships as a pre-rendered vector PDF beside this file. It is checked when it is first used, so a document that never prints the crest never warns. A missing crest prints a frame of the crest's own proportions holding the wordmark, with one warning.
\newif\ifbts@crestwarned
\newlength{\bts@crestheight}
\newcommand{\bangorcrest}[1][3cm]{%
  \IfFileExists{bangor-crest-colour.pdf}{%
    \includegraphics[width=#1]{bangor-crest-colour}%
  }{%
    \ifbts@crestwarned\else
      \global\bts@crestwarnedtrue
      \ClassWarning{bangor}{bangor-crest-colour.pdf was not found\MessageBreak
        Download it from\MessageBreak
        https://github.com/Mearman/bangor/releases/latest/download/bangor-crest-colour.pdf\MessageBreak
        and place it beside bangor.cls. A placeholder is printed instead}%
    \fi
    \setlength{\bts@crestheight}{0.81\dimexpr#1\relax}%
    {\setlength{\fboxsep}{0pt}%
      \fbox{\parbox[c][\bts@crestheight][c]{#1}{%
          \centering\sloppy\footnotesize\bangorwordmark}}}%
  }}

% Version stamp. The register is filled by the kernel from the version
% line above, and the \csname lookup expands at use time. The stamp feeds
% the PDF metadata and may be printed in a colophon.
\newcommand{\bangorversionstamp}{bangor \csname ver@bangor.cls\endcsname}

% Template version hook: a release-stamped version.tex may call this in
% the preamble so the template version is baked in alongside the class
% version.
\newcommand{\templateversion}[1]{%
  \g@addto@macro\bangorversionstamp{; template #1}}

%%% 3. Document identity (both modes)
% Stores the document-level identity and renders the identity block that
% combines it with the brand facts above. School and college are free
% text on purpose: the university renames its schools and colleges, so
% the class never enumerates them.

% Metadata storage. Defaults are empty; consumers render conditionally.
\newcommand{\school}[1]{\gdef\bts@school{#1}}
\newcommand{\college}[1]{\gdef\bts@college{#1}}
\newcommand{\degreescheme}[1]{\gdef\bts@degree{#1}}
\newcommand{\submissiondate}[1]{\gdef\bts@date{#1}}
\def\bts@school{}
\def\bts@college{}
\def\bts@degree{}
\def\bts@date{}

% Taught dissertations commonly must state their word count. When set,
% consumers print it; research degrees leave it unset.
\newcommand{\submissionwordcount}[1]{\gdef\bts@wordcount{#1}}
\def\bts@wordcount{}

% A short form of the title for the running footer. When it is unset,
% consumers fall back to the full title.
\newcommand{\shorttitle}[1]{\gdef\bts@shorttitle{#1}}
\def\bts@shorttitle{}

% Supervisors accumulate in declaration order, separated for typesetting.
\def\bts@supervisors{}
\newcommand{\supervisor}[1]{%
  \ifx\bts@supervisors\@empty
    \gdef\bts@supervisors{#1}%
  \else
    \g@addto@macro\bts@supervisors{\\#1}%
  \fi}

% The rendered identity block: crest, wordmark, then the school and
% college lines when set. Shared by the thesis title page and the
% letter letterhead, so neither typesets brand facts itself.
\newcommand{\bangoridentityblock}[1][2.5cm]{%
  \begin{center}
    \bangorcrest[#1]\par
    \vspace{0.6em}%
    {\Large\bangorwordmark\par}
    \ifx\bts@school\@empty\else
      \vspace{0.3em}{\large \bts@school\par}\fi
    \ifx\bts@college\@empty\else
      {\large \bts@college\par}\fi
  \end{center}}

%%% 4. Letter mode: the headed letter style, then the end of the class
% Renders the university letterhead for use with the letter environment:
% the crest at reduced scale, the wordmark, a thin rule in the brand
% red, and the school line when the document sets one. Colours are used
% sparingly, following the brand guidance. The line that ends the file
% carries its own \fi, because \endinput stops the file after the line it
% stands on, and the conditional must be closed by then.
\ifbts@letter
  \RequirePackage[hidelinks]{hyperref}
  % Bake the version stamp into the PDF metadata so any reader can see
  % which class version produced the document.
  \AtBeginDocument{%
    \hypersetup{pdfsubject={\bangorversionstamp},
    pdfkeywords={Bangor University; \bangorversionstamp}}}
  % The letterhead. Put this at the top of a letter environment, before
  % the \opening command. The optional argument sets the crest width.
  \newcommand{\bangorletterhead}[1][1.5cm]{%
    \begin{center}
      \bangorcrest[#1]\par
      \vspace{0.3em}%
      {\large\bangorwordmark\par}
      \ifx\bts@school\@empty\else
        \vspace{0.2em}{\small \bts@school\par}\fi
      \vspace{0.5em}%
      {\color{bangorred}\rule{\linewidth}{0.8pt}}%
    \end{center}
    \vspace{0.5em}}
  \endinput\fi

%%% 5. Regulation layout (thesis modes)
% Selects the font, page geometry, and line spacing permitted by the
% Bangor University thesis regulations (Regulation 03, 2025 Version 01,
% section 6.3) and validates them. Strict mode is on by default: a
% violation fails the build. Setting strict=false downgrades every
% violation to a warning so the document still compiles.
%
% The validator governs settings made through this class. It cannot
% see arbitrary preamble changes made around it.

\RequirePackage{setspace}
\RequirePackage{geometry}

% Regulation floors the layout enforces.
\newcommand{\bts@bindingfloor}{2.5cm}
\newcommand{\bts@otherfloor}{1.5cm}
\newcommand{\bts@serifsizefloor}{12}
\newcommand{\bts@sanssizefloor}{10}

% Report a regulation violation: build-failing error in strict mode,
% warning otherwise. The command is public so a document's own
% regulation checks can route through the same strict/warn switch, and
% one option governs every check in the document.
\newcommand{\bangorregulationviolation}[1]{%
  \ifbts@strict
    \ClassError{bangor}{#1}%
    {Set strict=false on the class line to compile anyway.}%
  \else
    \ClassWarningNoLine{bangor}{#1}%
  \fi}

% Font selection. The string option is matched against the permitted
% choices, which are free TeX Live equivalents of the regulation's named
% example faces: termes (Times-Roman), bonum (Bookman), heros (Arial
% and Helvetica). The first two are serif; heros is sans-serif. An
% unknown choice is a violation with the serif default as the fallback.
\newif\ifbts@serif
\newif\ifbts@heros
% T1 is loaded before any font package so that the fonts are set up in it. The legacy OT1 encoding has no typewriter backslash, so \texttt{\textbackslash} in a document warned about a missing font shape, and T1 also sets accented Welsh letters as single glyphs.
\RequirePackage[T1]{fontenc}
% A word that cannot be broken, such as a typewriter option name, can leave a justified line too wide to fit. Emergency stretch lets TeX loosen the spacing of a paragraph that would otherwise overfill a line, so that only such lines are affected and no text needs rewording.
\setlength{\emergencystretch}{3em}
\bts@seriftrue
\bts@herosfalse
\def\bts@choicetermes{termes}
\def\bts@choicebonum{bonum}
\def\bts@choiceheros{heros}
\ifx\bts@font\bts@choicetermes
  \RequirePackage{tgtermes}%
\else\ifx\bts@font\bts@choicebonum
    \RequirePackage{tgbonum}%
  \else\ifx\bts@font\bts@choiceheros
      \RequirePackage{tgheros}%
      \bts@seriffalse
      \bts@herostrue
    \else
      \bangorregulationviolation{Unknown font choice `\bts@font'. Permitted choices:
        termes, bonum, heros. Using termes.}%
      \RequirePackage{tgtermes}%
    \fi\fi\fi
% A sans-serif body uses the sans family as the document default.
\ifbts@heros
  \renewcommand{\familydefault}{\sfdefault}%
\fi

% Regulation geometry: 2.5cm binding edge, 2cm on the remaining sides
% (above the regulation's 1.5cm floor), header and footer inside the
% text block.
\geometry{a4paper,inner=2.5cm,outer=2cm,top=2cm,bottom=2cm,includeheadfoot}

% Regulation spacing: 1.5 in the main text. The abstract, indented
% quotations, and footnotes may be single spaced; the singlespace
% environment gives them that.
\onehalfspacing

% Validate at the start of the document, when class and package
% settings have settled.
\AtBeginDocument{%
  % Font size floor for the chosen family.
  \edef\bts@bodysize{\f@size}%
  \ifbts@serif
    \ifnum\bts@bodysize<\bts@serifsizefloor\relax
      \bangorregulationviolation{Serif body text must be at least
        \bts@serifsizefloor\space pt.}%
    \fi
  \else
    \ifnum\bts@bodysize<\bts@sanssizefloor\relax
      \bangorregulationviolation{Sans-serif body text must be at least
        \bts@sanssizefloor\space pt.}%
    \fi
  \fi
  % Margin floors, computed from the page geometry so that any margin
  % source is checked, not only this class's own settings. The left
  % margin is the binding edge. The checked extents run to the text
  % body, with header and footer depth included in the vertical
  % margins.
  \ifdim\dimexpr 1in+\hoffset+\oddsidemargin\relax<\bts@bindingfloor\relax
    \bangorregulationviolation{The binding-edge margin must be at least 2.5cm.}%
  \fi
  \ifdim\dimexpr\paperwidth-\textwidth-1in-\hoffset-\oddsidemargin\relax<\bts@otherfloor\relax
    \bangorregulationviolation{The outer margin must be at least 1.5cm.}%
  \fi
  \ifdim\dimexpr 1in+\voffset+\topmargin+\headheight+\headsep\relax<\bts@otherfloor\relax
    \bangorregulationviolation{The top margin must be at least 1.5cm.}%
  \fi
  \ifdim\dimexpr\paperheight-\textheight-1in-\voffset-\topmargin-\headheight-\headsep\relax<\bts@otherfloor\relax
    \bangorregulationviolation{The bottom margin must be at least 1.5cm.}%
  \fi
  % Line spacing: setspace's onehalfspacing sets the stretch to 1.235,
  % which yields the regulation's 1.5 visual spacing.
  \ifdim\baselinestretch pt<1.2pt\relax
    \bangorregulationviolation{The main text must use 1.5 line spacing.}%
  \fi}

%%% 6. Statutory declarations (thesis modes)
% Typesets the declarations prescribed or expected at the front of a
% Bangor University thesis or dissertation. The originality declaration
% reproduces the statutory text from Regulation 03, 2025 Version 01,
% section 6.3, exactly as published, in English and in Welsh; the welsh
% class option selects the Welsh rendering. The availability text and
% the generative AI statement are fill-in templates, not statutory
% wording: students must check both against their school's guidance.

% The statutory originality declaration, English text. The wording
% reproduces the published regulation exactly, including its grammar.
\newcommand{\bts@declarationenglish}{%
  I hereby declare that this thesis is the results of my own
  investigations, except where otherwise stated. All other sources are
  acknowledged by bibliographic references. This work has not
  previously been accepted in substance for any degree and is not being
  concurrently submitted in candidature for any degree unless, as
  agreed by the University, for approved dual awards.}

% The statutory originality declaration, Welsh text, likewise exact.
\newcommand{\bts@declarationwelsh}{%
  Yr wyf drwy hyn yn datgan mai canlyniad fy ymchwil fy hun yw'r
  thesis hwn, ac eithrio lle nodir yn wahanol. Caiff ffynonellau
  eraill eu cydnabod gan droednodiadau yn rhoi cyfeiriadau eglur. Nid
  yw sylwedd y gwaith hwn wedi cael ei dderbyn o'r blaen ar gyfer unrhyw
  radd, ac nid yw'n cael ei gyflwyno ar yr un pryd mewn ymgeisiaeth am
  unrhyw radd oni bai ei fod, fel y cytunwyd gan y Brifysgol, am
  gymwysterau deuol cymeradwy.}

% Generative AI statement. Fill-in template: replace the bracketed
% guidance with your own statement, or state that you used no such
% tools. Check your school's current policy before you submit.
\def\bts@aistatement{%
Generative artificial intelligence tools were used as follows:
[describe how you used the tools, or write that you did not use
them]. All AI-assisted content was reviewed and verified by the
author. No unpublished research data or sensitive material was
entered into any generative AI tool.}
\newcommand{\aistatement}[1]{\gdef\bts@aistatement{#1}}

% Statement of availability. Fill-in template, not statutory wording.
\newcommand{\bts@availability}{%
  I acknowledge that any part of this document may be made available
  for consultation, photocopying, or incorporation into future studies,
  provided that full reference is given to the origins of the
  information contained herein. I permit a copy of this work to be
  deposited in the Bangor University Institutional Digital Repository
  and in any other repository authorised for use by Bangor
  University. I acknowledge that Bangor University may make the title
  and a summary of this document freely available.}

% Rendered statements.
\newcommand{\originalitystatement}{%
  \section*{Statement of Originality}
  \bts@declarationenglish\par
  \ifbts@welsh
    \medskip
    \bts@declarationwelsh\par
  \fi
  \medskip
  \bts@aistatement\par
  \bigskip
  \begin{flushright}
    Student:\par
    \vspace{2.5em}
    \@author
  \end{flushright}}

\newcommand{\availabilitystatement}{%
  \section*{Statement of Availability}
  \bts@availability\par
  \bigskip
  \begin{flushright}
    Student:\par
    \vspace{2.5em}
    \@author
  \end{flushright}}

% Convenience: both statements in regulation order.
\newcommand{\statementspage}{%
  \originalitystatement
  \bigskip
  \availabilitystatement}

%%% 7. Thesis body

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
      for the degree of \bts@degree\par}
    \vfill
    {\large \@author \par}
    \ifx\bts@supervisors\@empty\else
      \vspace{1em}%
      \begin{minipage}{0.8\linewidth}
        \centering Supervisors:\par\bts@supervisors
      \end{minipage}\par
    \fi
    \ifx\bts@wordcount\@empty\else
      \vspace{1em}{Word count: \bts@wordcount\par}%
    \fi
    \vfill
    {\ifx\bts@date\@empty\@date\else\bts@date\fi\par}
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
    \ClassError{bangor}{Unknown #1 value `#2'}{The permitted values are hairline, visible, and none.}}{}}
\bts@checkrule{headrule}{\bts@headrule}
\bts@checkrule{footrule}{\bts@footrule}

\newif\ifbts@chapteronly
\def\bts@hd@chapter{chapter}
\def\bts@hd@chaptersection{chapter-section}
\ifx\bts@headers\bts@hd@chapter
  \bts@chapteronlytrue
\else
  \ifx\bts@headers\bts@hd@chaptersection\else
    \ClassError{bangor}{Unknown headers value `\bts@headers'}{The permitted values are chapter-section and chapter.}%
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
\ifx\bts@shorttitle\@empty
\begingroup
\def\\{\@ifnextchar[{\bts@skipbracket}{\space}}%
\protected@xdef\bts@footertext{\@title}%
\endgroup
\bts@checkfooter{The title is too wide for the footer}{Set \string\shorttitle\string{Short title\string} in the preamble.}%
\else
\let\bts@footertext\bts@shorttitle
\bts@checkfooter{The short title is too wide for the footer}{Use a shorter \string\shorttitle.}%
\fi}

% Float numbering. The switch runs at the very end of the begindocument hook because packages such as listings create their counters lazily and would fail on a counter that already exists. Counters whose package is not loaded are skipped, so the same list serves every document. A shared counter is another name for the figure register, and the number format and the hyperref anchor name of each shared type are defined as calls to \thefigure and \theHfigure, because a copy taken before they are redefined would keep the old format, and an anchor name built from the type's own parent counters would repeat within a chapter as the shared count restarts in each section.
\def\bts@sfv@none{}
\def\bts@sfv@chapter{}
\def\bts@sfv@zero{}
\@ifundefined{bts@sfv@\bts@sectionfloats}{%
  \ClassError{bangor}{Unknown sectionfloats value `\bts@sectionfloats'}{The permitted values are none, chapter, and zero.}}{}
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

%%% 8. Table support (option tables)
% One environment for tables that run past a page, need X columns to fit
% the width, or both: longtabular paginates at row boundaries with the
% header repeating on each continuation page, sizes X columns to the
% text width, and its [wide] form rotates the table onto a landscape
% page first. The [columns=N] form instead wraps a narrow table's rows
% into N side-by-side panes on one page, so a long narrow table uses
% the page's width rather than running onto the next page: each pane
% repeats the head, the caption prints once above them, and the wrapped
% table must fit one page, which is the point of wrapping it. The two
% options combine: [wide,columns=2] wraps on a landscape page. In the
% columns form the head sits between \panehead and \endpanehead in the
% body, because the longtable block markers cannot be re-parsed outside
% a table. The underlying longtable, tabularx and landscape
% environments remain available for special cases.
\ifbts@tables
  \RequirePackage{xltabular}
  \RequirePackage{pdflscape}

  \ExplSyntaxOn
  \bool_new:N \l_bts_wide_bool
  \int_new:N \l_bts_cols_int
  \tl_new:N \l_bts_opt_tl
  \seq_new:N \l__bts_opt_seq

  % Option parsing: a comma list whose only permitted items are the word
  % wide and a columns=N setting. Anything else is a class error naming
  % the offender.
  \cs_new_protected:Npn \__bts_parse_option:n #1
  {
    \tl_set:Nn \l_bts_opt_tl { #1 }
    \tl_trim_spaces:N \l_bts_opt_tl
    \tl_if_empty:NF \l_bts_opt_tl
    {
      \str_if_eq:VnTF \l_bts_opt_tl { wide }
      { \bool_set_true:N \l_bts_wide_bool }
      {
        \regex_extract_once:nnNTF { \A columns=(\d+)\Z } { #1 } \l__bts_opt_seq
        {
          \int_set:Nn \l_bts_cols_int { \seq_item:Nn \l__bts_opt_seq { 2 } }
          \int_compare:nNnT \l_bts_cols_int < 2
            {
              \ClassError { bangor } { columns~must~be~2~or~more }
              { Wrapping~into~one~column~is~the~default,~paginating~form. }
            }
        }
        {
          \ClassError { bangor } { Unknown~longtabular~option~`#1' }
          { The~permitted~items~are~wide~and~columns=N,~comma~separated. }
        }
      }
    }
  }

  % xltabular scans its source for the literal \end{xltabular}, so it
  % cannot simply be wrapped: the body is collected first with environ's
  % \NewEnviron and replayed inside, where the literal end token is
  % present for the scan.
  \NewEnviron { longtabular } [2] [ ]
  {
  \bool_set_false:N \l_bts_wide_bool
  \int_set:Nn \l_bts_cols_int { 1 }
  \clist_map_function:nN { #1 } \__bts_parse_option:n
  \bool_if:NT \l_bts_wide_bool { \begin { landscape } }
  \int_compare:nNnTF \l_bts_cols_int = { 1 }
  {
  \begin { xltabular } { \linewidth } { #2 }
  \BODY
  \end { xltabular }
  }
  { \exp_args:Noo \__bts_columns:nn { #2 } { \BODY } }
  \bool_if:NT \l_bts_wide_bool { \end { landscape } }
  }

  % The columns form. The body is an optional caption line ending in \\,
  % then a head block between \panehead and \endpanehead, then the rows.
  % The parse uses delimited arguments, which match tokens without
  % expanding them; the longtable block markers could not be re-used here
  % because expanding them outside a table fires longtable internals.
  % Caption titles and labels must not contain nested braces, and rows
  % must not contain \\.
  \tl_new:N \l__bts_pre_tl
  \tl_new:N \l__bts_head_tl
  \tl_new:N \l__bts_rows_tl
  \tl_new:N \l__bts_cap_tl
  \tl_new:N \l__bts_capshort_tl
  \tl_new:N \l__bts_captitle_tl
  \tl_new:N \l__bts_caplabel_tl
  \tl_new:N \l__bts_row_tl
  \tl_new:N \l__bts_pane_tl
  \seq_new:N \l__bts_rows_seq
  \int_new:N \l__bts_rows_int
  \int_new:N \l__bts_per_int
  \int_new:N \l__bts_from_int
  \int_new:N \l__bts_to_int
  \quark_new:N \q__bts_stop

  % #1 preamble, #2 body. Everything up to \panehead is the caption
  % chunk; up to \endpanehead the head; the rest the rows. The markers
  % are checked for first: a missing one would otherwise send the
  % delimited scan to the end of the file.
  \cs_new_protected:Npn \__bts_columns:nn #1 #2
  {
    \tl_set:Nn \l__bts_body_tl { #2 }
    \exp_args:NV \__bts_check_markers:n \l__bts_body_tl
    \exp_after:wN \__bts_split:w \l__bts_body_tl \q__bts_stop
    \tl_if_empty:NF \l__bts_pre_tl { \__bts_scan_caption: }
    \__bts_panes:n { #1 }
  }
  \cs_new_protected:Npn \__bts_check_markers:n #1
  {
    \tl_if_in:nnTF { #1 } { \panehead } { }
    {
      \ClassError { bangor } { The~columns~form~needs~a~\string\panehead~marker }
      { Put~the~head~rows~between~\string\panehead~and~\string\endpanehead,~after~the~caption~line. }
    }
    \tl_if_in:nnTF { #1 } { \endpanehead } { }
    {
      \ClassError { bangor } { The~columns~form~needs~an~\string\endpanehead~marker }
      { Close~the~head~rows~with~\string\endpanehead~before~the~table~rows. }
    }
  }
  \tl_new:N \l__bts_body_tl
  \cs_new_protected:Npn \__bts_split:w #1 \panehead #2 \endpanehead #3 \q__bts_stop
  {
    \tl_set:Nn \l__bts_pre_tl { #1 }
    \tl_set:Nn \l__bts_head_tl { #2 }
    \tl_set:Nn \l__bts_rows_tl { #3 }
  }

  % The caption chunk is \caption[short]{title}\label{key}\\ with the
  % short form optional. Braces cannot appear in a definition's parameter
  % text, so the braced groups are taken as undelimited arguments, which
  % grab a whole balanced group each. The dispatcher consumes \caption
  % and peeks at what follows to pick the scan, replaying the line.
  \cs_new_protected:Npn \__bts_scan_caption:
  {
    \tl_trim_spaces:N \l__bts_pre_tl
    \exp_after:wN \__bts_scan_dispatch:w \l__bts_pre_tl \q__bts_stop
  }
  \cs_new_protected:Npn \__bts_scan_dispatch:w \caption #1 \q__bts_stop
  {
  \tl_set:Nn \l__bts_rest_tl { #1 }
  \exp_args:No \tl_if_head_eq_charcode:nNTF { \l__bts_rest_tl } [
  { \__bts_scan_long:w \caption #1 \q__bts_stop }
    { \__bts_scan_short:w \caption #1 \q__bts_stop }
  }
  \tl_new:N \l__bts_rest_tl
  \cs_new_protected:Npn \__bts_scan_long:w \caption [ #1 ] #2 \label #3 \\ \q__bts_stop
  {
    \tl_set:Nn \l__bts_capshort_tl { #1 }
    \tl_set:Nn \l__bts_captitle_tl { #2 }
    \tl_set:Nn \l__bts_caplabel_tl { #3 }
  }
  \cs_new_protected:Npn \__bts_scan_short:w \caption #1 \label #2 \\ \q__bts_stop
  {
    \tl_clear:N \l__bts_capshort_tl
    \tl_set:Nn \l__bts_captitle_tl { #1 }
    \tl_set:Nn \l__bts_caplabel_tl { #2 }
  }

  % The caption is re-emitted once above the panes through \captionof,
  % which the caption package, loaded above, provides.
  \cs_new_protected:Npn \__bts_emit_caption:
  {
    \tl_if_empty:NF \l__bts_captitle_tl
    {
      % An absent short form falls back to the title, the same entry a
      % plain caption without a short form produces.
      \tl_if_empty:NT \l__bts_capshort_tl
      { \tl_set_eq:NN \l__bts_capshort_tl \l__bts_captitle_tl }
      % The call is built as one token list because captionof's
      % optional-argument lookahead expands whatever follows it.
      \tl_set:Ne \l__bts_capcall_tl
      {
        \exp_not:N \noindent
        \exp_not:N \captionof { table } [ \l__bts_capshort_tl ]
        { \l__bts_captitle_tl }
        \exp_not:N \label { \l__bts_caplabel_tl }
        \exp_not:N \par
      }
      \tl_use:N \l__bts_capcall_tl
      \vspace { \abovecaptionskip }
    }
  }
  \tl_new:N \l__bts_capcall_tl

  % Rows into a sequence, splitting on \\ with a delimited loop and
  % dropping whitespace-only items.
  \cs_new_protected:Npn \__bts_split_rows:
  {
    \seq_clear:N \l__bts_rows_seq
    \exp_after:wN \__bts_rows_loop:w \l__bts_rows_tl \q__bts_stop
  }
  \cs_new_protected:Npn \__bts_rows_loop:w #1 \\ #2 \q__bts_stop
  {
    \tl_set:Nn \l__bts_row_tl { #1 }
    \tl_trim_spaces:N \l__bts_row_tl
    \tl_if_empty:NF \l__bts_row_tl
    { \seq_put_right:No \l__bts_rows_seq { \l__bts_row_tl } }
    \tl_if_blank:nTF { #2 } { }
    { \__bts_rows_loop:w #2 \q__bts_stop }
  }

  % Panes: pane p carries rows (p-1)*per+1 .. p*per, per = ceil(rows/N),
  % each pane the available line width divided by the pane count and
  % separated from its neighbour by a 2em gap, matching the width the
  % panes are sized to leave. The head opens every pane.
  % The caption and the panes sit inside one unbreakable minipage: a
  % wrapped table must fit one page by contract, so a page break between
  % the caption and the panes is not a break the form may take.
  \cs_new_protected:Npn \__bts_panes:n #1
  {
    \__bts_split_rows:
    % The minipage fills the line, so the paragraph carrying it must not
    % be indented: \parindent on top of a full-width box overflows by
    % exactly the indent.
    \noindent \begin { minipage } { \linewidth }
    \__bts_emit_caption:
    \int_set:Nn \l__bts_rows_int { \seq_count:N \l__bts_rows_seq }
    \int_set:Nn \l__bts_per_int
    { \int_div_truncate:nn { \l__bts_rows_int + \l_bts_cols_int - 1 } { \l_bts_cols_int } }
    \int_step_inline:nn { \l_bts_cols_int }
    {
      \int_set:Nn \l__bts_from_int { ( ##1 - 1 ) * \l__bts_per_int + 1 }
      \int_set:Nn \l__bts_to_int { \int_min:nn { ##1 * \l__bts_per_int } { \l__bts_rows_int } }
      \int_compare:nNnT \l__bts_from_int > \l__bts_to_int { \int_set:Nn \l__bts_from_int { \l__bts_to_int } }
      \tl_clear:N \l__bts_pane_tl
      \int_step_inline:nnn { \l__bts_from_int } { \l__bts_to_int }
      {
        \tl_put_right:No \l__bts_pane_tl { \seq_item:Nn \l__bts_rows_seq { ####1 } }
        \tl_put_right:Nn \l__bts_pane_tl { \\ }
      }
      \int_compare:nNnT { ##1 } > { 1 } { \hspace { 2em } }
      \begin { minipage } [t] { \dim_eval:n { ( \linewidth - 2em * ( \l_bts_cols_int - 1 ) ) / \l_bts_cols_int } }
      \begin { tabular } { #1 }
      \l__bts_head_tl
      \l__bts_pane_tl
      \end { tabular }
      \end { minipage }
    }
    \end { minipage }
    \par
  }
  \ExplSyntaxOff
\fi

%%% 9. Abbreviations (option glossary)
% A minimal list of abbreviations with first-use expansion, using only
% the LaTeX3 kernel (no external packages). Adds near-zero compile
% time compared to the full glossaries package's dependency chain.
%
% \addabbrev{SHORT}{Full Name} registers an abbreviation.
% \useabbrev{SHORT} prints the full form on first use, the short form after.
% \Useabbrev{SHORT} does the same with a capitalised first word.
% \printabbrevs[Title] prints an unnumbered front matter heading and an alphabetically sorted list. The heading is entered in the contents only when the class option frontmattertoc is set. Each entry ends with the pages on which the abbreviation is used, and runs of three or more consecutive arabic pages are written as a range.
\ifbts@glossary
  % The default heading of \printabbrevs, named like \listfigurename and \listtablename so a document can change it in one place.
  \newcommand{\abbrevname}{List of Abbreviations}

  \ExplSyntaxOn

  % Storage: a property list keyed by the short form, holding the long form.
  % A separate sequence tracks insertion order; sorting is done at print time.
  \prop_new:N \g_bangor_abbrev_prop
  \seq_new:N \g_bangor_abbrev_order_seq

  % \bangor_add_abbrev:nn {short} {long}
  \cs_new_protected:Npn \bangor_add_abbrev:nn #1 #2
  {
    \prop_gput:Nnn \g_bangor_abbrev_prop { #1 } { #2 }
    \seq_gput_right:Nn \g_bangor_abbrev_order_seq { #1 }
    % Define the used-flag for this abbreviation (unset = not yet used)
    \bool_new:c { g_bangor_abbrev_ #1 _used_bool }
    \bool_gset_false:c { g_bangor_abbrev_ #1 _used_bool }
  }

  % Every use writes its page to the .aux file, and the next run reads it back through \bangorabbrevpage, so the list can print the pages an abbreviation appears on. A page that already holds the abbreviation is not recorded again. The expl3 prefix stays bangor because \bangorabbrevpage is written into .aux files.
  \cs_new_protected:Npn \bangor_write_page:n #1
  {
    \protected@write \@auxout { }
    { \string \bangorabbrevpage { #1 } { \thepage } }
  }
  \cs_new_protected:Npn \bangor_record_page:nn #1 #2
  {
    \seq_if_exist:cF { g_bangor_abbrev_ #1 _pages_seq }
    { \seq_new:c { g_bangor_abbrev_ #1 _pages_seq } }
    \seq_if_in:cnF { g_bangor_abbrev_ #1 _pages_seq } { #2 }
    { \seq_gput_right:cn { g_bangor_abbrev_ #1 _pages_seq } { #2 } }
  }

  % \bangor_use_abbrev:n {short} — short form or full form on first use
  \cs_new_protected:Npn \bangor_use_abbrev:n #1
  {
    \prop_if_in:NnTF \g_bangor_abbrev_prop { #1 }
    {
      \bangor_write_page:n { #1 }
      \bool_if:cTF { g_bangor_abbrev_ #1 _used_bool }
      { #1 }
      {
        \prop_item:Nn \g_bangor_abbrev_prop { #1 } ~ ( #1 )
        \bool_gset_true:c { g_bangor_abbrev_ #1 _used_bool }
      }
    }
    {
      \ClassWarning{bangor} { Unknown~abbreviation:~#1 }
      #1
    }
  }

  % \bangor_use_abbrev_cap:n {short} — same but capitalise the first word
  \cs_new_protected:Npn \bangor_use_abbrev_cap:n #1
  {
    \prop_if_in:NnTF \g_bangor_abbrev_prop { #1 }
    {
      \bangor_write_page:n { #1 }
      \bool_if:cTF { g_bangor_abbrev_ #1 _used_bool }
      { #1 }
      {
        % Capitalise: use \MakeUppercase on the first letter of the long form
        \text_titlecase_first:n { \prop_item:Nn \g_bangor_abbrev_prop { #1 } } ~ ( #1 )
        \bool_gset_true:c { g_bangor_abbrev_ #1 _used_bool }
      }
    }
    {
      \ClassWarning{bangor} { Unknown~abbreviation:~#1 }
      #1
    }
  }

  % Page list of one abbreviation. A run of three or more consecutive arabic pages is written as a range, and every other page stands alone. A page is linked when hyperref is loaded.
  \int_new:N \l_bangor_run_start_int
  \int_new:N \l_bangor_run_end_int
  \bool_new:N \l_bangor_run_open_bool
  \bool_new:N \l_bangor_run_first_bool

  \cs_new_protected:Npn \bangor_page_out:n #1
  {
    \bool_if:NTF \l_bangor_run_first_bool
    { \bool_set_false:N \l_bangor_run_first_bool }
    { ,~ }
    \cs_if_exist:NTF \hyperpage { \hyperpage { #1 } } { #1 }
  }

  \cs_new_protected:Npn \bangor_run_flush:
  {
    \bool_if:NT \l_bangor_run_open_bool
    {
      \int_compare:nNnTF { \l_bangor_run_end_int - \l_bangor_run_start_int } > { 1 }
        {
          \bangor_page_out:n { \int_use:N \l_bangor_run_start_int }
          --
          \cs_if_exist:NTF \hyperpage
          { \hyperpage { \int_use:N \l_bangor_run_end_int } }
          { \int_use:N \l_bangor_run_end_int }
        }
        {
          \int_step_inline:nnn { \l_bangor_run_start_int } { \l_bangor_run_end_int }
          { \bangor_page_out:n { ##1 } }
        }
      \bool_set_false:N \l_bangor_run_open_bool
    }
  }

  \cs_new_protected:Npn \bangor_page_step:n #1
  {
    \regex_match:nnTF { \A \d+ \Z } { #1 }
    {
      \bool_if:NT \l_bangor_run_open_bool
      {
        \int_compare:nNnF { #1 } = { \l_bangor_run_end_int + 1 }
          { \bangor_run_flush: }
      }
      \bool_if:NTF \l_bangor_run_open_bool
      { \int_set:Nn \l_bangor_run_end_int { #1 } }
      {
        \int_set:Nn \l_bangor_run_start_int { #1 }
        \int_set:Nn \l_bangor_run_end_int { #1 }
        \bool_set_true:N \l_bangor_run_open_bool
      }
    }
    {
      \bangor_run_flush:
      \bangor_page_out:n { #1 }
    }
  }

  \cs_new_protected:Npn \bangor_print_pages:n #1
  {
    \seq_if_exist:cT { g_bangor_abbrev_ #1 _pages_seq }
    {
      \nobreak \dotfill \nobreak \
      \group_begin:
      \bool_set_true:N \l_bangor_run_first_bool
      \bool_set_false:N \l_bangor_run_open_bool
      \seq_map_function:cN { g_bangor_abbrev_ #1 _pages_seq } \bangor_page_step:n
      \bangor_run_flush:
      \group_end:
    }
  }

  % \bangor_print_abbrevs:n {title} — a front matter heading, which the thesis body above defines and enters in the contents only with frontmattertoc, then the sorted list
  \cs_new_protected:Npn \bangor_print_abbrevs:n #1
  {
    \bangorfrontheading { #1 }
    \begin{description}
      \bangor_print_abbrevs_sorted:
    \end{description}
  }

  % Sort the order sequence alphabetically by short form, then emit items
  \cs_new_protected:Npn \bangor_print_abbrevs_sorted:
  {
    \seq_gsort:Nn \g_bangor_abbrev_order_seq
    {
      \str_compare:nNnTF { ##1 } < { ##2 }
        { \sort_return_same: }
        { \sort_return_swapped: }
    }
    \seq_map_inline:Nn \g_bangor_abbrev_order_seq
    {
      \item[##1] \prop_item:Nn \g_bangor_abbrev_prop { ##1 }
      \bangor_print_pages:n { ##1 }
    }
  }

  % User-level commands
  \NewDocumentCommand { \addabbrev } { m m }
  { \bangor_add_abbrev:nn { #1 } { #2 } }

  \NewDocumentCommand { \useabbrev } { m }
  { \bangor_use_abbrev:n { #1 } }

  \NewDocumentCommand { \Useabbrev } { m }
  { \bangor_use_abbrev_cap:n { #1 } }

  \NewDocumentCommand { \printabbrevs } { O{\abbrevname} }
  { \bangor_print_abbrevs:n { #1 } }

  % Read from the .aux file, so it must exist when the file is read.
  \NewDocumentCommand { \bangorabbrevpage } { m m }
  { \bangor_record_page:nn { #1 } { #2 } }

  \ExplSyntaxOff
\fi

\endinput
