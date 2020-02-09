% Refer to: https://www.overleaf.com/learn/latex/Writing_your_own_class

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tudelft-light/report}[2018/02/08 TU Delft Light Report Class]
 
\LoadClass{report}
\RequirePackage{tudelft-light/packages}
\RequirePackage{tudelft-light/style}
\RequirePackage{tudelft-light/macros}

%\\\\\\\\\\\ Document Layout & Title Margins \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

\titlespacing*{\chapter}{0pt}{-25pt}{10pt}
\definecolor{gray75}{gray}{0}
\newcommand{\hsp}{\hspace{3pt}}
\titleformat{\chapter}[hang]%
    {\Huge\bfseries}%
    {\thechapter\hsp\textcolor{gray75}\hsp}%
    {10pt}{\Huge\bfseries}

\setlength{\parindent}{0cm} % No indent on paragraphs

%\\\\\\\\\\ Header & Footnote Configuration \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

% Uses the truncate package to crop long section and chapter titles
% Once the specified width is exceeded the title is split, the left
% portion is kept, and `...' dots are appended to the end
\fancypagestyle{fancytruncated}{%
    \fancyhead[R]{\small \truncate{0.47\textwidth} \leftmark}
    \fancyhead[L]{\small \truncate{0.47\textwidth} \rightmark}
}
\pagestyle{fancytruncated} % Display a fancy header on subsequent pages

% Footnote style Roman numerals
\renewcommand{\thefootnote}{\roman{footnote}} 

%\\\\\\\\\\ Nomenclature Categories and Configuration \\\\\\\\\\\\\\\\\\\\\\\\\
\makenomenclature

\renewcommand\nomgroup[1]{%
    \item[\bfseries
        \ifthenelse{\equal{#1}{G}}{Greek Symbols}{%
        \ifthenelse{\equal{#1}{B}}{Roman Symbols}{%
        \ifthenelse{\equal{#1}{S}}{Subscripts}{%
        \ifthenelse{\equal{#1}{T}}{Superscripts}{%
        \ifthenelse{\equal{#1}{A}}{Abbreviations}{}}}}}%
    ]}

%Renames Nomenclature to List of Symbols
\renewcommand{\nomname}{List of Symbols}

%\\\\\\\\\\ Plot Configuration \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
\pgfplotsset{compat=1.16} % Setting compatibility for PGF Plots

%\\\\\\\\\\ Table Spacing & Layout Parameters \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

\renewcommand{\arraystretch}{1.2}
\newcolumntype{C}{>{\small\centering\arraybackslash}X} %For tabularX
\newcolumntype{L}{>{\small\raggedright\arraybackslash}X} %For tabularX
\newcolumntype{R}{>{\small\raggedleft\arraybackslash}X} %For tabularX
\newcolumntype{P}[1]{>{\centering\arraybackslash}p{#1}} % centered p column

%Changes parameters for \hdashline to make the dashes into dots:
\setlength\dashlinedash{0.2pt}
\setlength\dashlinegap{1.5pt}
\setlength\arrayrulewidth{0.3pt}

%\\\\\\\\\\ Math Configuration \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

% Removes Parenthesis around Equation labels
\creflabelformat{equation}{#2\textup{#1}#3}

%\\\\\\\\\\ Biblography Configuration \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

\addbibresource{references.bib} %Bibliography File
\newcommand{\BibliographyName}{References} %Name of Biblography

%\\\\\\\\\\ TU Delft House Style Colors \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
\definecolor{tudelft-cyan}{cmyk}{1,0,0,0}
\definecolor{tudelft-black}{cmyk}{0,0,0,1}
\definecolor{tudelft-white}{cmyk}{0,0,0,0}
\definecolor{tudelft-sea-green}{cmyk}{0.54,0,0.32,0}
\definecolor{tudelft-green}{cmyk}{1,0.15,0.4,0}
\definecolor{tudelft-dark-blue}{cmyk}{1,0.66,0,0.4}
\definecolor{tudelft-purple}{cmyk}{0.98,1,0,0.35}
\definecolor{tudelft-turquoise}{cmyk}{0.82,0,0.21,0.08}
\definecolor{tudelft-sky-blue}{cmyk}{0.45,0,0.06,0.06}
\definecolor{tudelft-lavendel}{cmyk}{0.45,0.2,0,0.07}
\definecolor{tudelft-orange}{cmyk}{0.02,0.56,0.84,0}
\definecolor{tudelft-warm-purple}{cmyk}{0.58,1,0,0.02}
\definecolor{tudelft-fuchsia}{cmyk}{0.19,1,0,0.19}
\definecolor{tudelft-bright-green}{cmyk}{0.36,0,1,0}
\definecolor{tudelft-yellow}{cmyk}{0.02,0,0.54,0}