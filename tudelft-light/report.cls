% -----------------------------------------------------------------------------
%
% Copyright (c) 2020. San Kilkis. All rights reserved.
% 
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/
%
% --- Class Documentation: ----------------------------------------------------
% 
% This package provides the tudelft-light/report class for use with XeLaTeX.
% 
% The document class is based on the report class from the LaTeX Std. Lib.
% For a full list of available document options refer to: 
% https://en.wikibooks.org/wiki/LaTeX/Document_Structure
%
% Optional Keyword Arguments:
%   fancyheader (bool): Turns the fancy header On/Off.
%
% Note:
%   To make it easier to navigate the code, several subpackages have been
%   created which can be summarized as follows:
%
%       * packages.sty: Contains all package imports necessary for the class
%       * style.sty: Contains style definitions such as color and fonts
%       * setup.sty: Contains macros for document metadata setup
%       * cover.sty: Contains the \makecover macro for the outer cover page
%       * title.sty: Containts the \maketitle macro for the inner title page
%       * macros.sty: Contains custom macros and environments.
%
% -----------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tudelft-light/report}[2018/02/08 TU Delft Light Report Class]

\RequirePackage{iftex}
\RequireXeTeX % Raises error if not compiling with XeLaTeX
 
% --- Class Options: ----------------------------------------------------------
\RequirePackage{kvoptions}

% Simplifying family name, otherwise it would be tudelft-light/report
\SetupKeyvalOptions{
    family=tud,
    prefix=tud@,
}

\DeclareBoolOption{fancyheader}

% Passing all unspecified options to the report class of the LaTeX Std. Lib.
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOptionKey}{report}}
\ProcessKeyvalOptions*

\LoadClass{report}

% --- Importing TU Delft Light Packages: --------------------------------------
\RequirePackage{tudelft-light/packages}
\RequirePackage{tudelft-light/style}
\RequirePackage{tudelft-light/setup}
\RequirePackage{tudelft-light/cover}
\RequirePackage{tudelft-light/title}
\RequirePackage{tudelft-light/macros}

% --- Document Layout & Title Margins: ----------------------------------------
\titlespacing*{\chapter}{0pt}{-25pt}{10pt}
\definecolor{gray75}{gray}{0}
\newcommand{\hsp}{\hspace{3pt}}
\titleformat{\chapter}[hang]%
    {\Huge\bfseries}%
    {\thechapter\hsp\textcolor{gray75}\hsp}%
    {10pt}{\Huge\bfseries}

\setlength{\parindent}{0cm} % No indent on paragraphs

% --- Header & Footnote Configuration: ----------------------------------------
% Uses the truncate package to crop long section and chapter titles
% Once the specified width is exceeded the title is split, the left
% portion is kept, and `...' dots are appended to the end
\fancypagestyle{fancytruncated}{%
    \fancyhead[R]{\itshape\small \truncate{0.47\textwidth} \leftmark}
    \fancyhead[L]{\itshape\small \truncate{0.47\textwidth} \rightmark}
}

\iftud@fancyheader
    \pagestyle{fancytruncated} % Display a fancy header on subsequent pages
\fi

% Footnote style Roman numerals
\renewcommand{\thefootnote}{\roman{footnote}}

% --- Nomenclature Categories and Configuration: ------------------------------
\makenomenclature

\renewcommand\nomgroup[1]{%
    \item[\bfseries
        \ifthenelse{\equal{#1}{G}}{Greek Symbols}{%
        \ifthenelse{\equal{#1}{B}}{Roman Symbols}{%
        \ifthenelse{\equal{#1}{S}}{Subscripts}{%
        \ifthenelse{\equal{#1}{T}}{Superscripts}{%
        \ifthenelse{\equal{#1}{A}}{Abbreviations}{}}}}}%
    ]}

% Renames Nomenclature to List of Symbols
\renewcommand{\nomname}{List of Symbols}

% Formats the units of the nomenclature
\newcommand{\nomunit}[1]{%
    \renewcommand{\nomentryend}{%
        \hspace*{\fill}\si{#1}%
    }
}

% --- Plot Configuration: -----------------------------------------------------
\pgfplotsset{compat=1.16} % Setting compatibility for PGF Plots

% --- Table Spacing & Layout Parameters: --------------------------------------
\renewcommand{\arraystretch}{1.2}
\newcolumntype{C}{>{\small\centering\arraybackslash}X} %For tabularX
\newcolumntype{L}{>{\small\raggedright\arraybackslash}X} %For tabularX
\newcolumntype{R}{>{\small\raggedleft\arraybackslash}X} %For tabularX
\newcolumntype{P}[1]{>{\centering\arraybackslash}p{#1}} % centered p column

%Changes parameters for \hdashline to make the dashes into dots:
\setlength\dashlinedash{0.2pt}
\setlength\dashlinegap{1.5pt}
\setlength\arrayrulewidth{0.3pt}

% --- Math Configuration: -----------------------------------------------------
% Removes Parenthesis around Equation labels
\creflabelformat{equation}{#2\textup{#1}#3}

% --- Biblography Configuration: ----------------------------------------------
\addbibresource{references.bib} %Bibliography File
\newcommand{\BibliographyName}{References} %Name of Biblography
