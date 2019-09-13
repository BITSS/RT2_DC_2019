texdoc init "${output}/main_doc.tex", replace hardcode nokeep

/***
\documentclass[a4paper]{article}
\usepackage{stata}
\usepackage{graphicx}
\usepackage{adjustbox}
\usepackage{float}

%-----------------------------------------------------------

\begin{document}

\title{Dynamic documents in Stata}
\maketitle

Hello world
***/

texdoc stlog

sysuse auto, clear
sum weight mpg

texdoc stlog close

/***
Now let's do a graph:s
***/


texdoc stlog

scatter weight mpg

texdoc stlog close
texdoc graph


/***
Using \texttt{cmdstrip}:
***/

texdoc stlog, cmdstrip

sum weight mpg
scatter weight mpg

texdoc stlog close
texdoc graph



/***
Using \texttt{nodo}:
***/

texdoc stlog, nodo cmdlog

sum weight mpg
scatter weight mpg

texdoc stlog close

texdoc stlog, nolog

gen weight2 = -weight
scatter weight2 mpg

texdoc stlog close
texdoc graph


/***
Tables"
***/
texdoc stlog, nolog

reg price headroom
est sto reg1

regress price headroom trunk
est sto reg2

regress price headroom trunk foreign
est sto reg3

esttab reg1 reg2 reg3 using "${output}/reg_table.tex", ///
	replace ///
	label se ///
	nomtitles ///
	addnotes("This is a note")


texdoc stlog close

texdoc write \input{reg_table.tex}

/***
\end{document}
***/
