%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% |  _  \  \/  | | |       |_   _|  \ \ / / /  __ \ |              
% | | | | .  . | | |     __ _| | ___ \ V /  | /  \/ | __ _ ___ ___ 
% | | | | |\/| | | |    / _` | |/ _ \/   \  | |   | |/ _` / __/ __|
% | |/ /| |  | | | |___| (_| | |  __/ /^\ \ | \__/\ | (_| \__ \__ \
% |___/ \_|  |_/ \_____/\__,_\_/\___\/   \/  \____/_|\__,_|___/___/

% Classe LaTeX para documentos científicos 
% do DM UFSCar segundo as normas ABNT e BCO UFSCar

% Autor: Wladimir Seixas
% email: seixas@ufscar.br
% Versão: 25/11/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dmtex}[2021 DMTex]

\newif\if@tcc
\newif\if@profmat
\newif\if@ppgece
\newif\if@mestre
\newif\if@doutor

\newif\if@nofont
\@nofonttrue

\def\curso#1{\gdef\@curso{#1}}
\curso{Licenciatura/Bacharelado}

\DeclareOption{tcc}{\@tcctrue}
\DeclareOption{licenciatura}{\curso{Licenciatura}}
\DeclareOption{bacharelado}{\curso{Bacharelado}}
\DeclareOption{profmat}{\@profmattrue}
\DeclareOption{ppgece}{\@ppgecetrue}
\DeclareOption{mestre}{\@mestretrue}
\DeclareOption{doutor}{\@doutortrue}

\DeclareOption{nofont}{\@nofontfalse}

\ProcessOptions

% Formato
% Papel​: A4 - se impresso, utilizar papel branco ou reciclado 
%             e pode-se utilizar verso e anverso.
% Elementos pré-textuais ​ devem iniciar sempre no anverso.

% Fonte​ :
% Para todo texto: tamanho 12 e recomenda-se escolher um tipo de fonte legível
% como a Times New Roman ou Arial.
\LoadClass[12pt,a4paper,openright,fleqn]{report}

% Selecao de codigos de fonte
\RequirePackage[T1]{fontenc}

\if@nofont
% Helvetica Font: ambiente texto e matemático
\renewcommand{\familydefault}{\sfdefault}
\RequirePackage[scaled=0.9]{helvet}
\RequirePackage[helvet]{sfmath}
\everymath={\sf}
\else
\RequirePackage{lmodern}
\fi

% Não permitir caixa-alta nos títulos matemáticos
%\MakeTextUppercase -> textcase
\RequirePackage[overload]{textcase} 

% Codificacao do documento (conversão automática dos acentos)	
\RequirePackage[utf8]{inputenc}		

% Títulos & ortografia em português
\RequirePackage[brazil]{babel}

% Melhora a qualidade do PDF
\RequirePackage[babel=true]{microtype}

% Modo frente-verso: inicia capítulo sempre em página de número ímpar
% Caso o capítulo termine em página em branco elimina o cabeçalho
\def\cleardoublepage{%
   \clearpage
   \if@twoside \ifodd\c@page
                     \else \null
            		       \thispagestyle{empty}
            		       \newpage
               \fi
   \fi
}

% Margens​ :
% Anverso​ : esquerda e superior 3 cm / direita e inferior 2 cm;
% Verso ​  : direita e inferior 3 cm / esquerda e superior 2 cm.*
% * O verso da folha somente será utilizado para os trabalhos impressos.
\RequirePackage{geometry}
\geometry{right=2cm,left=3cm,top=3cm,bottom=2cm}

% Espaçamento
% Texto: 1,5 entrelinhas
\RequirePackage[onehalfspacing]{setspace}

% Não centraliza a página verticalmente
\raggedbottom

% Manipulação de figuras
\RequirePackage{graphicx}

% Posição de figuras e tabelas
\RequirePackage{float}

% Parágrafo após um capítulo/seção
\RequirePackage{indentfirst}
\setlength{\parindent}{1.2cm}

% Cabeçalho e rodapé
\RequirePackage{fancyhdr}
\RequirePackage{etoolbox}
\pagestyle{fancy}
\lhead{}
\chead{}
\rhead{\footnotesize\thepage}
\cfoot{}
\lfoot{}
\rfoot{}
\renewcommand{\headrule}{}

% Citações com mais de três linhas, Notas de Rodapé, Paginação, Legendas,
% Fontes das Ilustrações e das Tabelas: recomenda-se utilizar uma fonte
% menor, por exemplo 10 e espaçamento simples.
% Citações com mais de três linhas, Notas de Rodapé, Referências, Legendas das
% ilustrações e das tabelas: espaçamento simples.
\renewenvironment{quote}
               {\list{}{\setlength{\leftmargin}{4cm}}%
                \item \singlespace\footnotesize \relax}
               {\endlist}

% Legendas para figuras e tabelas
\RequirePackage{caption}
\captionsetup{font={footnotesize,stretch=1},
              format=hang,
              labelsep=endash,
              belowskip=12pt,
              aboveskip=12pt
              }%

% Nota de rodapé 
\RequirePackage[hang]{footmisc}
\interfootnotelinepenalty=\@M
\renewcommand{\footnoterule}{%
  \kern -3pt
  \hrule width 3cm height 1pt
  \kern 2pt
}

% Formatação para itemize, enumerate e description
\RequirePackage{enumitem}
\setlist[itemize]{leftmargin=1.7cm}
\setlist[enumerate]{leftmargin=1.7cm,label=\alph*)}
\renewcommand\labelitemi{--}

