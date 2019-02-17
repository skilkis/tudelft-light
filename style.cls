%\\\\\\\\\\\Document Properties\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

    \documentclass[11pt,a4paper,reqno,titlepage]{report}
    \usepackage[margin=6pc, headheight=14pt]{geometry}
    \usepackage[utf8]{inputenc}
    \usepackage{xcolor} % Useful for colored tables!
    \usepackage{amsfonts}
    \usepackage{amsmath}
    \usepackage{mathtools}
    \usepackage{amssymb}
    \usepackage{graphicx}
    \usepackage{tikz}
    \usepackage{pgfplots}
    \usepackage{datatool}
    \usepackage{tabularx}
    \usepackage{rotating}
    \usepackage{float}
    \usepackage{booktabs}
    \usepackage{titlesec,color}
    \usepackage{caption}
    \usepackage{enumitem}
    \usepackage{subcaption}
    \usepackage{pdfpages}
    \usepackage[hyphens]{url}
    \usepackage{array}
    \usepackage{fancyhdr} % Inserts a fancy smancy header into sub-pages
    \pagestyle{fancy}
    \usepackage{notoccite}
    \usepackage[symbol]{footmisc}
    \usepackage{listings}
    \usepackage{siunitx}
    \usepackage[titletoc]{appendix}
    \usepackage{arydshln} % Adding dashlines in arrays \hdashline        
    \pgfplotsset{compat=1.14} % Setting compatibility for PGF Plots
    
    %% FOR DEBUGGING %%
    \usepackage{blindtext}


%\\\\\\\\\\\Document Properties\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

    \usepackage[hidelinks, unicode]{hyperref}
    \hypersetup{
        pdftoolbar=true,        % show Acrobat’s toolbar?
        pdfmenubar=true,        % show Acrobat’s menu?
        pdffitwindow=false,     % window fit to page when opened
        pdfstartview={FitH},    % fits the width of the page to the window
        pdftitle={},            % title
        pdfauthor={},           % author
        pdfsubject={},          % subject of the document
        pdfcreator={},          % creator of the document
        pdfproducer={},         % producer of the document
        pdfkeywords={},         % list of keywords
        pdfnewwindow=true,      % links in new window
        colorlinks=true,        % false: boxed links; true: colored links
        linkcolor=black,        % color of internal links (change box color with linkbordercolor)
        citecolor=cyan,         % color of links to bibliography
        filecolor=black,        % color of file links
        urlcolor=black          % color of external links
    }

    \usepackage[capitalise, noabbrev, nameinlink]{cleveref} % Automatic Referencing: WARNING HAS TO BE LOADED AFTER hyperref
    \creflabelformat{equation}{#2\textup{#1}#3} % Removes Parenthesis around Equation labels
    
    \renewcommand{\thefootnote}{\roman{footnote}} % Footnote style Roman numerals
    \usepackage{tablefootnote}

%\\\\\\\\\\\Setting-up Nomenclature Classes\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

    \usepackage{nomencl}
    \makenomenclature
        
    \usepackage{etoolbox}
    \renewcommand\nomgroup[1]{%
        \item[\bfseries
            \ifstrequal{#1}{G}{Greek Symbols}{%
            \ifstrequal{#1}{B}{Roman Symbols}{%
            \ifstrequal{#1}{S}{Subscripts}{%
            %ADD MORE CLASSES HERE (Order does not matter, LaTeX will sort classes Based on !Class Reference
            %\ifstrequal{#1}{!Class Reference}{!Class Name}{%
            %\ifstrequal{#1}{!Class Reference}{!Class Name}{%
            %\ifstrequal{#1}{!Class Reference}{!Class Name}{%
            \ifstrequal{#1}{A}{Abbreviations}{}}}}%
        ]}
     
    % This argument will add the units
    \newcommand{\nomunit}[1]{%
    \renewcommand{\nomentryend}{\hspace*{\fill}[#1]}}
    
    %Renames Nomenclature to List of Symbols
    \renewcommand{\nomname}{List of Symbols}
               
%\\\\\\\\\\\Definining MATLAB Appendix Colors\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    
    \definecolor{mygreen}{RGB}{28,172,0}
    \definecolor{mylilas}{RGB}{170,55,241}
    \definecolor{mygrey}{RGB}{125,125,125}
    \definecolor{myBG}{RGB}{252,252,220}

%\\\\\\\\\\Table Spacing & Layout Parameters\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

    \renewcommand{\arraystretch}{1.2}
    \newcolumntype{C}{>{\small\centering\arraybackslash}X} %For tabularX
    \newcolumntype{L}{>{\small\raggedright\arraybackslash}X} %For tabularX
    \newcolumntype{R}{>{\small\raggedleft\arraybackslash}X} %For tabularX
    
    %Changes parameters for \hdashline to make the dashes into dots:
    \setlength\dashlinedash{0.2pt}
    \setlength\dashlinegap{1.5pt}
    \setlength\arrayrulewidth{0.3pt}
    
%\\\\\\\\\\\Set Document Layout & Title Margins\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

    \titlespacing*{\chapter}{0pt}{-25pt}{10pt}
    \definecolor{gray75}{gray}{0}
    \newcommand{\hsp}{\hspace{3pt}}
    \titleformat{\chapter}[hang]{\Huge\bfseries}{\thechapter\hsp\textcolor{gray75}\hsp}{10pt}{\Huge\bfseries}

%\\\\\\\\\\\Rename Bibliography to References\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

    \usepackage[
    backend=biber,
    style=numeric,
    citestyle=numeric,
    sorting=none
    ]{biblatex}
    \addbibresource{references.bib} %Bibliography File
    \newcommand{\BibliographyName}{References} %Name of Biblography