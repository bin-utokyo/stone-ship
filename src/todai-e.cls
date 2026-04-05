%% todai-e.cls v.1b by Taiichi Saito  <SANBI printing Co., Ltd.>
%% All rights reserved copyright(c) Taiichi Saito
%% taisaito@sanbi.co.jp
%%-----------------
\NeedsTeXFormat{pLaTeX2e}
\ProvidesClass{todai-e}
  [2005/05/13  東大Eクラスファイル TODAI-E.CLS v.1.01 to use publishing for (Todai E 34W x 31L) A5 size<< All rights reserved copyright(c) Taiichi Saito>>]



%%%% class options %%%%%%%%
\newif\if@Proof \@Prooffalse
\DeclareOption{Proof}{\@Prooftrue}

\newif\if@Nopsfont \@Nopsfontfalse
\DeclareOption{Nopsfont}{\@Nopsfonttrue}


\newif\if@JISfmt \@JISfmtfalse%★
\DeclareOption{JISfmt}{\@JISfmttrue}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%



\newcounter{@paper}
\newif\if@landscape \@landscapefalse
\newcommand{\@ptsize}{}
\newif\if@restonecol
\newif\if@titlepage
\@titlepagetrue
\newif\if@openright
\newif\if@mainmatter \@mainmattertrue
\hour\time \divide\hour by 60\relax
\@tempcnta\hour \multiply\@tempcnta 60\relax
\minute\time \advance\minute-\@tempcnta
\newif\if@stysize \@stysizefalse
\newif\if@enablejfam \@enablejfamtrue
\DeclareOption{a4paper}{\setcounter{@paper}{1}%
  \setlength\paperheight {297mm}%
  \setlength\paperwidth  {210mm}}
\DeclareOption{a5paper}{\setcounter{@paper}{2}%
  \setlength\paperheight {210mm}
  \setlength\paperwidth  {148mm}}
\DeclareOption{b4paper}{\setcounter{@paper}{3}%
  \setlength\paperheight {364mm}
  \setlength\paperwidth  {257mm}}
\DeclareOption{b5paper}{\setcounter{@paper}{4}%
  \setlength\paperheight {257mm}
  \setlength\paperwidth  {182mm}}
\DeclareOption{a4j}{\setcounter{@paper}{1}\@stysizetrue
  \setlength\paperheight {297mm}%
  \setlength\paperwidth  {210mm}}
\DeclareOption{a5j}{\setcounter{@paper}{2}\@stysizetrue
  \setlength\paperheight {210mm}
  \setlength\paperwidth  {148mm}}
\DeclareOption{b4j}{\setcounter{@paper}{3}\@stysizetrue
  \setlength\paperheight {364mm}
  \setlength\paperwidth  {257mm}}
\DeclareOption{b5j}{\setcounter{@paper}{4}\@stysizetrue
  \setlength\paperheight {257mm}
  \setlength\paperwidth  {182mm}}
\DeclareOption{a4p}{\setcounter{@paper}{1}\@stysizetrue
  \setlength\paperheight {297mm}%
  \setlength\paperwidth  {210mm}}
\DeclareOption{a5p}{\setcounter{@paper}{2}\@stysizetrue
  \setlength\paperheight {210mm}
  \setlength\paperwidth  {148mm}}
\DeclareOption{b4p}{\setcounter{@paper}{3}\@stysizetrue
  \setlength\paperheight {364mm}
  \setlength\paperwidth  {257mm}}
\DeclareOption{b5p}{\setcounter{@paper}{4}\@stysizetrue
  \setlength\paperheight {257mm}
  \setlength\paperwidth  {182mm}}
\if@compatibility
  \renewcommand{\@ptsize}{0}
\else
  \DeclareOption{10pt}{\renewcommand{\@ptsize}{0}}
\fi
\DeclareOption{11pt}{\renewcommand{\@ptsize}{1}}
\DeclareOption{12pt}{\renewcommand{\@ptsize}{2}}
\DeclareOption{landscape}{\@landscapetrue
  \setlength\@tempdima{\paperheight}%
  \setlength\paperheight{\paperwidth}%
  \setlength\paperwidth{\@tempdima}}
\DeclareOption{tombow}{%
  \tombowtrue \tombowdatetrue
%  \setlength{\@tombowwidth}{.1\p@}%
  \setlength{\@tombowwidth}{.12mm}%
  \@bannertoken{%
     \jobname\space:\space\number\year/\number\month/\number\day
      (\number\hour:\number\minute)}
  \maketombowbox}
\DeclareOption{tombo}{%
  \tombowtrue \tombowdatefalse
  \setlength{\@tombowwidth}{.1\p@}%
  \maketombowbox}
\DeclareOption{mentuke}{%
  \tombowtrue
  \setlength{\@tombowwidth}{\z@}%
  \@bannertoken\@empty
  \maketombowbox}
\DeclareOption{tate}{%
  \AtBeginDocument{\tate\message{《縦組モード》}%
                   \adjustbaseline}%
}
\DeclareOption{oneside}{\@twosidefalse}
\DeclareOption{twoside}{\@twosidetrue}
\DeclareOption{onecolumn}{\@twocolumnfalse}
\DeclareOption{twocolumn}{\@twocolumntrue}
\DeclareOption{titlepage}{\@titlepagetrue}
\DeclareOption{notitlepage}{\@titlepagefalse}
\if@compatibility
\@openrighttrue
\else
\DeclareOption{openright}{\@openrighttrue}
\DeclareOption{openany}{\@openrightfalse}
\fi
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{openbib}{%
  \AtEndOfPackage{%
   \renewcommand\@openbib@code{%
      \advance\leftmargin\bibindent
      \itemindent -\bibindent
      \listparindent \itemindent
      \parsep \z@
      }%
   \renewcommand\newblock{\par}}}
\if@compatibility
\else
  \DeclareOption{disablejfam}{\@enablejfamfalse}
\fi
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\ExecuteOptions{a4paper,10pt,twoside,onecolumn,final,openright}
\ProcessOptions\relax
%%%\input{jbk1\@ptsize.clo}
%%%

\newdimen\h
  \h=0.25mm
\newdimen\JQ
  \JQ=0.7392507pt
\newdimen\Q
  \Q=0.71144pt
\newdimen\@bs
\@bs=22\h



\expandafter\let\csname JY1/mc/m/n/10\endcsname\relax
\expandafter\let\csname JY1/gt/m/n/10\endcsname\relax


\if@JISfmt
 \DeclareFontShape{JY1}{mc}{m}{n}{<5> <6> sgen*min
 <7> s * [1.05571] min7
 <8> s * [1.01625] min8
 <9> s * [0.98556] min9
 <10> s * [0.961] min10
 <10.95> s * [0.94516] min10
 <12> s * [0.98567] min10
 <14.4> s * [0.92406] min10
 <17.28> s * [0.85561] min10
 <20.74> s * [0.88545] min10
 <24.88> s * [0.9508] min10 
 <-> min10
 }{}
%
 \DeclareFontShape{JY1}{gt}{m}{n}{<5> <6> sgen*goth
 <7> s * [1.05571] goth7 
 <8> s * [1.01625] goth8 
 <9> s * [0.98556] goth9
 <10> s * [0.961] goth10
 <10.95> s * [0.94516] goth10
 <12> s * [0.98567] goth10
 <14.4> s * [0.92406] goth10
 <17.28> s * [0.85561] goth10
 <20.74> s * [0.88545] goth10
 <24.88> s * [0.9508] goth10  
 <-> goth10
 }{}
%%%
\else
%%%
 \DeclareFontShape{JY1}{mc}{m}{n}{<5>jis <6> jis
 <7> s * [1.05571] jis
 <8> s * [1.01625] jis
 <9> s * [0.98556] jis
 <10> s * [0.961] jis
 <10.95> s * [0.94516] jis
 <12> s * [0.98567] jis
 <14.4> s * [0.92406] jis
 <17.28> s * [0.85561] jis
 <20.74> s * [0.88545] jis
 <24.88> s * [0.9508] jis 
 <-> jis
 }{}
%
 \DeclareFontShape{JY1}{gt}{m}{n}{<5>jisg <6> jisg
 <7> s * [1.05571] jisg 
 <8> s * [1.01625] jisg 
 <9> s * [0.98556] jisg
 <10> s * [0.961] jisg
 <10.95> s * [0.94516] jisg
 <12> s * [0.98567] jisg
 <14.4> s * [0.92406] jisg
 <17.28> s * [0.85561] jisg
 <20.74> s * [0.88545] jisg
 <24.88> s * [0.9508] jisg  
 <-> jisg
 }{}
%
\fi


\renewcommand{\normalsize}{%
    \@setfontsize\normalsize\@xpt{22\h}%
  \abovedisplayskip 10\p@ \@plus2\p@ \@minus5\p@
  \abovedisplayshortskip \z@ \@plus3\p@
  \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
   \belowdisplayskip \abovedisplayskip
   \let\@listi\@listI}