% Informações na folha de rosto (natureza, tipo de trabalho,
% objetivo, nome da instituição, área de concentração: ​ espaçamento simples.
% Na folha de rosto as informações referentes ao tipo de trabalho, objetivo, nome da
% instituição e área de concentração, devem ser alinhados do meio da folha para a
% margem direita
\def\progresp#1{\gdef\@progresp{#1}}
\global\let\@progresp\@empty
\def\logoprog#1{\gdef\@logoprog{#1}}
\global\let\@logoprog\@empty
\def\objetivo#1{\gdef\@objetivo{#1}}
\global\let\@objetivo\@empty
\def\logosize#1{\gdef\@logosize{#1}}

% Timbre e objetivo
\if@tcc \def\@progresp{DEPARTAMENTO DE MATEM\'{A}TICA}
        \def\@logosize{0.12}
        \def\@logoprog{./arquivosdmtex/LogoDM}
        \def\@objetivo{%
            \begin{minipage}[t]{0.5\textwidth}%
              Monografia apresentada ao Curso de {\@curso} em Matem\'{a}tica 
              da Universidade Federal de São Carlos.
            \end{minipage}}
\else 
\if@profmat \def\@progresp{PROGRAMA DE MESTRADO PROFISSIONAL \\ 
                           EM REDE NACIONAL}
            \def\@logosize{0.12}
            \def\@logoprog{./arquivosdmtex/LogoProfMat}
            \def\@objetivo{%
            \begin{minipage}[t]{0.5\textwidth}%
                Disserta\c{c}\~{a}o apresentada ao Programa de
                P\'{o}s-Gradua\c{c}\~{a}o em Matem\'{a}tica em Rede 
                Nacional como requisito parcial para a obten\c{c}\~{a}o 
                do grau de Mestre.
            \end{minipage}}
\else 
\if@ppgece \def\@progresp{PROGRAMA DE MESTRADO PROFISSIONAL \\ 
                          EM ENSINO DE CI\^{E}NCIAS EXATAS}
            \def\@logosize{0.15}
            \def\@logoprog{./arquivosdmtex/LogoPPGECE}
            \def\@objetivo{%
            \begin{minipage}[t]{0.5\textwidth}%
                Disserta\c{c}\~{a}o apresentada ao Programa de
                P\'{o}s-Gradua\c{c}\~{a}o em Ensino de Ci\^{e}ncias
                Exatas como requisito parcial para a obten\c{c}\~{a}o 
                do grau de Mestre.
            \end{minipage}}
\else
\if@mestre \def\@progresp{PROGRAMA DE P\'{O}S-GRADUA\c{C}\~{A}O EM MATEM\'{A}TICA}
           \def\@logosize{0.1}
           \def\@logoprog{./arquivosdmtex/LogoDM}
           \def\@objetivo{%
           \begin{minipage}[t]{0.5\textwidth}%
               Disserta\c{c}\~{a}o apresentada ao Programa de
               P\'{o}s-Gradua\c{c}\~{a}o em Matem\'{a}tica como 
               requisito parcial para a obten\c{c}\~{a}o do grau de Mestre.
           \end{minipage}}
\else
\if@doutor \def\@progresp{PROGRAMA DE P\'{O}S-GRADUA\c{C}\~{A}O EM MATEM\'{A}TICA}
           \def\@logosize{0.1}
           \def\@logoprog{./arquivosdmtex/LogoDM}
           \def\@objetivo{%
           \begin{minipage}[t]{0.5\textwidth}%
               Tese apresentada ao Programa de
               P\'{o}s-Gra\-du\-a\-\c{c}\~{a}o em Matem\'{a}tica como 
               requisito parcial para a obten\c{c}\~{a}o do grau de Doutor.
           \end{minipage}}
\fi \fi \fi \fi \fi

% Dados
\def\titulo#1{\gdef\@titulo{#1}}
\def\autoria#1{\gdef\@autoria{#1}}
\def\orientador#1{\gdef\@orientador{#1}}
\def\orientadora#1{\gdef\@orientadora{#1}}
\global\let\@orientadora\@empty
\def\coorientador#1{\gdef\@coorientador{#1}}
\global\let\@coorientador\@empty
\def\coorientadora#1{\gdef\@coorientadora{#1}}
\global\let\@coorientadora\@empty
\def\ano#1{\gdef\@ano{#1}}
\global\let\@ano\@year

\def\orientacao#1{\gdef\@orientacao{#1}}
\global\let\@orientacao\@empty

\def\@orientacao{%
   \vspace{1.5\baselineskip}
   \begin{minipage}[t]{0.5\textwidth}
    \ifx\@orientadora\@empty Orientador: Prof. Dr. \@orientador
    \else Orientadora: Profa. Dra. \@orientadora
    \fi%
    \par
    \ifx\@coorientadora\@empty 
        \ifx\@coorientador\@empty 
            \else Coorientador: Prof. Dr. \@coorientador
        \fi%
    \else Coorientadora: Profa. Dra. \@coorientadora
    \fi%
\end{minipage}}

% Capa
\newcommand\capa{%
   \setcounter{page}{0}
   \if@openright\cleardoublepage\else\clearpage\fi
   \ps@empty 
   \begin{singlespace}
   \parindent \z@ \centering 
   $\vcenter{\hbox{\includegraphics[width=0.15\textwidth]{./arquivosdmtex/LogoUFSCar}}}$
   \hfill
   \begin{minipage}[c]{0.68\textwidth}
     \begin{center}
        UNIVERSIDADE FEDERAL DE S\~{A}O CARLOS \\
        CENTRO DE CI\^{E}NCIAS EXATAS E TECNOLOGIA \\
        \@progresp
     \end{center}
   \end{minipage}
   \hfill
   $\vcenter{\hbox{\includegraphics[width=\@logosize\textwidth]{\@logoprog}}}$
   \par
   \vskip 0.2\textheight
   {\MakeUppercase{\@autoria} \par}
   \vfill
   {\MakeTextUppercase{\@titulo} \par}
   \vfill
   {S\~{A}O CARLOS \par}
   \@ano
  \null
  \end{singlespace} \newpage
}

% Folha de rosto
\newcommand\folhaderosto{%
   \if@openright\cleardoublepage\else\clearpage\fi
   \ps@empty
   \begin{singlespace}
   \parindent \z@ \centering 
   {\MakeUppercase{\@autoria} \par}
   \vfill
   {\MakeTextUppercase{\@titulo} \par}
   \vfill
   {\parindent \z@ \flushright \@objetivo \par}
   {\parindent \z@ \flushright \@orientacao \par}
   \vfill
   {\parindent \z@ \centering S\~{A}O CARLOS \par} 
   {\@ano}
   \null
  \end{singlespace} \newpage
}


% Incluir PDF: Ficha catalográfica e Folha de Aprovação
\RequirePackage{pdfpages}

% Abertura do capítulo
\def\@chapapp{}
\def\@alinhar{\raggedright}
\def\@espaco{\space}
\def\@makechapterhead#1{%
  {\parindent \z@ \@alinhar
  {\normalfont\large\bfseries\MakeTextUppercase{\@chapapp}\space\thechapter\@espaco\space
  \interlinepenalty\@M
  \MakeTextUppercase{#1}}\par\nobreak
  \vskip \baselineskip}
}

\def\@makeschapterhead#1{% 
  {\parindent \z@
  {\hfill\normalfont\large\bfseries\MakeTextUppercase{#1}\hfill\null}\par\nobreak
  \vskip \baselineskip}
}

\renewcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi
                    \pagestyle{fancy}%
                    \global\@topnum\z@
                    \@afterindenttrue
                    \secdef\@chapter\@schapter}
                    
\renewcommand{\section}{\@startsection{section}{1}{\z@}%
             {\baselineskip}%
             {\baselineskip}%
             {\normalfont\large\MakeTextUppercase}}

\renewcommand{\subsection}{\@startsection{subsection}{2}{\z@}%
             {\baselineskip}%
             {\baselineskip}%
             {\normalfont\bfseries}}

\renewcommand{\subsubsection}{\@startsection{subsubsection}{2}{\z@}%
             {\baselineskip}%
             {\baselineskip}%
             {\normalfont}}

% Numera as subsubseções
\setcounter{secnumdepth}{3}

% Sumário/Lista de Figuras/Lista de Tabelas

% Adiciona as subsubseções no Sumário
\setcounter{tocdepth}{3}

\RequirePackage{tocloft}

% Sumário
\renewcommand{\cfttoctitlefont}{\hfill\large\bfseries\MakeUppercase}
\renewcommand{\cftaftertoctitle}{\hfill\null}
\setlength{\cftbeforetoctitleskip}{-\baselineskip}
\setlength{\cftaftertoctitleskip}{\baselineskip}

% Lista de figuras
\renewcommand{\cftloftitlefont}{\hfill\large\bfseries\MakeUppercase}
\renewcommand{\cftafterloftitle}{\hfill\null}
\setlength{\cftbeforeloftitleskip}{-\baselineskip}
\setlength{\cftafterloftitleskip}{\baselineskip}

% Lista de tabelas
\renewcommand{\cftlottitlefont}{\hfill\large\bfseries\MakeUppercase}
\renewcommand{\cftafterlottitle}{\hfill\null}
\setlength{\cftbeforelottitleskip}{-\baselineskip}
\setlength{\cftafterlottitleskip}{\baselineskip}

\tocloftpagestyle{empty}

% Formatação de capítulos e seções
\renewcommand{\cftchapfont}{\large\bfseries}
\patchcmd{\l@chapter}{#1}{\MakeTextUppercase #1}{}{}
\renewcommand\cftchappagefont{\large}

\renewcommand{\cftsecfont}{\large}
\patchcmd{\l@section}{#1}{\MakeTextUppercase #1}{}{}
\renewcommand\cftsecpagefont{\large}

\setlength{\cftsecindent}{0pt}

\renewcommand{\cftsubsecfont}{\normalsize\bfseries}
\setlength{\cftsubsecindent}{0pt}

\renewcommand{\cftsubsubsecfont}{\normalsize}
\setlength{\cftsubsubsecindent}{0pt}

\newlength{\sizenumber}
\settowidth{\sizenumber}{MMM}

\setlength{\cftchapnumwidth}{\sizenumber}
\setlength{\cftsecnumwidth}{\sizenumber}
\setlength{\cftsubsecnumwidth}{\sizenumber}
\setlength{\cftsubsubsecnumwidth}{\sizenumber}

% Remove os pontos no Sumário/Lista
\renewcommand{\cftdot}{} 

\setlength{\cftfigindent}{0pt} 
\renewcommand{\cftfigpresnum}{Figura }
\renewcommand{\cftfigaftersnum}{\enspace -- \enspace}
\addtolength{\cftfignumwidth}{3.8em}

\setlength{\cfttabindent}{0pt} 
\renewcommand{\cfttabpresnum}{Tabela }
\renewcommand{\cfttabaftersnum}{\enspace -- \enspace}
\addtolength{\cfttabnumwidth}{3.8em}

% Texto matemático

% Equações alinhamento à esquerda
\RequirePackage[fleqn]{amsmath}
\setlength{\mathindent}{1.2cm}

% Pacote de fontes e símbolos da AMS
\RequirePackage{amsfonts}
\RequirePackage{amssymb}

% Inserir em todos os ambientes matemáticos o comando \displaystyle
\everymath{\displaystyle}

% Referência numérica de uma equação estará entre parêntesis.
\RequirePackage{varioref}
\labelformat{equation}{(#1)}

% Redefine funções matemáticas em português
\def\sin{\mathop{\operator@font sen}\nolimits}
\def\sinh{\mathop{\operator@font senh}\nolimits}
\def\arcsinh{\mathop{\operator@font arcsenh}\nolimits}
\def\card{\mathop{\operator@font card}\nolimits}
\def\gcd{\mathop{\operator@font mdc}\nolimits}

% Definições/teoremas/corolários/propriedades/exemplos
\RequirePackage{amsthm}
\def\proofname{Demonstraç\~{a}o}
\theoremstyle{plain}% default
\newtheorem{teorema}{Teorema}[chapter]
\newtheorem{lema}{Lema}[chapter]
\newtheorem{proposicao}{Proposi\c{c}\~{a}o}[chapter]
\newtheorem{corolario}{Corol\'{a}rio}[chapter]
\theoremstyle{definition}
\newtheorem{definicao}{Defini\c{c}\~{a}o}[chapter]
\newtheorem{conjectura}{Conjectura}[chapter]
\newtheorem{exemplo}{Exemplo}[chapter]

% Elementos pré-textuais

% Ambiente para a dedicatória
\newenvironment{dedicatoria}{\dedinicio}{\newpage}
\def\dedinicio{%
      \if@openright\cleardoublepage\else\clearpage\fi
      \ps@empty
      \null\vfill
      \@beginparpenalty\@lowpenalty
      \raggedleft\normalfont\sl\@endparpenalty\@M}

% Ambiente para os agradecimentos
\newenvironment{agradecimentos}{\agradinicio}{\newpage}
\def\agradinicio{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \ps@empty
  {\parindent \z@ \centering 
  \normalfont\large\bfseries AGRADECIMENTOS \par}
  \vskip \baselineskip
  \normalfont}

% Ambiente para a epígrafe
\newenvironment{epigrafe}{\epinicio}{\newpage}
\def\epinicio{%
      \if@openright\cleardoublepage\else\clearpage\fi
      \ps@empty
      \null\vfill
      \raggedleft\normalfont\sl}

% Ambiente para o Resumo/Abstract
\def\palavrachaveI#1#2{\pcI{#1} \ecI{#2}}
\def\pcI#1{\gdef\@pcI{#1}}
\global\let\@pcI\@empty
\def\ecI#1{\gdef\@ecI{#1}}
\global\let\@ecI\@empty

\def\palavrachaveII#1#2{\pcII{#1} \ecII{#2}}
\def\pcII#1{\gdef\@pcII{#1}}
\global\let\@pcII\@empty
\def\ecII#1{\gdef\@ecII{#1}}
\global\let\@ecII\@empty

\def\palavrachaveIII#1#2{\pcIII{#1} \ecIII{#2}}
\def\pcIII#1{\gdef\@pcIII{#1}}
\global\let\@pcIII\@empty
\def\ecIII#1{\gdef\@ecIII{#1}}
\global\let\@ecIII\@empty

\def\palavrachaveIV#1#2{\pcIV{#1} \ecIV{#2}}
\def\pcIV#1{\gdef\@pcIV{#1}}
\global\let\@pcIV\@empty
\def\ecIV#1{\gdef\@ecIV{#1}}
\global\let\@ecIV\@empty

\def\palavrachaveV#1#2{\pcV{#1} \ecV{#2}}
\def\pcV#1{\gdef\@pcV{#1}}
\global\let\@pcV\@empty
\def\ecV#1{\gdef\@ecV{#1}}
\global\let\@ecV\@empty

% Página do resumo/palavras-chave
\newenvironment{resumo}{\resumoinicio}{\resumofim}
\def\resumoinicio{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \ps@empty
  {\parindent \z@ \centering
  \normalfont\large\bfseries RESUMO \par}
  \vskip \baselineskip
  \normalfont
}

\def\resumofim{\null\vskip \baselineskip \par\noindent
 \ifx \@pcI\@empty \null
      \else
   \ifx \@pcII\@empty {\bf Palavra-chave:} \@pcI.
        \else
     \ifx \@pcIII\@empty {\bf Palavras-chave:} \@pcI. \@pcII.
          \else
       \ifx \@pcIV\@empty {\bf Palavras-chave:} \@pcI. \@pcII. \@pcIII.
            \else
         \ifx \@pcV\@empty {\bf Palavras-chave:} \@pcI. \@pcII. \@pcIII. \@pcIV.
              \else {\bf Palavras-chave:} \@pcI. \@pcII. \@pcIII. \@pcIV. \@pcV.
         \fi
       \fi
     \fi
   \fi
 \fi \newpage
}

% Comando para o abstract/key-words
\renewenvironment{abstract}{\absinicio}{\absfim}
\def\absinicio{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \ps@empty
  {\parindent \z@ \centering
  \normalfont\large\bfseries ABSTRACT \par}
  \vskip \baselineskip
  \normalfont
}

\def\absfim{\null\vskip \baselineskip \par\noindent
 \ifx \@ecI\@empty \null
      \else
   \ifx \@ecII\@empty {\bf Keyword:} \@ecI.
        \else
     \ifx \@ecIII\@empty {\bf Keywords:} \@ecI. \@ecII.
          \else
       \ifx \@ecIV\@empty {\bf Keywords:} \@ecI. \@ecII. \@ecIII.
            \else
         \ifx \@ecV\@empty {\bf Keywords:} \@ecI. \@ecII. \@ecIII. \@ecIV.
              \else {\bf Keywords:} \@ecI. \@ecII. \@ecIII. \@ecIV. \@ecV.
         \fi
       \fi
     \fi
   \fi
 \fi \newpage
}

% Formatação do Índice remissivo
% imakeidx deve ser carregado antes de hyperref
\RequirePackage{imakeidx}
\makeindex[columns=1,intoc=true,title=\'{I}NDICE REMISSIVO]
\indexsetup{firstpagestyle=fancy}

% Configurações de aparência do PDF final
\RequirePackage[linktocpage=true]{hyperref}

% Alterando a cor azul
\RequirePackage{color}
\definecolor{blue}{RGB}{40,5,195}

% Informações do PDF
\hypersetup{%
		colorlinks=true,       	% false: boxed links; true: colored links
      	linkcolor=blue,        	% color of internal links
     	citecolor=blue,        	% color of links to bibliography
     	filecolor=magenta,     % color of file links
		urlcolor=blue,
		bookmarksdepth=4,
		pdfauthor={Name}
}

% Referências (citações segundo a ABNT)
\RequirePackage[brazilian,hyperpageref]{backref}	   % Páginas com as citações
\RequirePackage[alf,abnt-emphasize=bf]{abntex2cite}  % Citações padrão ABNT
\addto\captionsbrazil{\renewcommand{\bibname}{\centerline{REFER\^{E}NCIAS}}}

% Configurações do pacote backref
% Usado sem a opção hyperpageref de backref
\renewcommand{\backrefpagesname}{Citado na(s) página(s):~}
% Texto padrão antes do número das páginas
\renewcommand{\backref}{}
% Define os textos da citação
\renewcommand*{\backrefalt}[4]{
	\ifcase #1 %
		Nenhuma citação no texto.%
	\or
		Citado na página #2.%
	\else
		Citado #1 vezes nas páginas #2.%
	\fi}%

% Formatação do Apêndice
\RequirePackage[titletoc]{appendix}
\let\oriAlph\Alph
\let\orialph\alph
\renewcommand{\@resets@pp}{\par
  \@ppsavesec
  \stepcounter{@pps}
  \setcounter{section}{0}%
  \addtocontents{toc}{\protect\setcounter{tocdepth}{0}}
  \if@chapter@pp
    \setcounter{chapter}{0}%
    \renewcommand\@chapapp{\appendixname}%
    \def\@alinhar{\centering}
    \def\@espaco{\space -- \space}
    \renewcommand\thechapter{\@Alph\c@chapter \space}%
  \else
    \setcounter{subsection}{0}%
    \renewcommand\thesection{\@Alph\c@section}%
  \fi
  \if@pphyper
    \if@chapter@pp
      \renewcommand{\theHchapter}{\theH@pps.\oriAlph{chapter}}%
    \else
      \renewcommand{\theHsection}{\theH@pps.\oriAlph{section}}%
    \fi
    \def\Hy@chapapp{appendix}%
  \fi
  \restoreapp
}

% Licença Creative Commons - Repositório UFSCar
\RequirePackage[framemethod=tikz]{mdframed}
\definecolor{cccolor}{rgb}{.67,.7,.67}

\newcommand{\licenca}{
  \if@openright\cleardoublepage\else\clearpage\fi
  \ps@empty
  \parindent \z@ 
  \null \vfill \par
  \begin{mdframed}[outerlinecolor=black,
                   outerlinewidth=2pt,
                   linecolor=cccolor,
                   middlelinewidth=3pt,
                   roundcorner=10pt]
  \centering Exceto quando indicado o contrário, a licença deste item é descrito como \\ Attribution-NonCommercial-NoDerivs 3.0 Brazil
  \begin{center}
    \includegraphics[scale=1.3]{./arquivosdmtex/by-nc-nd}
  \end{center}
\end{mdframed}
\null
}