\normalsize
\setbox0\hbox{\char\euc"A1A1}%
\setlength\Cht{\ht0}
\setlength\Cdp{\dp0}
\setlength\Cwd{\wd0}
\setlength\Cvs{\baselineskip}
\setlength\Chs{\wd0}
\newcommand{\small}{%
  \@setfontsize\small\@ixpt{18\h}%
  \abovedisplayskip 8.5\p@ \@plus3\p@ \@minus4\p@
  \abovedisplayshortskip \z@ \@plus2\p@
  \belowdisplayshortskip 4\p@ \@plus2\p@ \@minus2\p@
  \def\@listi{\leftmargin\leftmargini
              \topsep 4\p@ \@plus2\p@ \@minus2\p@
              \parsep 2\p@ \@plus\p@ \@minus\p@
              \itemsep \parsep}%
  \belowdisplayskip \abovedisplayskip}
\newcommand{\footnotesize}{%
  \@setfontsize\footnotesize\@viiipt{15\h}%
  \abovedisplayskip 6\p@ \@plus2\p@ \@minus4\p@
  \abovedisplayshortskip \z@ \@plus\p@
  \belowdisplayshortskip 3\p@ \@plus\p@ \@minus2\p@
  \def\@listi{\leftmargin\leftmargini
              \topsep 3\p@ \@plus\p@ \@minus\p@
              \parsep 2\p@ \@plus\p@ \@minus\p@
              \itemsep \parsep}%
  \belowdisplayskip \abovedisplayskip}

\newcommand{\Footnotesize}{%
  \@setfontsize\Footnotesize\@viiipt{13\h}%
  \abovedisplayskip 6\p@ \@plus2\p@ \@minus4\p@
  \abovedisplayshortskip \z@ \@plus\p@
  \belowdisplayshortskip 3\p@ \@plus\p@ \@minus2\p@
  \def\@listi{\leftmargin\leftmargini
              \topsep 3\p@ \@plus\p@ \@minus\p@
              \parsep 2\p@ \@plus\p@ \@minus\p@
              \itemsep \parsep}%
  \belowdisplayskip \abovedisplayskip}
\newcommand{\scriptsize}{\@setfontsize\scriptsize\@viipt\@viiipt}

\newcommand{\Scriptsize}{\@setfontsize\Scriptsize\@viipt{14\h}}

\newcommand{\tiny}{\@setfontsize\tiny\@vpt\@vipt}
\newcommand{\large}{\@setfontsize\large\@xiipt{17}}
\newcommand{\Large}{\@setfontsize\Large\@xivpt{21}}
\newcommand{\LARGE}{\@setfontsize\LARGE\@xviipt{25}}
\newcommand{\huge}{\@setfontsize\huge\@xxpt{28}}
\newcommand{\Huge}{\@setfontsize\Huge\@xxvpt{33}}





\setlength\headheight{12\p@}
%\setlength\headsep{.25in}
\setlength\headsep{7mm}%%%% 柱と版面のアキ
\setlength\topskip{1\Cht}
\setlength\footskip{.35in}
\if@compatibility
  \setlength\maxdepth{4\p@}
\else
  \setlength\maxdepth{.5\topskip}
\fi
\if@compatibility
  \if@stysize
    \ifnum\c@@paper=2 % A5
      \if@landscape
        \setlength\textwidth{47\Cwd}
      \else
        \setlength\textwidth{28\Cwd}
      \fi
    \else\ifnum\c@@paper=3 % B4
      \if@landscape
        \setlength\textwidth{75\Cwd}
      \else
        \setlength\textwidth{60\Cwd}
      \fi
    \else\ifnum\c@@paper=4 % B5
      \if@landscape
        \setlength\textwidth{60\Cwd}
      \else
        \setlength\textwidth{37\Cwd}
      \fi
    \else % A4 ant other
      \if@landscape
        \setlength\textwidth{73\Cwd}
      \else
        \setlength\textwidth{47\Cwd}
      \fi
    \fi\fi\fi
  \else
    \if@twocolumn
      \setlength\textwidth{52\Cwd}
    \else
      \setlength\textwidth{4.3in}
    \fi
  \fi
\else
  \if@stysize
    \if@twocolumn
      \setlength\textwidth{.8\paperwidth}
    \else
      \setlength\textwidth{.7\paperwidth}
    \fi
  \else
    \setlength\@tempdima{\paperwidth}
    \addtolength\@tempdima{-2in}
    \setlength\@tempdimb{327\p@}
    \if@twocolumn
      \ifdim\@tempdima>2\@tempdimb\relax
        \setlength\textwidth{2\@tempdimb}
      \else
        \setlength\textwidth{\@tempdima}
      \fi
    \else
      \ifdim\@tempdima>\@tempdimb\relax
        \setlength\textwidth{\@tempdimb}
      \else
        \setlength\textwidth{\@tempdima}
      \fi
    \fi
  \fi
\fi
\@settopoint\textwidth
\if@compatibility
  \if@stysize
    \ifnum\c@@paper=2 % A5
      \if@landscape
        \setlength\textheight{17\Cvs}
      \else
        \setlength\textheight{28\Cvs}
      \fi
    \else\ifnum\c@@paper=3 % B4
      \if@landscape
        \setlength\textheight{38\Cvs}
      \else
        \setlength\textheight{57\Cvs}
      \fi
    \else\ifnum\c@@paper=4 % B5
      \if@landscape
        \setlength\textheight{22\Cvs}
      \else
        \setlength\textheight{35\Cvs}
      \fi
    \else % A4 and other
      \if@landscape
        \setlength\textheight{27\Cvs}
      \else
        \setlength\textheight{43\Cvs}
      \fi
    \fi\fi\fi
    \addtolength\textheight{\topskip}
    \addtolength\textheight{\baselineskip}
  \else
  \setlength\textheight{554\p@}
  \fi
\else
  \if@stysize
    \setlength\textheight{.70\paperheight}
  \else
    \setlength\@tempdima{\paperheight}
    \addtolength\@tempdima{-2in}
    \addtolength\@tempdima{-1.5in}
    \divide\@tempdima\baselineskip
    \@tempcnta\@tempdima
    \setlength\textheight{\@tempcnta\baselineskip}
  \fi
\fi
\addtolength\textheight{\topskip}
\@settopoint\textheight
\if@compatibility
  \if@stysize
    \setlength\topmargin{-.3in}
  \else
    \setlength\topmargin{.75in}
  \fi
\else
  \setlength\topmargin{\paperheight}
  \addtolength\topmargin{-\headheight}
  \addtolength\topmargin{-\headsep}
  \addtolength\topmargin{-\textheight}
  \addtolength\topmargin{-\footskip}
  \if@stysize
    \ifnum\c@@paper=2 % A5
      \addtolength\topmargin{-1.3in}
    \else
      \addtolength\topmargin{-2.0in}
    \fi
  \else
    \addtolength\topmargin{-2.0in}
  \addtolength\topmargin{-.5\topmargin}
  \fi
\fi
\@settopoint\topmargin
\if@twocolumn
  \setlength\marginparsep{10\p@}
\else
  \setlength\marginparsep{10\p@}
\fi
\setlength\marginparpush{5\p@}
\if@compatibility
    \setlength\oddsidemargin   {.5in}
    \setlength\evensidemargin  {1.5in}
    \setlength\marginparwidth {.75in}
  \if@twocolumn
     \setlength\oddsidemargin  {30\p@}
     \setlength\evensidemargin {30\p@}
     \setlength\marginparwidth {48\p@}
  \fi
  \if@stysize
    \if@twocolumn\else
      \setlength\oddsidemargin{0\p@}
      \setlength\evensidemargin{0\p@}
    \fi
  \fi
\else
  \setlength\@tempdima{\paperwidth}
  \addtolength\@tempdima{-\textwidth}
  \if@twoside
    \setlength\oddsidemargin{.4\@tempdima}
  \else
    \setlength\oddsidemargin{.5\@tempdima}
  \fi
  \addtolength\oddsidemargin{-1in}
  \@settopoint\oddsidemargin
  \setlength\evensidemargin{\paperwidth}
  \addtolength\evensidemargin{-2in}
  \addtolength\evensidemargin{-\textwidth}
  \addtolength\evensidemargin{-\oddsidemargin}
  \@settopoint\evensidemargin
  \if@twoside
    \setlength\marginparwidth{.6\@tempdima}
    \addtolength\marginparwidth{-.4in}
  \else
    \setlength\marginparwidth{.5\@tempdima}
    \addtolength\marginparwidth{-.4in}
  \fi
  \ifdim \marginparwidth >2in
    \setlength\marginparwidth{2in}
  \fi
  \@settopoint\marginparwidth
\fi
\setlength\footnotesep{6.65\p@}
\setlength{\skip\footins}{9\p@ \@plus 4\p@ \@minus 2\p@}
\setlength\floatsep{.6\@bs plus 2mm minus 1mm}%{12\p@ \@plus 2\p@ \@minus 2\p@}

\setlength\textfloatsep{.6\@bs plus 2mm minus 1mm}%{20\p@ \@plus 2\p@ \@minus 4\p@}
\setlength\intextsep{.6\@bs plus 2mm minus 1mm}%{12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\dblfloatsep{1\@bs plus 2mm minus 1mm}%{12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\dbltextfloatsep{1\@bs plus 2mm minus 1mm}%{20\p@ \@plus 2\p@ \@minus 4\p@}
\setlength\@fptop{0\p@ \@plus 1fil}
\setlength\@fpsep{1\@bs plus 2fil }%{8\p@ \@plus 2fil}
\setlength\@fpbot{0\p@ \@plus 1fil}
\setlength\@dblfptop{0\p@ \@plus 1fil}
\setlength\@dblfpsep{1\@bs plus 2fil}%{8\p@ \@plus 2fil}
\setlength\@dblfpbot{0\p@ \@plus 1fil}


\setlength\partopsep{\z@ plus 0.1\@bs minus 0.1\@bs}%{2\p@ \@plus 1\p@ \@minus 1\p@}


\def\@listi{\leftmargin\leftmargini
  \parsep 4\p@ \@plus2\p@ \@minus\p@
  \topsep 8\p@ \@plus2\p@ \@minus4\p@
  \itemsep4\p@ \@plus2\p@ \@minus\p@}
\let\@listI\@listi
\@listi
\def\@listii{\leftmargin\leftmarginii
   \labelwidth\leftmarginii \advance\labelwidth-\labelsep
   \topsep  4\p@ \@plus2\p@ \@minus\p@
   \parsep  2\p@ \@plus\p@  \@minus\p@
   \itemsep\parsep}
\def\@listiii{\leftmargin\leftmarginiii
   \labelwidth\leftmarginiii \advance\labelwidth-\labelsep
   \topsep 2\p@  \@plus\p@\@minus\p@
   \parsep\z@
   \partopsep \p@ \@plus\z@ \@minus\p@
   \itemsep\topsep}
\def\@listiv {\leftmargin\leftmarginiv
              \labelwidth\leftmarginiv
              \advance\labelwidth-\labelsep}
\def\@listv  {\leftmargin\leftmarginv
              \labelwidth\leftmarginv
              \advance\labelwidth-\labelsep}
\def\@listvi {\leftmargin\leftmarginvi
              \labelwidth\leftmarginvi
              \advance\labelwidth-\labelsep}
%%%\endinput
%%
%% End of file `jbk10.clo'.


\if@stysize
  \setlength\columnsep{2\Cwd}
\else
  \setlength\columnsep{10\p@}
\fi
\setlength\columnseprule{0\p@}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand{\baselinestretch}{}
\setlength\parskip{0\p@ \@plus \p@}
\setlength\parindent{1\Cwd}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301

\setcounter{topnumber}{3}
\setcounter{bottomnumber}{2}
\setcounter{totalnumber}{5}
\setcounter{dbltopnumber}{2}

\renewcommand{\topfraction}{1}
\renewcommand{\bottomfraction}{1}
\renewcommand{\textfraction}{0}
\renewcommand{\floatpagefraction}{.5}
\renewcommand{\dbltopfraction}{1}
\renewcommand{\dblfloatpagefraction}{.5}



\def\ps@plain{\let\@mkboth\@gobbletwo
   \let\ps@jpl@in\ps@plain
   \let\@oddhead\@empty
   \def\@oddfoot{\reset@font\hfil\thepage\hfil}%
   \let\@evenhead\@empty
   \let\@evenfoot\@oddfoot}
\let\ps@jpl@in\ps@plain
\def\ps@headnombre{\let\@mkboth\@gobbletwo
    \let\ps@jpl@in\ps@headnombre
  \def\@evenhead{\thepage\hfil}%
  \def\@oddhead{\hfil\thepage}%
  \let\@oddfoot\@empty\let\@evenfoot\@empty}
\def\ps@footnombre{\let\@mkboth\@gobbletwo
    \let\ps@jpl@in\ps@footnombre
  \def\@evenfoot{\thepage\hfil}%
  \def\@oddfoot{\hfil\thepage}%
  \let\@oddhead\@empty\let\@evenhead\@empty}


\if@Proof
 \def\@Rtop{\rlap{\smash{\rule[-\headsep]{0.05mm}{10mm}%
  \rule[-\headsep]{10mm}{0.05mm}}}}
 \def\@Ltop{\llap{\smash{\rule[-\headsep]{10mm}{0.05mm}%
  \rule[-\headsep]{0.05mm}{10mm}}}}
 \def\@Rbot{\rlap{\smash{\raisebox{1\footskip}
  {\rule[-10mm]{0.05mm}{10mm}\rule{10mm}{0.05mm}}}}}
%  {\rule[-15.73mm]{0.05mm}{15.73mm}\rule{23.73mm}{0.05mm}\rule[-15.73mm]{0.05mm}{15.73mm}}}}}
 \def\@Lbot{\llap{\smash{\raisebox{1\footskip}
  {\rule{10mm}{0.05mm}\rule[-10mm]{0.05mm}{10mm}}}}}
 \def\pot@jobname{\smash{\raise7mm\rlap{\LARGE\texttt{\jobname}}}}
\else
 \let\@Rtop\relax\let\@Ltop\relax\let\@Rbot\relax\let\@Lbot\relax
 \let\pot@jobname\relax
\fi


\if@twoside
\def\ps@headings{\let\@mkboth\markboth
\def\@evenfoot{\@Lbot\hfill\@Rbot}
\def\@oddfoot{\@Lbot\hfill\@Rbot}
\def\@evenhead{\@Ltop\hspace*{1zw}{\Footnotesize{\Garaxiii{\thepage}}}%
\hskip2zw{\scriptsize\leftmark}\hfil\@Rtop}
\def\@oddhead{\@Ltop\hfil{\scriptsize\rightmark}\hskip2zw%
{\Footnotesize{\Garaxiii{\thepage}}}\hspace*{1zw}\@Rtop}
%\def\@oddhead{\@Ltop\hfill\@Rtop}
%\def\@evenhead{\@Ltop\hfill\@Rtop}
\def\chaptermark##1{\markboth {\ifnum \c@secnumdepth>\m@ne
\@chapapp{\thechapter}\@chappos\hskip1zw \fi ##1}{}}
\def\sectionmark##1{\markright{\ifnum \c@secnumdepth >\z@
 \thesection\hskip1zw \fi ##1}}}



\def\ps@PARTheadings{\let\@mkboth\markboth
\def\@evenfoot{\@Lbot\hfill\@Rbot}
\def\@oddfoot{\@Lbot\hfill\@Rbot}
%\def\@oddhead{\@Ltop\hfil{\scriptsize\rightmark}\hskip2zw%
%\hskip1mm\protect\raisebox{.5mm}{\protect\rule{5mm}{.1mm}}\hskip1mm%
%{\scriptsize\it\thepage}\hspace*{1zw}\@Rtop}
%\def\@evenhead{\@Ltop\hspace*{1zw}{\scriptsize\it\thepage}%
%\hskip2zw%
%\hskip1mm\protect\raisebox{.5mm}{\protect\rule{5mm}{.1mm}}\hskip1mm%
%{\scriptsize\leftmark}\hfil\@Rtop}
\def\@oddhead{\@Ltop\hfill\@Rtop}
\def\@evenhead{\@Ltop\hfill\@Rtop}
\def\chaptermark##1{\markboth {\ifnum \c@secnumdepth>\m@ne
 \@chapapp{\thechapter}\@chappos\hskip1zw \fi ##1}{}}
\def\sectionmark##1{\markright{\ifnum \c@secnumdepth >\z@
 \thesection\hskip1zw \fi ##1}}}



\def\ps@CCheadings{\let\@mkboth\markboth
\def\@evenfoot{\@Lbot\hfill\@Rbot}
\def\@oddfoot{\@Lbot\hfill\@Rbot}
\def\@evenhead{\@Ltop\hspace*{1zw}{\Footnotesize{\Garaxiii{\thepage}}}%
\hskip2zw{\scriptsize\leftmark}\hfil\@Rtop}
\def\@oddhead{\@Ltop\hfil{\scriptsize\rightmark}\hskip2zw%
{\Footnotesize{\Garaxiii{\thepage}}}\hspace*{1zw}\@Rtop}
\def\chaptermark##1{\markboth {\ifnum \c@secnumdepth>\m@ne
 %\@chapapp
{\thechapter}%
%\@chappos
\hskip1zw \fi ##1}{}}
\def\sectionmark##1{\markright{\ifnum \c@secnumdepth >\z@
 \thesection\hskip1zw \fi ##1}}}



\else % if not twoside
  \def\ps@headings{\let\ps@jpl@in\ps@headnombre
    \let\@oddfoot\@empty
    \def\@oddhead{{\rightmark}\hfil\thepage}%
    \let\@mkboth\markboth
\def\chaptermark##1{\markright{%
   \ifnum \c@secnumdepth >\m@ne
         \if@mainmatter
       \@chapapp\thechapter\@chappos\hskip1zw
         \fi
   \fi
   ##1}}%
  }
\fi
\if@twoside
  \def\ps@bothstyle{\let\ps@jpl@in\ps@footnombre
    \def\@evenhead{\leftmark\hfil}% right page
    \def\@evenfoot{\thepage\hfil}% right page
    \def\@oddhead{\hfil\rightmark}% left page
    \def\@oddfoot{\hfil\thepage}% left page
  \let\@mkboth\markboth
\def\chaptermark##1{\markboth{%
     \ifnum \c@secnumdepth >\m@ne
         \if@mainmatter
         \@chapapp\thechapter\@chappos\hskip1zw
         \fi
     \fi
     ##1}{}}%
  \def\sectionmark##1{\markright{%
     \ifnum \c@secnumdepth >\z@ \thesection.\hskip1zw\fi
     ##1}}%
  }
\else % if one column
  \def\ps@bothstyle{\let\ps@jpl@in\ps@footnombre
    \def\@oddhead{\hfil\rightmark}%
    \def\@oddfoot{\hfil\thepage}%
    \let\@mkboth\markboth
  \def\chaptermark##1{\markright{%
     \ifnum \c@secnumdepth >\m@ne
         \if@mainmatter
         \@chapapp\thechapter\@chappos\hskip1zw
         \fi
     \fi
     ##1}}%
  }
\fi
\def\ps@myheadings{\let\ps@jpl@in\ps@plain%
  \let\@oddfoot\@empty\let\@evenfoot\@empty
  \def\@evenhead{\thepage\hfil\leftmark}%
  \def\@oddhead{{\rightmark}\hfil\thepage}%
  \let\@mkboth\@gobbletwo
  \let\chaptermark\@gobble
  \let\sectionmark\@gobble
}
\if@compatibility
\newenvironment{titlepage}
    {%
      \cleardoublepage
     \if@twocolumn\@restonecoltrue\onecolumn
     \else\@restonecolfalse\newpage\fi
     \thispagestyle{empty}%
     \setcounter{page}\z@
    }%
    {\if@restonecol\twocolumn\else\newpage\fi
    }
\else
\newenvironment{titlepage}
    {%
      \cleardoublepage
      \if@twocolumn
        \@restonecoltrue\onecolumn
      \else
        \@restonecolfalse\newpage
      \fi
      \thispagestyle{empty}%
      \setcounter{page}\@ne
    }%
    {\if@restonecol\twocolumn \else \newpage \fi
     \if@twoside\else
        \setcounter{page}\@ne
     \fi
    }
\fi
\def\p@thanks#1{\footnotemark
  \protected@xdef\@thanks{\@thanks
    \protect{\noindent$\m@th^\thefootnote$~#1\protect\par}}}
\if@titlepage
  \newcommand{\maketitle}{\begin{titlepage}%
  \let\footnotesize\small
  \let\footnoterule\relax
  \let\footnote\thanks
  \null\vfil
  \vskip 60\p@
  \begin{center}%
    {\LARGE \@title \par}%
    \vskip 3em%
    {\Large
     \lineskip .75em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
      \vskip 1.5em%
    {\large \@date \par}%       % Set date in \large size.
  \end{center}\par
  \@thanks\vfil\null
  \end{titlepage}%
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\p@thanks\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
  }%
\else
  \newcommand{\maketitle}{\par
  \begingroup
    \renewcommand{\thefootnote}{\fnsymbol{footnote}}%
    \def\@makefnmark{\hbox{\ifydir $\m@th^{\@thefnmark}$
      \else\hbox{\yoko$\m@th^{\@thefnmark}$}\fi}}%
     \long\def\@makefntext##1{\parindent 1em\noindent
       \hbox to1.8em{\hss$\m@th^{\@thefnmark}$}##1}%
    \if@twocolumn
      \ifnum \col@number=\@ne \@maketitle
      \else \twocolumn[\@maketitle]%
      \fi
    \else
      \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@maketitle
    \fi
     \thispagestyle{jpl@in}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\p@thanks\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
  }
  \def\@maketitle{%
  \newpage\null
  \vskip 2em%
  \begin{center}%
  \let\footnote\thanks
    {\LARGE \@title \par}%
    \vskip 1.5em%
    {\large
      \lineskip .5em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
    \vskip 1em%
    {\large \@date}%
  \end{center}%
  \par\vskip 1.5em}
\fi
\newcommand*{\chaptermark}[1]{}
\setcounter{secnumdepth}{3}


\newcounter{part}
\newcounter{chapter}
\newcounter{section}[chapter]
\newcounter{subsection}[section]
\newcounter{subsubsection}[subsection]
\newcounter{paragraph}[subsubsection]
\newcounter{subparagraph}[paragraph]
\renewcommand{\thepart}{\@Roman\c@part}
\renewcommand{\thechapter}{\@arabic\c@chapter}
\renewcommand{\thesection}{\thechapter.\@arabic\c@section}
\renewcommand{\thesubsection}{\thesection.\@arabic\c@subsection}
\renewcommand{\thesubsubsection}{%
   (\@alph\c@subsubsection)}
\renewcommand{\theparagraph}{%
   \thesubsubsection.\@arabic\c@paragraph}
\renewcommand{\thesubparagraph}{%
   \theparagraph.\@arabic\c@subparagraph}
\newcommand{\@chapapp}{\prechaptername}
\newcommand{\@chappos}{\postchaptername}
\newcommand\frontmatter{%
  \if@openright \cleardoublepage \else \clearpage \fi
  \@mainmatterfalse\pagenumbering{roman}}
\newcommand{\mainmatter}{%
  \if@openright \cleardoublepage \else \clearpage \fi
  \@mainmattertrue\pagenumbering{arabic}}
\newcommand{\backmatter}{%
  \if@openright \cleardoublepage \else \clearpage \fi
  \@mainmatterfalse}

\newcommand{\part}{%
  \if@openright \cleardoublepage \else \clearpage \fi
  \thispagestyle{PARTheadings}%
  \if@twocolumn\onecolumn\@tempswatrue\else\@tempswafalse\fi
  \null\vfil
  \secdef\@part\@spart}
\def\@part[#1]#2{%
  \ifnum \c@secnumdepth >-2\relax
    \refstepcounter{part}%
    \addcontentsline{toc}{part}{%
       \prepartname\thepart\postpartname%\hspace{1em}
#1}%
  \else
    \addcontentsline{toc}{part}{#1}%
  \fi
  \markboth{}{}%
  {\centering
   \interlinepenalty\@M\reset@font
   \ifnum \c@secnumdepth >-2\relax
     \huge\bfseries\prepartname\thepart\postpartname
     \par\vskip20\p@
   \fi
   \Huge\bfseries#2\par}%
   \@endpart}
\def\@spart#1{{%
  \centering
  \interlinepenalty\@M\reset@font
  \Huge\bfseries#1\par}%
  \@endpart}
\def\@endpart{\vfil\newpage
   \if@twoside\null\thispagestyle{PARTheadings}\newpage\fi
   \if@tempswa\twocolumn\fi}

\def\Center{\itemsep\z@\topsep\z@\parsep\z@\trivlist\Centering\item[]}%
\def\Centering{\let\\=\@centercr\rightskip\@flushglue\leftskip\@flushglue%
\parindent\z@\parfillskip\z@}%
\let\endCenter=\endtrivlist

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\part}{%
  \if@openright \cleardoublepage \else \clearpage \fi
  \thispagestyle{PARTheadings}%
  \if@twocolumn\onecolumn\@tempswatrue\else\@tempswafalse\fi
  \null%\vfil
  \secdef\@part\@spart}
\def\@part[#1]#2{%
  \ifnum \c@secnumdepth >-2\relax
    \refstepcounter{part}%
    \addcontentsline{toc}{part}{%
       \prepartname\thepart\postpartname\hspace{1em}#1}%
  \else
    \addcontentsline{toc}{part}{#1}%
  \fi
  \markboth{}{}%
  {\vspace*{-2.5mm}\vspace*{29.5mm}\Centering
   \interlinepenalty\@M\reset@font
   \ifnum \c@secnumdepth >-2\relax
     \huge\bfseries\baselineskip0mm\Shingoxvi\prepartname{\ShingoExxxii\thepart}\postpartname
     \\[2.5mm]%\par%\vskip16\JQ
   \fi
   \Huge\bfseries\baselineskip0mm\Shingoxxxii#2\par}%
   \@endpart}
\def\@spart#1{{%
  \Centering
  \interlinepenalty\@M\reset@font
  \Huge\bfseries#1\par}%
  \@endpart}
\def\@endpart{\vfil\newpage
   \if@twoside\null\thispagestyle{PARTheadings}\newpage\fi
   \if@tempswa\twocolumn\fi}




\newcommand{\chapter}{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \thispagestyle{PARTheadings}%
  \global\@topnum\z@
  \@afterindentfalse
  \secdef\@chapter\@schapter}
\def\@chapter[#1]#2{%
  \ifnum \c@secnumdepth >\m@ne
    \if@mainmatter
    \refstepcounter{chapter}%
    \typeout{\@chapapp\space\thechapter\space\@chappos}%
    \addcontentsline{toc}{chapter}%
      {\protect\numberline{\@chapapp\thechapter\@chappos}#1}%
    \else\addcontentsline{toc}{chapter}{#1}\fi
  \else
    \addcontentsline{toc}{chapter}{#1}%
  \fi
  \chaptermark{#1}%
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
  \@makechapterhead{#2}%\@afterheading
}





\def\@makechapterhead#1{%\pagenumbering{arabic}%\hbox{}%
\vbox to 7.45\Cvs{\parindent\z@
%%%%%%%%%%
   \thispagestyle{CCheadings}%
   \reset@font\huge\bfseries
   \ifnum \c@secnumdepth >\m@ne
     \setlength\@tempdima{\linewidth}%
    \if@mainmatter
%%%%%%%%%%%%%%% アミ罫線！
\noindent
\protect{\textcolor{90}{\rule{\textwidth}{1mm}}}\par
%%%%%%%%%%%%%%
\vskip3mm
%%%%%%%%%%%%%%%
\setbox\z@\hbox{\huge{\Shingoxvi{\protect\scalebox{.8}[1]{\prechaptername}}%
\hspace{\xkanjiskip}%
{\raisebox{-.25mm}{{\ShingoExxxii{\thechapter}}}}%
\hspace{\xkanjiskip}%
{\Shingoxvi{\protect\scalebox{.8}[1]{\postchaptername}}}}}%
%%%%%%%%
\centering
\unhbox\z@\par
    \fi%\vskip3.5mm
     \centering
{%\hsize\@tempdima%
{\Shingoxxiv\ShingoExxxii\mathversion{bold}{%\baselineskip=40\Q%%%
\protect\scalebox{.8}[1]{#1}}}}%
   \fi%
\vfill%
%%%%%%%%%%%%%%% アミ罫線！
\noindent
\protect{\textcolor{90}{\rule{\textwidth}{1mm}}}\par
%%%%%%%%%%%%%%%
}}



\def\@schapter#1{%
  \@makeschapterhead{#1}%\@afterheading
}
\def\@makeschapterhead#1{\hbox{}%
  \vskip2\Cvs
  {\parindent\z@
   \raggedright
   \reset@font\huge\bfseries
   \setlength\@tempdima{\linewidth}%
   \vtop{\hsize\@tempdima#1}}\vskip3\Cvs}



%%%%%%%%%%%%%%%%
%%% はじめに のスタイル
\def\@makeprefaceschapterhead#1{%
\vbox to 41mm{\parindent\z@
{\centering{%\hsize\@tempdima
\Large\bfseries\mathversion{bold}\protect\Shingoxviii
#1}\vfill}%
}
}



\newcommand{\prefacename}{\protect{はじめに}}

\newenvironment{preface}{\@openrightfalse%
\def\@schapter##1{%\if@openright\clearpage\else\clearpage\fi%
  \@makeprefaceschapterhead{##1}%\@afterheading
}
\chapter*{\prefacename}%
%\@makeprefaceschapterhead{\prefacename}
   \@mkboth{\prefacename}{\prefacename}%
%   \thispagestyle{PARTheadings}%
   \thispagestyle{CCheadings}%
\addcontentsline{toc}{chapter}{はじめに}
   \parskip\z@ \@minus .3\p@%\@plus .3\p@\relax
}{}


\newcommand{\CHOSHA}[2]{\onelineskip
\rightline{\small{#1}　#2}}

%%%%%%%%%%%%%%%%%%%%%%%%%



\def\@makesJORONchapterhead#1{%\hbox{}%
\vbox to 51.75mm{\parindent\z@
   %\raggedright
   \reset@font\huge\bfseries
   \ifnum \c@secnumdepth >\m@ne
     \setlength\@tempdima{\linewidth}%
    \if@mainmatter
     \setbox\z@\hbox{\Shingoxiv
序論}%
     \addtolength\@tempdima{-\wd\z@}%
     \centerline{\unhbox\z@}\vspace*{-4.25mm}\par
    \fi\vskip3.5mm
     \centering{\hsize\@tempdima\Shingoxxxii\ShingoExxxii#1}%
   \fi\vfill}}

\newcommand{\joronname}{\protect{序論}}

\newenvironment{joron}{%
\def\@schapter##1{%\if@openright\clearpage\else\clearpage\fi%
  \@makesJORONchapterhead{##1}%\@afterheading
}
%\chapter*{\joronname}%
%\@makeprefaceschapterhead{\prefacename}
   \@mkboth{\joronname}{\joronname}%
   \thispagestyle{PARTheadings}%
\addcontentsline{toc}{chapter}{序論}
   \parskip\z@ \@plus .3\p@\relax
}{}



\def\pushtowall{\relax\leavevmode
\ifmmode\def\next{\mathpalette\mathpushw@ll}
\else\let\next\makepushw@ll \fi \next}
\def\finpushw@ll{\wd0=0pt \box0}
\def\makepushw@ll#1{\setbox0=\hbox{#1}\finpushw@ll}
\def\mathpushw@ll#1#2{\setbox0=\hbox{$\m@th#1{#2}$}\finpushw@ll}


\def\SECTUP#1{\smash{\raisebox{0mm}{#1}}}
\def\Snumberline#1{{\gosicexiiimoku #1}\hskip1zw}
\newskip\Sectskip
\Sectskip=22.5\h plus 1.75mm minus .75mm


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\@startsectionA#1#2#3#4#5#6{%
  \if@noskipsec \leavevmode \fi
  \par
  \@tempskipa #4\relax
  \@afterindenttrue
  \ifdim \@tempskipa <\z@
    \@tempskipa -\@tempskipa \@afterindentfalse
  \fi
  \if@nobreak
    \everypar{}%
  \else
    \addpenalty\@secpenalty\addvspace\@tempskipa
  \fi
  \@ifstar
    {\@ssectA{#3}{#4}{#5}{#6}}%
    {\@dblarg{\@sectA{#1}{#2}{#3}{#4}{#5}{#6}}}}
\def\@sectA#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{%\protect\rule{0mm}{21.75mm}
\@seccntformatA{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
\hbox{\mbox{}}\vspace{-\baselineskip}%
    \noindent%\fboxsep=0mm\colorbox{red}
{\begingroup
%\vskip\Sectskip
%\vbox to14.25mm{\vfill
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%\noindent\vbox to38.76996pt%51\h
%{\vfill
%      #6{%
%        \@hangfrom{\hskip #3\relax\@svsec}%
%          \interlinepenalty \@M {#8}\@@par}\vfill}%
\noindent
{\vbox to 19mm%51\h
{\vfill%
%\centering%
      #6{%
        \@hangfrom{\hskip #3\relax\@svsec}%
          \interlinepenalty \@M {#8}\@@par}%
%\vspace*{10\h}%%%
\vfill}}\par\prevdepth=-1000pt%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else%
        \protect\numberline{\csname the#1\endcsname}\hskip1zw%
%        \protect\Snumberline{\csname the#1\endcsname}%
      \fi%
%      \protect\jidoukintou{#7}}%
      {#7}%\vfill
}}%
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else%
%          \protect\Snumberline{\csname the#1\endcsname}%
         \protect\numberline{\csname the#1\endcsname}%
        \fi%
        #7}}%
  \fi%
  \@xsect{#5}}
\def\@xsect#1{%
  \@tempskipa #1\relax
  \ifdim \@tempskipa>\z@
    \par \nobreak
    \vskip \@tempskipa
    \@afterheading
  \else
    \@nobreakfalse
    \global\@noskipsectrue
    \everypar{%
      \if@noskipsec
        \global\@noskipsecfalse
       {\setbox\z@\lastbox}%
        \clubpenalty\@M
        \begingroup \@svsechd \endgroup
        \unskip
        \@tempskipa #1\relax
        \hskip -\@tempskipa
      \else
        \clubpenalty \@clubpenalty
        \everypar{}%
      \fi}%
  \fi
  \ignorespaces}
%\def\@seccntformatA#1{\protect\SECTUP{\csname the#1\endcsname\quad}}
\def\@seccntformatA#1{\csname the#1\endcsname\hskip1zw}
\def\@ssectA#1#2#3#4#5{%
  \@tempskipa #3\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #4{%
        \@hangfrom{\hskip #1}%
          \interlinepenalty \@M #5\@@par}%
    \endgroup
  \else
    \def\@svsechd{#4{\hskip #1\relax #5}}%
  \fi
  \@xsect{#3}}
\newif\if@afterindent \@afterindenttrue
\def\@afterheading{%
  \@nobreaktrue
  \everypar{%
    \if@nobreak
      \@nobreakfalse
      \clubpenalty \@M
      \if@afterindent \else
        {\setbox\z@\lastbox}%
      \fi
    \else
      \clubpenalty \@clubpenalty
      \everypar{}%
    \fi}}
\def\@hangfrom#1{\setbox\@tempboxa\hbox{#1}%
      \hangindent \wd\@tempboxa\noindent\box\@tempboxa}





\newcommand{\section}{\@startsectionA{section}{1}{\z@}%
   {1.75\Cvs \@plus.5\Cdp \@minus.2\Cdp}%
   {.5\Cvs \@plus.3\Cdp}%
   {\reset@font\Large\bfseries}}


\renewcommand{\section}{\@startsectionA{section}{1}{13\h}%
%{1.3125\Cvs}%{1.1875 \@plus1.3\Cdp\@minus10.5\Cdp}%
%{.00001\Cvs \@minus.5\Cdp}%
%{.875\Cvs}
%{.415\Cvs}
{.00001\Cvs}% \@plus1.3\Cdp\@minus10.5\Cdp}%
{.00001\Cvs}% \@plus1.3\Cdp\@minus10.5\Cdp}%
{\reset@font\large%\bfseries%
\protect\mathversion{bold}\Shingoxiv\GothExiv%
}}


%%% subsection 
\def\@startsectionB#1#2#3#4#5#6{%
  \if@noskipsec \leavevmode \fi
  \par
  \@tempskipa #4\relax
  \@afterindenttrue
  \ifdim \@tempskipa <\z@
    \@tempskipa -\@tempskipa \@afterindentfalse
  \fi
  \if@nobreak
    \everypar{}%
  \else
    \addpenalty\@secpenalty\addvspace\@tempskipa
  \fi
  \@ifstar
    {\@ssectB{#3}{#4}{#5}{#6}}%
    {\@dblarg{\@sectB{#1}{#2}{#3}{#4}{#5}{#6}}}}
\def\@sectB#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{%\protect\rule{0mm}{21.75mm}
\@seccntformatB{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \noindent\protect\rule{0mm}{42\h}%\fboxsep=0mm\colorbox{red}
{\begingroup
%\vskip\Sectskip
%\vbox to14.25mm{\vfill
\noindent\vbox to 19mm%23.12128pt%7mm
{\vfill
      #6{%
        \@hangfrom{\hskip #3\relax\@svsec}%
%          \interlinepenalty \@M \protect\SECTUP{\jidoukintou{#8}}\@@par}%
%          \interlinepenalty \@M \jidoukintou{#8}\@@par}\vfill}%
          \interlinepenalty \@M {#8}\@@par}\vfill}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
%        \protect\Snumberline{\csname the#1\endcsname}%
      \fi
%      \protect\jidoukintou{#7}}%
      {#7}%\vfill
}}%
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
%          \protect\Snumberline{\csname the#1\endcsname}%
         \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}}%
  \fi
  \@xsect{#5}}
\def\@xsect#1{%
  \@tempskipa #1\relax
  \ifdim \@tempskipa>\z@
    \par \nobreak
    \vskip \@tempskipa
    \@afterheading
  \else
    \@nobreakfalse
    \global\@noskipsectrue
    \everypar{%
      \if@noskipsec
        \global\@noskipsecfalse
       {\setbox\z@\lastbox}%
        \clubpenalty\@M
        \begingroup \@svsechd \endgroup
        \unskip
        \@tempskipa #1\relax
        \hskip -\@tempskipa
      \else
        \clubpenalty \@clubpenalty
        \everypar{}%
      \fi}%
  \fi
  \ignorespaces}
%\def\@seccntformatA#1{\protect\SECTUP{\csname the#1\endcsname\quad}}
\def\@seccntformatB#1{\csname the#1\endcsname\hskip1zw}
\def\@ssectB#1#2#3#4#5{%
  \@tempskipa #3\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #4{%
        \@hangfrom{\hskip #1}%
          \interlinepenalty \@M #5\@@par}%
    \endgroup
  \else
    \def\@svsechd{#4{\hskip #1\relax #5}}%
  \fi
  \@xsect{#3}}
\newif\if@afterindent \@afterindenttrue
\def\@afterheading{%
  \@nobreaktrue
  \everypar{%
    \if@nobreak
      \@nobreakfalse
      \clubpenalty \@M
      \if@afterindent \else
        {\setbox\z@\lastbox}%
      \fi
    \else
      \clubpenalty \@clubpenalty
      \everypar{}%
    \fi}}
\def\@hangfrom#1{\setbox\@tempboxa\hbox{#1}%
      \hangindent \wd\@tempboxa\noindent\box\@tempboxa}

%%%%%%%%%%%%%%% C
\def\@startsectionC#1#2#3#4#5#6{\if@noskipsec \leavevmode \fi
  \par  \@tempskipa #4\relax
  \@afterindenttrue
  \ifdim \@tempskipa <\z@    \@tempskipa -\@tempskipa \@afterindentfalse  \fi
  \if@nobreak
    \everypar{}%
  \else
    \addpenalty\@secpenalty
\ifnum #2=\@ne
       \vskip-\prevdepth \prevdepth\z@ \vskip\Cvs
       \advance\@tempskipa-\Cvs \vspace*{\@tempskipa}%
     \else
\addvspace\@tempskipa
\fi
  \fi
  \@ifstar
    {\@ssectC{#3}{#4}{#5}{#6}}%
    {\@dblarg{\@sectC{#1}{#2}{#3}{#4}{#5}{#6}}}}

\def\@sectC#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{%\protect\rule{0mm}{21.75mm}
\@seccntformatC{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #6{%
%        \centering
\@hangfrom{\hskip #3\relax\@svsec}%
%          \interlinepenalty \@M \protect\SECTUP{\jidoukintou{#8}}\@@par}%
          \interlinepenalty \@M {#8}\@@par}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
      \fi
      {#7}}%
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}}%
  \fi
  \@xsect{#5}}
\def\@xsect#1{%
  \@tempskipa #1\relax
  \ifdim \@tempskipa>\z@
    \par \nobreak
    \vskip \@tempskipa
    \@afterheading
  \else
    \@nobreakfalse
    \global\@noskipsectrue
    \everypar{%
      \if@noskipsec
        \global\@noskipsecfalse
       {\setbox\z@\lastbox}%
        \clubpenalty\@M
        \begingroup \@svsechd \endgroup
        \unskip
        \@tempskipa #1\relax
        \hskip -\@tempskipa
      \else
        \clubpenalty \@clubpenalty
        \everypar{}%
      \fi}%
  \fi
  \ignorespaces}
%\def\@seccntformatC#1{\protect\SECTUP{\csname the#1\endcsname\quad}}
\def\@seccntformatC#1{\csname the#1\endcsname\hskip1zw}
\def\@ssectC#1#2#3#4#5{%
  \@tempskipa #3\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #4{%
%        \centering
\@hangfrom{\hskip #1}%
          \interlinepenalty \@M {#5}\@@par}%
    \endgroup
  \else
    \def\@svsechd{#4{\hskip #1\relax #5}}%
  \fi
  \@xsect{#3}}
\newif\if@afterindent \@afterindenttrue
\def\@afterheading{%
  \@nobreaktrue
  \everypar{%
    \if@nobreak
      \@nobreakfalse
      \clubpenalty \@M
      \if@afterindent \else
        {\setbox\z@\lastbox}%
      \fi
    \else
      \clubpenalty \@clubpenalty
      \everypar{}%
    \fi}}
\def\@hangfrom#1{\setbox\@tempboxa\hbox{#1}%
      \hangindent \wd\@tempboxa\noindent\box\@tempboxa}




 \newcommand{\subsection}{\@startsectionC{subsection}{1}{13\h}%
{.99\Cvs}%{.3125\Cvs}%{.3125\Cvs \@plus.2\Cdp \@minus.5\Cdp}% 
{0.00001\Cvs} %   {.5\Cvs \@plus.3\Cdp}%
   {\reset@font\normalsize\bfseries\Shingoxiii\GothExiii\protect\mathversion{bold}}}



\newcommand{\subsectionII}{\@startsectionB{subsection}{1}{13\h}%
{0.00001\Cvs}
{0.00001\Cvs}
   {\reset@font\normalsize\bfseries\Shingoxiii\GothExiii\protect\mathversion{bold}}}



\newcommand{\subsubsection}{\@startsection{subsubsection}{3}{13\h}%
   {0.00001\Cvs}%{.5\Cvs \@plus.5\Cdp \@minus.2\Cdp}%
   {0.00001\Cvs}%{.5\Cvs \@plus.3\Cdp}%
   {\reset@font\normalsize\bfseries}}
\newcommand{\paragraph}{\@startsection{paragraph}{4}{\z@}%
   {3.25ex \@plus 1ex \@minus .2ex}%
   {-1em}%
   {\reset@font\normalsize\bfseries}}
\newcommand{\subparagraph}{\@startsection{subparagraph}{5}{\z@}%
   {3.25ex \@plus 1ex \@minus .2ex}%
   {-1em}%
   {\reset@font\normalsize\bfseries}}
\newcommand{\appendix}{\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \renewcommand{\@chapapp}{\appendixname}%
  \renewcommand{\@chappos}\space%
  \renewcommand{\thechapter}{\@Alph\c@chapter}}
\if@twocolumn
  \setlength\leftmargini {2em}
\else
  \setlength\leftmargini {2.5em}
\fi
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\if@twocolumn
  \setlength\leftmarginv {.5em}
  \setlength\leftmarginvi{.5em}
\else
  \setlength\leftmarginv {1em}
  \setlength\leftmarginvi{1em}
\fi
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand{\theenumi}{\@arabic\c@enumi}
\renewcommand{\theenumii}{\@alph\c@enumii}
\renewcommand{\theenumiii}{\@roman\c@enumiii}
\renewcommand{\theenumiv}{\@Alph\c@enumiv}
\newcommand{\labelenumi}{\theenumi.}
\newcommand{\labelenumii}{(\theenumii)}
\newcommand{\labelenumiii}{\theenumiii.}
\newcommand{\labelenumiv}{\theenumiv.}
\renewcommand{\p@enumii}{\theenumi}
\renewcommand{\p@enumiii}{\theenumi(\theenumii)}
\renewcommand{\p@enumiv}{\p@enumiii\theenumiii}
\renewenvironment{enumerate}
  {\ifnum \@enumdepth >3\relax\@toodeep\else
   \advance\@enumdepth\@ne
   \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
   \list{\csname label\@enumctr\endcsname}{%
         \ifnum \@listdepth=\@ne \topsep.5\normalbaselineskip
           \else\topsep\z@\fi
         \parskip\z@ \itemsep\z@ \parsep\z@
         \labelwidth1zw \labelsep.3zw
         \ifnum \@enumdepth=\@ne \leftmargin1.5zw\relax
           \else\leftmargin\leftskip\fi
         \advance\leftmargin 1zw
         \usecounter{\@enumctr}%
         \def\makelabel##1{\hss\llap{##1}}}%
   \fi}{\endlist}
\newcommand{\labelitemi}{\textbullet}
\newcommand{\labelitemii}{%
  \iftdir
     {\textcircled{~}}
  \else
     {\normalfont\bfseries\textendash}
  \fi
}
\newcommand{\labelitemiii}{\textasteriskcentered}
\newcommand{\labelitemiv}{\textperiodcentered}
\renewenvironment{itemize}
  {\ifnum \@itemdepth >3\relax\@toodeep\else
   \advance\@itemdepth\@ne
   \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
   \expandafter
   \list{\csname \@itemitem\endcsname}{%
      \iftdir
         \ifnum \@listdepth=\@ne \topsep.5\normalbaselineskip
           \else\topsep\z@\fi
         \parskip\z@ \itemsep\z@ \parsep\z@
         \labelwidth1zw \labelsep.3zw
         \ifnum \@itemdepth =\@ne \leftmargin1zw\relax
           \else\leftmargin\leftskip\fi
         \advance\leftmargin 1zw
      \fi
         \def\makelabel##1{\hss\llap{##1}}}%
   \fi}{\endlist}
\newenvironment{description}
  {\list{}{\labelwidth\z@ \itemindent-\leftmargin
   \iftdir
     \leftmargin\leftskip \advance\leftmargin3\Cwd
     \rightmargin\rightskip
     \labelsep=1zw \itemsep\z@
     \listparindent\z@ \topskip\z@ \parskip\z@ \partopsep\z@
   \fi
           \let\makelabel\descriptionlabel}}{\endlist}
\newcommand{\descriptionlabel}[1]{%
   \hspace\labelsep\normalfont\bfseries #1}
\newenvironment{verse}
  {\let\\\@centercr
   \list{}{\itemsep\z@ \itemindent -1.5em%
           \listparindent\itemindent
           \rightmargin\leftmargin \advance\leftmargin 1.5em}%
           \item\relax}{\endlist}
\newenvironment{quotation}
  {\list{}{\listparindent 1.5em%
           \itemindent\listparindent
           \rightmargin\leftmargin
           \parsep\z@ \@plus\p@}%
           \item\relax}{\endlist}
\newenvironment{quote}
  {\list{}{\rightmargin\leftmargin}%
           \item\relax}{\endlist}

\def \@floatboxreset {%
        \reset@font
        \footnotesize
        \@setminipage
}


\newdimen\@abovecapskip
\newdimen\@belowcapskip


\newcounter{figure}[chapter]
\renewcommand{\thefigure}{%
  \ifnum\c@chapter>\z@\@arabic\c@chapter.\fi\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename~\thefigure}
\newenvironment{figure}
               {\@abovecapskip=1.5mm\@belowcapskip\z@\let\center=\Center\@float{figure}}
               {\end@float}
\newenvironment{figure*}
               {\@dblfloat{figure}}
               {\end@dblfloat}
\newcounter{table}[chapter]
\renewcommand{\thetable}{%
\@arabic\c@chapter.\@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename~\thetable}
\newenvironment{table}
               {\@abovecapskip\z@\@belowcapskip=1.5mm\let\center=\Center\@float{table}}
               {\end@float}
\newenvironment{table*}
               {\@dblfloat{table}}
               {\end@dblfloat}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{0\p@}


\long\def\@makecaption#1#2{\footnotesize
\vskip\@abovecapskip
 \setbox\@tempboxa\hbox{\footnotesize{\footnotesize\bf #1}\hskip1zw #2}
 \ifdim 
  \wd\@tempboxa >\hsize \hangafter=1\hangindent=1zw\unhbox\@tempboxa\par  
  \vspace{\@belowcapskip}
 \else 
  \hbox to\hsize{\hfil\box\@tempboxa\hfil} 
  \vspace{\@belowcapskip}
 \fi}


%%%%%%%%%%%%% 図2個左右 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%how to use
%\begin{figure}[t]%図1.2, 1.3
%\vspace{44mm}%1.2 どちらか大きい方
%\vspace{47mm}%1.3
%\Lcapwidth=18zw\Rcapwidth=18zw
%\Lcaption{xxxx}%
%\Rcaption{xxxx}%
%\MKcaption%
%\end{figure}

\newdimen\Vh
\newdimen\Vw
\def\VSPACE#1#2{%
\Vh=#1\advance\Vh by -0.2mm
\Vw=#2\advance\Vw by -0.2mm
\fboxsep=0mm\ifProof\fboxrule=.1mm\else\fboxrule=0mm\fi%
\vspace{-2mm}\par
\centering
\fbox{\rule{0mm}{\Vh}\rule{\Vw}{0mm}}\vspace{1mm}\par}

\makeatletter
\def\Lcaption#1{\gdef\@Lcaption{#1}}
\def\Rcaption#1{\gdef\@Rcaption{#1}}

\newbox\Lcap
\newbox\Rcap
\newdimen\Lcapwidth
\newdimen\Rcapwidth
\Lcapwidth=49.5mm%18zw(11Q)
\Rcapwidth=\Lcapwidth

\def\MKcaption{%
\vspace{\@abovecapskip}\par
\footnotesize%
%\KFcap\EFcap%
%%
\hfil
\begin{minipage}[t]{\Lcapwidth}
\footnotesize%
%\KFcap\EFcap%
\addtocounter{figure}{1}%
\setbox\Lcap\hbox{{\footnotesize\bf 図\thefigure}\hskip1zw\@Lcaption}
\ifdim \wd\Lcap > \Lcapwidth
\hangafter=1\hangindent=1zw
{\footnotesize\bf 図\thefigure}\hskip1zw\@Lcaption\par
\else
\hfil{\footnotesize\bf 図\thefigure}\hskip1zw\@Lcaption\par
\fi
\end{minipage}
\hfil
\hfil
\begin{minipage}[t]{\Rcapwidth}
\footnotesize%
%\KFcap\EFcap%
\addtocounter{figure}{1}%
\setbox\Rcap\hbox{{\footnotesize\bf 図\thefigure}\hskip1zw\@Rcaption}
\ifdim \wd\Rcap > \Rcapwidth
\hangafter=1\hangindent=1zw
{\footnotesize\bf 図\thefigure}\hskip1zw\@Rcaption\par
\else
\hfil{\footnotesize\bf 図\thefigure}\hskip1zw\@Rcaption\par
\fi
\end{minipage}
\hfil\par
\vspace{\@belowcapskip}\par
}

\def\@Lcaption{}
\def\@Rcaption{}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\@addtoreset{equation}{chapter}
\renewcommand{\theequation}{%
%  \ifnum\c@chapter>\z@\thechapter.\fi \@arabic\c@equation}
  \ifnum\c@chapter>\z@\@arabic\c@chapter.\fi \@arabic\c@equation}
\if@enablejfam
  \DeclareSymbolFont{mincho}{JY1}{mc}{m}{n}
  \DeclareSymbolFontAlphabet{\mathmc}{mincho}
  \SetSymbolFont{mincho}{bold}{JY1}{gt}{m}{n}
  \DeclareMathAlphabet{\mathgt}{JY1}{gt}{m}{n}
  \reDeclareMathAlphabet{\mathrm}{\@mathrm}{\@mathmc}
  \reDeclareMathAlphabet{\mathbf}{\@mathbf}{\@mathgt}
  \jfam\symmincho
\else
  \DeclareRobustCommand{\mathmc}{%
    \@latex@error{Command \noexpand\mathmc invalid with\space
       `disablejfam' class option.}\@eha
  }
  \DeclareRobustCommand{\mathgt}{%
    \@latex@error{Command \noexpand\mathgt invalid with\space
       `disablejfam' class option.}\@eha
  }
\fi
\DeclareOldFontCommand{\mc}{\normalfont\mcfamily}{\mathmc}
\DeclareOldFontCommand{\gt}{\normalfont\gtfamily}{\mathgt}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*{\cal}{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*{\mit}{\@fontswitch\relax\mathnormal}



\setcounter{tocdepth}{2}
\newcommand{\@pnumwidth}{1.55em}
\newcommand{\@tocrmarg}{2.55em}
\newcommand{\@dotsep}{1}
\newdimen\toclineskip
\setlength\toclineskip{\z@}
\newdimen\@lnumwidth
\def\numberline#1{\hbox to\@lnumwidth{#1\hfil}}





\def\@dottedtocline#1#2#3#4#5{\ifnum #1>\c@tocdepth \else
  \vskip\toclineskip \@plus.2\p@
  {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
    \parindent #2\relax\@afterindenttrue
   \interlinepenalty\@M
   \leavevmode
   \@lnumwidth #3\relax
   \advance\leftskip \@lnumwidth \hbox{}\hskip -\leftskip
    {#4}\bfseries\nobreak\leaders\hbox{$\m@th \mkern \@dotsep mu.\mkern \@dotsep
       mu$}\hfill\nobreak\hbox to\@pnumwidth{%
         \hss\reset@font\rmfamily\normalcolor\scriptsize\it #5}\par}\fi}


\def\@dottedtocline#1#2#3#4#5{\ifnum #1>\c@tocdepth \else
  \vskip\toclineskip \@plus.2\p@
  {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
    \parindent #2\relax\@afterindenttrue
   \interlinepenalty\@M
   \leavevmode\mcfamily
%   \@lnumwidth #3\relax
    \@lnumwidth #3\relax
   \advance\leftskip \@lnumwidth \hbox{}\hskip -\leftskip
    {#4}\bfseries\nobreak\leaders\hbox{$\m@th \mkern \@dotsep mu.\mkern \@dotsep
       mu$}\hfill\nobreak\hbox to\@pnumwidth{%
         \hss\reset@font\rmfamily\normalcolor\scriptsize\it #5}\par}\fi}


\def\addcontentsline#1#2#3{%
  \protected@write\@auxout
    {\let\label\@gobble \let\index\@gobble \let\glossary\@gobble
\@temptokena{\thepage}}%
    {\string\@writefile{#1}%
       {\protect\contentsline{#2}{#3}{\the\@temptokena}{}}}%
}


\def\@makemokujischapterhead#1{%
\vbox to 37.5mm{\parindent\z@
{\centering{%\hsize\@tempdima
\Large\bfseries\mathversion{bold}\protect\Shingoxviii
#1}\vfill}%
}
}

\newcommand{\tableofcontents}{\cleardoublepage\thispagestyle{PARTheadings}%
  \if@twocolumn\@restonecoltrue\onecolumn
  \else\@restonecolfalse\fi
\def\@schapter##1{%\if@openright\clearpage\else\clearpage\fi%
  \@makemokujischapterhead{##1}\@afterheading
}
  \chapter*{\contentsname}
\@mkboth{\contentsname}{\contentsname}\@starttoc{toc}%
  \if@restonecol\twocolumn\fi
}


\newcommand*{\l@part}[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \begingroup
    \parindent\z@\rightskip\@pnumwidth
    \parfillskip-\@pnumwidth
    {\leavevmode\large\bfseries
     \setlength\@lnumwidth{4zw}%
%     #1\hfil\nobreak
%     \hbox to\@pnumwidth{\hss\scriptsize\it#2}}\par
#1}\bfseries\nobreak\leaders\hbox{$\m@th \mkern \@dotsep mu.\mkern \@dotsep mu$}\hfill\nobreak\hbox to\@pnumwidth{\hss\scriptsize\it #2}\par 
    \nobreak
    \global\@nobreaktrue
    \everypar{\global\@nobreakfalse\everypar{}}%
     \endgroup
  \fi}



\newcommand*{\l@chapter}[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \addvspace{1.0em \@plus\p@}%
    \begingroup
      \parindent\z@ \rightskip\@pnumwidth \parfillskip-\rightskip
      \leavevmode\gtfamily\bfseries
      \setlength\@lnumwidth{4.5zw}%{2zw}%
      \advance\leftskip\@lnumwidth \hskip-\leftskip
%      #1\nobreak\hfil\nobreak\hbox to\@pnumwidth{\hss#2}\par
#1\nobreak\leaders\hbox{$\m@th \mkern \@dotsep mu.\mkern \@dotsep mu$}\hfill\nobreak\hbox to\@pnumwidth{\hss\scriptsize\it #2}\par 
      \penalty\@highpenalty
    \endgroup
  \fi}



\newcommand*{\l@section}{\@dottedtocline{1}{1.5em}{1.5em}}
\newcommand*{\l@subsection}   {\@dottedtocline{2}{3.8em}{3.5em}}
\newcommand*{\l@subsubsection}{\@dottedtocline{3}{7.0em}{4.1em}}
\newcommand*{\l@paragraph}    {\@dottedtocline{4}{10em}{5em}}
\newcommand*{\l@subparagraph} {\@dottedtocline{5}{12em}{6em}}

%% 参考文献専用TOCエントリ（章番号ボックスなし・章レベル）
\newcommand*{\l@bibliography}[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \addvspace{1.0em \@plus\p@}%
    \begingroup
      \parindent\z@ \rightskip\@pnumwidth \parfillskip-\rightskip
      \leavevmode\gtfamily\bfseries
      #1\nobreak\leaders\hbox{$\m@th \mkern \@dotsep mu.\mkern \@dotsep mu$}\hfill\nobreak\hbox to\@pnumwidth{\hss\scriptsize\it #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}

%% 章内参考文献専用TOCエントリ（セクションレベル・インデントあり）
\newcommand*{\l@chapterbibliography}{\@dottedtocline{1}{1.5em}{0em}}

%% 章ごとの参考文献環境
%% 使い方: \begin{chapterbibliography}{99}...\end{chapterbibliography}
%% 各章の本文ファイル末尾に置く。カウンタは章ごとにリセット。
\newenvironment{chapterbibliography}[1]{%
  \clearpage
  \setcounter{enumiv}{0}%
  \normalsize
  \noindent{\gtfamily\bfseries\large\bibname}\par
  \vskip.5\Cvs
  \addcontentsline{toc}{chapterbibliography}{\bibname}%
  \list{\@biblabel{\@arabic\c@enumiv}}%
       {\settowidth\labelwidth{\@biblabel{#1}}%
        \leftmargin\labelwidth
        \advance\leftmargin\labelsep
        \@openbib@code
        \usecounter{enumiv}%
        \let\p@enumiv\@empty
        \renewcommand\theenumiv{\@arabic\c@enumiv}}%
  \small
  \sloppy
  \clubpenalty4000
  \@clubpenalty\clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m
}{%
  \def\@noitemerr{\@latex@warning{Empty `chapterbibliography' environment}}%
  \endlist
}


\newcommand{\listoffigures}{%
  \if@twocolumn\@restonecoltrue\onecolumn
  \else\@restonecolfalse\fi
  \chapter*{\listfigurename
  \@mkboth{\listfigurename}{\listfigurename}}%
  \@starttoc{lof}%
  \if@restonecol\twocolumn\fi
}
\newcommand*{\l@figure}{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand{\listoftables}{%
  \if@twocolumn\@restonecoltrue\onecolumn
  \else\@restonecolfalse\fi
  \chapter*{\listtablename
  \@mkboth{\listtablename}{\listtablename}}%
  \@starttoc{lot}%
  \if@restonecol\twocolumn\fi
}
\let\l@table\l@figure
\newdimen\bibindent
\setlength\bibindent{1.5em}
\newcommand{\newblock}{\hskip .11em\@plus.33em\@minus.07em}
\newenvironment{thebibliography}[1]
{\chapter*{\bibname\@mkboth{\bibname}{\bibname}}%
   \list{\@biblabel{\@arabic\c@enumiv}}%
        {\settowidth\labelwidth{\@biblabel{#1}}%
         \leftmargin\labelwidth
         \advance\leftmargin\labelsep
         \@openbib@code
         \usecounter{enumiv}%
         \let\p@enumiv\@empty
         \renewcommand\theenumiv{\@arabic\c@enumiv}}%
   \sloppy
   \clubpenalty4000
   \@clubpenalty\clubpenalty
   \widowpenalty4000%
   \sfcode`\.\@m}
  {\def\@noitemerr
    {\@latex@warning{Empty `thebibliography' environment}}%
   \endlist}
\let\@openbib@code\@empty


\def\@makebiblioschapterhead#1{%
\vbox to 43mm{\parindent\z@
{\centering{%\hsize\@tempdima
\Large\bfseries\mathversion{bold}\protect\Shingoxviii
#1}\vfill}%
}
}



\renewenvironment{thebibliography}[1]
{%\cleardoublepage%\chapter*{\bibname\@mkboth{\bibname}{\bibname}}%
%-----
\def\@schapter##1{%\if@openright\clearpage\else\clearpage\fi%
  \@makebiblioschapterhead{##1}\@afterheading}
%\chapter*{\bibname}
\@mkboth{\bibname}{\bibname}%
%\thispagestyle{PARTheadings}%
%---------------
\vbox to 5\Cvs{\parindent\z@\vfill%
{\centering{%\hsize\@tempdima
\Large\bfseries\mathversion{bold}\protect\Shingoxiii
\bibname}\vfill}%
}
%----------------
\Footnotesize\addcontentsline{toc}{bibliography}{参考文献}
   \list{\@biblabel{\@arabic\c@enumiv}}%
        {\settowidth\labelwidth{\@biblabel{#1}}%
         \leftmargin\labelwidth
         \advance\leftmargin\labelsep
         \@openbib@code
         \usecounter{enumiv}%
         \let\p@enumiv\@empty
         \renewcommand\theenumiv{\@arabic\c@enumiv}}%
   \sloppy
   \clubpenalty4000
   \@clubpenalty\clubpenalty
   \widowpenalty4000%
   \sfcode`\.\@m}
  {\def\@noitemerr
    {\@latex@warning{Empty `thebibliography' environment}}%
   \endlist}




%---------------------------------------------------------------------------

\def\@makeindexschapterhead#1{\clearpage\parindent\z@%
\vbox to 4.15\@bs{%
\leavevmode\hbox to 27mm{}%
{\Shingoxxiv\protect\scalebox{.95}[1]{#1}}%
\typeout{〓〓〓〓〓〓 用語索引 〓〓〓〓〓〓}
\vss}}%


\def\@makejinmeichapterhead#1{\clearpage\parindent\z@%
\vbox to 4.45\@bs{%
\leavevmode\hbox to 27mm{}%
{\Shingoxxiv\protect\scalebox{.95}[1]{#1}\hfil}%
\typeout{〓〓〓〓〓〓 人名表 〓〓〓〓〓〓}
\vss}}%



\def\@makekigouchapterhead#1{\clearpage\parindent\z@%
\vbox to 4.15\@bs{%
\leavevmode\hbox to 27mm{}%
{\Shingoxxiv\protect\scalebox{.95}[1]{#1}}%
\typeout{〓〓〓〓〓〓 記号索引 〓〓〓〓〓〓}
\vss}}%



%%%索引
\newenvironment{theindex}
  {\if@twocolumn\@restonecolfalse\else\@restonecoltrue\fi
\footnotesize%%%!!!\egtmin\egtrm
\columnsep 8mm
\@makeindexschapterhead{\indexname}%
\begin{multicols}{2}   
   \@mkboth{\indexname}{\indexname}%
\addcontentsline{toc}{chapter}{用語索引}
\thispagestyle{myheadings}%
\parindent\z@
   \parskip\z@ \@plus .3\p@\relax
   \let\item\@idxitem}
  {\end{multicols}\if@restonecol\onecolumn\else\clearpage\fi}




%%%記号一覧
%-----------
\newenvironment{thekigou}
  {\if@twocolumn\@restonecolfalse\else\@restonecoltrue\fi
\footnotesize%%%!!!\egtmin\egtrm
\columnsep 8mm
\@makekigouchapterhead{\kigounameA}%
\begin{multicols}{2}   
   \@mkboth{\kigounameA}{\kigounameA}%
\addcontentsline{toc}{chapter}{記号索引}
\thispagestyle{myheadings}%
\parindent\z@
   \parskip\z@% \@plus .3\p@\relax
   \let\item\@idxitem}
  {\end{multicols}\if@restonecol\onecolumn\else\clearpage\fi}



%%%人名表
%-----------
\newenvironment{thejinmei}
  {\@makejinmeichapterhead{\jinmeiname}%
   \@mkboth{\jinmeiname}{\jinmeiname}%
\addcontentsline{toc}{chapter}{人名表}
\thispagestyle{myheadings}%
\parindent\z@%
   \parskip\z@% \@plus .3\p@\relax%
   \let\item\@idxitem%
\small\baselineskip=12pt%
}%
  {\clearpage}

%%%%%-----------------------------------




%---！！！定義！！！-------------------
\def\makeindex{%
  \newwrite\@indexfile%-事項
  \newwrite\@jinmeifile%-人名
  \newwrite\@kigoufile%-記号
  \immediate\openout\@indexfile=\jobname.idx%-事項
  \immediate\openout\@jinmeifile=jinmei\jobname.idx%-人名
  \immediate\openout\@kigoufile=kigou\jobname.idx%-記号
%----事項
  \def\index{\@bsphack\begingroup%
             \@sanitize%
             \@wrindex}\typeout%
    {Writing index file \jobname.idx}%
%----人名
  \def\jinmei{\@bsphack\begingroup%
             \@sanitize%
             \@wrjinmei}\typeout%
    {Writing index file jinmei\jobname.idx}%
%----記号
  \def\kigou{\@bsphack\begingroup%
             \@sanitize%
             \@wrkigou}\typeout%
    {Writing index file kigou\jobname.idx}%
%----
  \let\makeindex\@empty%
}%
\@onlypreamble\makeindex
%----事項
\def\@wrindex#1{%
   \protected@write\@indexfile{}%
      {\string\indexentry{#1}{\thepage}}%
 \endgroup%
 \@esphack}
%%----人名
\def\@wrjinmei#1{%
   \protected@write\@jinmeifile{}%
      {\string\indexentry{#1}{\thepage}}%
 \endgroup%
 \@esphack}
%%----記号
\def\@wrkigou#1{%
   \protected@write\@kigoufile{}%
      {\string\indexentry{#1}{\thepage}}%
 \endgroup%
 \@esphack}
%%%--事項
\def\index{\@bsphack\begingroup \@sanitize\@index}%
\def\@index#1{\endgroup\@esphack}%
%%--人名
\def\jinmei{\@bsphack\begingroup \@sanitize\@jinmei}%
\def\@jinmei#1{\endgroup\@esphack}%
%%--記号
\def\kigou{\@bsphack\begingroup \@sanitize\@kigou}%
\def\@kigou#1{\endgroup\@esphack}%

\newcommand\printjinmeiindex{\@input@{jinmei\jobname.ind}}%
\newcommand\printkigouindex{\@input@{kigou\jobname.ind}}%


\newcommand{\jinmeiname}{人名表}%
\newcommand{\kigounameA}{記号索引}%
%------------------------------------------------------------------



\newcommand{\@idxitem}{\par\hspace*{1zw}\hangindent=2zw}
\newcommand{\subitem}{\par\hspace*{3zw}\hangindent 4zw}
\newcommand{\subsubitem}{\par\hangindent 4zw \hspace*{3zw}}
%\newcommand{\indexspace}{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}

\def\indexspace{\@ifstar{\@Mindexspace}{\@MMindexspace}}



\def\@Mindexspace#1{%
\pagebreak[2]
\@tempskipa=1\baselineskip%
\vskip-\prevdepth \prevdepth\z@ \vskip1\baselineskip%
\advance\@tempskipa-1\baselineskip 
\vskip\@tempskipa
\smash{\footnotesize 【#1】}\par
　\par\nopagebreak}

\def\@MMindexspace{\vskip1\baselineskip}





%%%%%%%%%%%%%%%%%%%%%%省略記号一覧%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{kigoulist}{\begin{list}{}{%
\setlength{\itemsep}{1\Cvs}%
\setlength{\partopsep}{1\Cvs}
\setlength{\leftmargin}{0pt}
}%
}{\end{list}}



\def\@makekigouschapterhead#1{%
\vbox to 42mm{\parindent\z@
{\centering{%\hsize\@tempdima
\Large\bfseries\mathversion{bold}\protect\Shingoxviii
#1}\vfill}%
}
}


%%%%%%%%%%%%%%%%%%%%<省略記号一覧 END>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\footnoterule}{%
  \kern-3\p@
  \hrule width 50mm
  \kern 2.6\p@}
\@addtoreset{footnote}{chapter}
\newcommand\@makefntext[1]{\Scriptsize%%%!!
\parindent 1em\noindent \hangafter=1\hangindent=1zw%
\hbox to 1.8em{\hss\@thefnmark)}\hskip1zw#1}%
\def\@makefnmark{\hbox{$^{\@thefnmark)}$}}



\newif\if西暦 \西暦false
\def\西暦{\西暦true}
\def\和暦{\西暦false}
\newcount\heisei \heisei\year \advance\heisei-1988\relax
\def\today{{%
  \iftdir
    \if西暦
      \kansuji\number\year 年
      \kansuji\number\month 月
      \kansuji\number\day 日
    \else
      平成\ifnum\heisei=1 元年\else\kansuji\number\heisei 年\fi
      \kansuji\number\month 月
      \kansuji\number\day 日
    \fi
  \else
    \if西暦
      \number\year~年
      \number\month~月
      \number\day~日
    \else
      平成\ifnum\heisei=1 元年\else\number\heisei~年\fi
      \number\month~月
      \number\day~日
    \fi
  \fi}}
\newcommand{\prepartname}{第}
\newcommand{\postpartname}{部}
\newcommand{\prechaptername}{第}
\newcommand{\postchaptername}{章}
\newcommand{\contentsname}{目 次}
\newcommand{\listfigurename}{図 目 次}
\newcommand{\listtablename}{表 目 次}
\newcommand{\bibname}{参考文献}
\newcommand{\indexname}{索 引}
\newcommand{\figurename}{図}
\newcommand{\tablename}{表}
\newcommand{\appendixname}{付録}
\pagestyle{headings}
\pagenumbering{arabic}
\raggedbottom
%%%  \flushbottom

\if@twocolumn
  \twocolumn
  \sloppy
  \flushbottom
\else
  \onecolumn
\fi
\if@twoside
  \@mparswitchtrue
\else
  \@mparswitchfalse
\fi




\def\@startsectionAPP#1#2#3#4#5#6{%
  \if@noskipsec \leavevmode \fi
  \par
  \@tempskipa #4\relax
  \@afterindenttrue
  \ifdim \@tempskipa <\z@
    \@tempskipa -\@tempskipa \@afterindentfalse
  \fi
  \if@nobreak
    \everypar{}%
  \else
    \addpenalty\@secpenalty\addvspace\@tempskipa
  \fi
  \@ifstar
    {\@ssectAPP{#3}{#4}{#5}{#6}}%
    {\@dblarg{\@sectAPP{#1}{#2}{#3}{#4}{#5}{#6}}}}
\def\@sectAPP#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{%\protect\rule{0mm}{21.75mm}
\@seccntformatAPP{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
%%%%%%%%%%%%
\hbox{\mbox{}}\vspace{-\baselineskip}%
    \noindent%\fboxsep=0mm\colorbox{red}
{\begingroup
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\noindent
{\vbox to 19mm%51\h
{\vfill%
%\centering%
      #6{%
        \@hangfrom{\hskip #3\relax\@svsec}%
          \interlinepenalty \@M {#8}\@@par}%
%\vspace*{10\h}%%%
\vfill}}\par\prevdepth=-1000pt%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
%        \protect\numberline{\csname the#1\endcsname}\hskip1zw%
        \protect\hbox to.75em{\csname the#1\endcsname}\hskip.75zw%
      \fi
%      \protect\jidoukintou{#7}}%
      {#7}%\vfill
}}%
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
%          \protect\Snumberline{\csname the#1\endcsname}%
%         \protect\numberline{\csname the#1\endcsname}%
         \protect\hbox to.75em{\csname the#1\endcsname}%
        \fi
        #7}}%
  \fi
  \@xsect{#5}}
\def\@xsect#1{%
  \@tempskipa #1\relax
  \ifdim \@tempskipa>\z@
    \par \nobreak
    \vskip \@tempskipa
    \@afterheading
  \else
    \@nobreakfalse
    \global\@noskipsectrue
    \everypar{%
      \if@noskipsec
        \global\@noskipsecfalse
       {\setbox\z@\lastbox}%
        \clubpenalty\@M
        \begingroup \@svsechd \endgroup
        \unskip
        \@tempskipa #1\relax
        \hskip -\@tempskipa
      \else
        \clubpenalty \@clubpenalty
        \everypar{}%
      \fi}%
  \fi
  \ignorespaces}
%\def\@seccntformatA#1{\protect\SECTUP{\csname the#1\endcsname\quad}}
\def\@seccntformatAPP#1{\csname the#1\endcsname\hskip1zw}
\def\@ssectAPP#1#2#3#4#5{%
  \@tempskipa #3\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #4{%
        \@hangfrom{\hskip #1}%
          \interlinepenalty \@M #5\@@par}%
    \endgroup
  \else
    \def\@svsechd{#4{\hskip #1\relax #5}}%
  \fi
  \@xsect{#3}}
\newif\if@afterindent \@afterindenttrue
\def\@afterheading{%
  \@nobreaktrue
  \everypar{%
    \if@nobreak
      \@nobreakfalse
      \clubpenalty \@M
      \if@afterindent \else
        {\setbox\z@\lastbox}%
      \fi
    \else
      \clubpenalty \@clubpenalty
      \everypar{}%
    \fi}}
\def\@hangfrom#1{\setbox\@tempboxa\hbox{#1}%
      \hangindent \wd\@tempboxa\noindent\box\@tempboxa}




%%%%%%%%%%%%%%% C
\def\@startsectionCAPP#1#2#3#4#5#6{\if@noskipsec \leavevmode \fi
  \par  \@tempskipa #4\relax
  \@afterindenttrue
  \ifdim \@tempskipa <\z@    \@tempskipa -\@tempskipa \@afterindentfalse  \fi
  \if@nobreak
    \everypar{}%
  \else
    \addpenalty\@secpenalty
\ifnum #2=\@ne
       \vskip-\prevdepth \prevdepth\z@ \vskip\Cvs
       \advance\@tempskipa-\Cvs \vspace*{\@tempskipa}%
     \else
\addvspace\@tempskipa
\fi
  \fi
  \@ifstar
    {\@ssectCAPP{#3}{#4}{#5}{#6}}%
    {\@dblarg{\@sectCAPP{#1}{#2}{#3}{#4}{#5}{#6}}}}

\def\@sectCAPP#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{%\protect\rule{0mm}{21.75mm}
\@seccntformatCAPP{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #6{%
%        \centering
\@hangfrom{\hskip #3\relax\@svsec}%
%          \interlinepenalty \@M \protect\SECTUP{\jidoukintou{#8}}\@@par}%
          \interlinepenalty \@M {#8}\@@par}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
%        \protect\numberline{\csname the#1\endcsname}%
        \protect\hbox to 2em{\csname the#1\endcsname}%
      \fi
      {#7}}%
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\hbox to 2.3em{\csname the#1\endcsname}%
        \fi
        #7}}%
  \fi
  \@xsect{#5}}
\def\@xsect#1{%
  \@tempskipa #1\relax
  \ifdim \@tempskipa>\z@
    \par \nobreak
    \vskip \@tempskipa
    \@afterheading
  \else
    \@nobreakfalse
    \global\@noskipsectrue
    \everypar{%
      \if@noskipsec
        \global\@noskipsecfalse
       {\setbox\z@\lastbox}%
        \clubpenalty\@M
        \begingroup \@svsechd \endgroup
        \unskip
        \@tempskipa #1\relax
        \hskip -\@tempskipa
      \else
        \clubpenalty \@clubpenalty
        \everypar{}%
      \fi}%
  \fi
  \ignorespaces}
%\def\@seccntformatC#1{\protect\SECTUP{\csname the#1\endcsname\quad}}
\def\@seccntformatCAPP#1{\csname the#1\endcsname\hskip1zw}
\def\@ssectCAPP#1#2#3#4#5{%
  \@tempskipa #3\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #4{%
%        \centering
\@hangfrom{\hskip #1}%
          \interlinepenalty \@M {#5}\@@par}%
    \endgroup
  \else
    \def\@svsechd{#4{\hskip #1\relax #5}}%
  \fi
  \@xsect{#3}}
\newif\if@afterindent \@afterindenttrue
\def\@afterheading{%
  \@nobreaktrue
  \everypar{%
    \if@nobreak
      \@nobreakfalse
      \clubpenalty \@M
      \if@afterindent \else
        {\setbox\z@\lastbox}%
      \fi
    \else
      \clubpenalty \@clubpenalty
      \everypar{}%
    \fi}}
\def\@hangfrom#1{\setbox\@tempboxa\hbox{#1}%
      \hangindent \wd\@tempboxa\noindent\box\@tempboxa}



\def\@makeAPPschapterhead#1{%
\vbox to 41mm{\parindent\z@
{\centering{%\hsize\@tempdima
\Large\bfseries\mathversion{bold}\protect\Shingoxviii
#1}\vfill}%
}
}




\renewcommand{\appendix}{%
\clearpage%
%  \if@twocolumn\@restonecoltrue\onecolumn
%  \else\@restonecolfalse\fi
\def\@schapter##1{%\if@openright\clearpage\else\clearpage\fi%
  \@makeAPPschapterhead{##1}\thispagestyle{PARTheadings}\@afterheading
}
%  \chapter*{\appendixname}
%---------------
\vbox to 6\Cvs{\parindent\z@%\vfill%
{\centering{%\hsize\@tempdima
\Large\bfseries\mathversion{bold}\protect\Shingoxviii
\appendixname}\vfill}%
}
%----------------
\@mkboth{\appendixname}{\appendixname}
% \@starttoc{toc}%%%%%%%%%%%%%%%%%% bugfix
  \if@restonecol\twocolumn\fi
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \renewcommand{\@chapapp}{\appendixname}%
  \renewcommand{\@chappos}\space%
  \renewcommand{\thechapter}{\@Alph\c@chapter}
\addcontentsline{toc}{chapter}{付録}
%%% 12Q baseline 9Q
\small\par
\baselineskip=21H%
%%%
 \setcounter{chapter}{0}
 \setcounter{section}{0}
 \setcounter{equation}{0}
% \setcounter{定理}{0}
 \def\@chapapp{付 録}
 \def\thechapter{\Alph{chapter}}
 \def\thesection{\Alph{section}}
 \def\thesubsection{\Alph{section}.\arabic{subsection}}
 \def\theequation{\thesection.\arabic{equation}}
 \def\thefigure{\thesection.\@arabic\c@figure}
 \def\thetable{\thesection.\@arabic\c@table}
\def\the定理{\Alph{section}.\@arabic\c@定理}
\def\the命題{\Alph{section}.\@arabic\c@命題}
\def\the定義{\Alph{section}.\@arabic\c@定義}
\def\the系{\Alph{section}.\@arabic\c@系}
\def\the補題{\Alph{section}.\@arabic\c@補題}
\@addtoreset{equation}{section}
\@addtoreset{定理}{section}
\@addtoreset{命題}{section}
\@addtoreset{定義}{section}
\@addtoreset{系}{section}
\@addtoreset{補題}{section}
\@addtoreset{figure}{section}
\@addtoreset{footnote}{section}

\renewcommand{\section}{\@startsectionAPP{section}{1}{13\h}%
{1.3125\Cvs}%1.1875 \@plus1.3\Cdp\@minus10.5\Cdp}%
{.00001\Cvs%\@minus.5\Cdp
}%
   {\reset@font\large%\bfseries%
\protect\mathversion{bold}\Shingoxiv\GothExiv%
}}
%
\renewcommand{\subsection}{\@startsectionCAPP{subsection}{1}{13\h}%
{10.75\h}
{10.75\h}
   {\reset@font\normalsize\bfseries\Shingoxiii\GothExiii\protect\mathversion{bold}}}
%%% bugfix
\renewcommand{\subsectionII}{\@startsectionCAPP{subsection}{1}{13\h}%
{10.75\h}
{10.75\h}
   {\reset@font\normalsize\bfseries\Shingoxiii\GothExiii\protect\mathversion{bold}}}
%%%%%%%% end bugfix
\renewenvironment{enumerate}
  {\ifnum \@enumdepth >3\relax\@toodeep\else
   \advance\@enumdepth\@ne
   \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
   \list{\csname label\@enumctr\endcsname}{%
         \ifnum \@listdepth=\@ne \topsep.5\normalbaselineskip
           \else\topsep\z@\fi
         \parskip\z@ \itemsep\z@ \parsep\z@
         \labelwidth1zw \labelsep.3zw
         \ifnum \@enumdepth=\@ne \leftmargin1.5zw\relax
           \else\leftmargin\leftskip\fi
         \advance\leftmargin 1zw
         \usecounter{\@enumctr}%
         \def\makelabel####1{\hss\llap{####1}}}%
   \fi}{\endlist}
}



\newenvironment{abstract}{\normalsize%
\vskip22\h\vskip4\h%
\begin{list}{}%
{\small%
\@tempdima\textwidth%
\advance\@tempdima - 32zw
\@tempdima.5\@tempdima
\parsep\z@\partopsep\z@\topsep\z@\parskip\z@%
\leftmargin=\@tempdima\rightmargin=\@tempdima}\item}
{\end{list}\normalsize\vskip\baselineskip}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%
%\setlength{\textheight}{28\baselineskip}
\setlength{\textheight}{30\baselineskip}
%
\addtolength{\textheight}{\topskip}
\setlength{\textwidth}{34\Cwd}
  \setlength\paperheight {210mm}
  \setlength\paperwidth  {148mm}
%\evensidemargin=-8.25mm%    小口 17mm
%\oddsidemargin=-5mm%-7mm%   
\topmargin=-15mm%          天 21mm

%%% 左右中央！
\@tempdima\paperwidth
\advance\@tempdima-\textwidth
\@tempdima.5\@tempdima
\advance\@tempdima-1in
\oddsidemargin\@tempdima
\evensidemargin\@tempdima




\if@Nopsfont
\font\Shingoxxxii=goth10 at 24\JQ %%ゴナD代用
\font\Shingoxxiv=goth10 at 20\JQ %%ゴナD代用
\font\Shingoxviii=goth10 at 18\JQ %%ゴナD代用
\font\Shingoxvi=goth10 at 16\JQ %%ゴナD代用
\font\Shingoxiv=goth10 at 14\JQ %%ゴナD代用
\font\Shingoxiii=goth10 at 13\JQ %%ゴナD代用
%
\font\ShingoExxxii=cmbx10 at 24\Q %%
\font\ShingoExxiv=cmbx10 at 20\Q %%
\font\ShingoExiv=cmbx10 at 14\Q %%
\font\GothExvi=cmbx10 at 16\Q %%
\font\GothExiv=cmbx10 at 14\Q %%ヘルベチカ代用
\font\GothExiii=cmbx10 at 13\Q %%ヘルベチカ代用
\font\Garaxiii=cmss10 at 12\JQ %%ガラモンド代用
\else
\font\Shingoxxxii=sgr at 24\JQ %%ゴナD -> 新ゴR
\font\Shingoxxiv=sgr at 20\JQ %%ゴナD -> 新ゴR
\font\Shingoxviii=sgr at 18\JQ %%ゴナD -> 新ゴR
\font\Shingoxvi=sgr at 16\JQ %%ゴナD -> 新ゴR
\font\Shingoxiv=sgr at 14\JQ %%ゴナD -> 新ゴR
\font\Shingoxiii=sgr at 13\JQ %%ゴナD -> 新ゴR
%
\font\ShingoExxxii=cmbx10 at 24\Q %%
\font\ShingoExxiv=cmbx10 at 20\Q %%
\font\ShingoExiv=cmbx10 at 14\Q %%
\font\GothExvi=cmbx10 at 16\Q %%
\font\GothExiv=phvr7t at 14\Q %%ヘルベチカ
\font\GothExiii=phvr7t at 13\Q %%ヘルベチカ
\font\Garaxiii=padr8r at 12\JQ %%ガラモンド
\fi



%%%%
\if@JISfmt
\font\KFpart = goth10 at 32\JQ
\font\KFchap = goth10 at 24\JQ
\font\KFsec = goth10 at 14\JQ
\font\KFchaptitle = goth10 at 24\JQ
\font\Nej = min10 at 14\JQ
%%%
\else
%%%
\font\KFpart = jisg at 32\JQ
\font\KFchap = jisg at 24\JQ
\font\KFsec = jisg at 14\JQ
\font\KFchaptitle = jisg at 24\JQ
\font\Nej = jis at 14\JQ
\fi
%%%%
\font\EFchaptitle = cmbx10 at 24\Q
\font\EFchap = cmbx10 at 53\Q%26\Q
\font\EFsec = cmbx10 at 15\Q
\font\EFpart = cmbx10 at 34\Q
\font\Nee = cmr10 at 14\Q



\predisplaypenalty=0

%% --- 後から読み込まれるフォントパッケージ（otf等）が JY1 フォント定義を
%% --- 上書きした場合に備え、\begin{document} 時点で文字寸法を再計測する。
\AtBeginDocument{%
  \normalsize
  \setbox0\hbox{\char\euc"A1A1}%
  \setlength\Cht{\ht0}%
  \setlength\Cdp{\dp0}%
  \setlength\Cwd{\wd0}%
  \setlength\Cvs{\baselineskip}%
  \setlength\Chs{\wd0}%
}

\endinput
%%
%% End of file `todai-e.cls'.
