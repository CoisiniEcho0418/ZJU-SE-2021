{smcl}
{* *! version 1.2.4  05aug2011}{...}
{vieweralsosee "[R] sj" "mansection R sj"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] net" "help net"}{...}
{vieweralsosee "[R] net search" "help net_search"}{...}
{vieweralsosee "[R] search" "help search"}{...}
{vieweralsosee "stb" "help stb"}{...}
{vieweralsosee "[R] update" "help update"}{...}
{vieweralsosee "whatsnew" "help whatsnew"}{...}
{vieweralsosee "[U] 3.4 The Stata listserver" "help statalist"}{...}
{viewerjumpto "Description" "sj##description"}{...}
{viewerjumpto "Obtaining user-written additions from the SJ" "sj##software"}{...}
{viewerjumpto "Subscribing to the SJ" "sj##subscribe"}{...}
{title:Title}

{p2colset 5 15 17 2}{...}
{p2col:{manlink R sj} {hline 2}}Stata Journal installation instructions{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The {bf:Stata Journal} (SJ) is a quarterly journal containing articles about
statistics, data analysis, teaching methods, and effective use of Stata's
language.  The SJ publishes reviewed papers together with shorter notes
and comments, regular columns, book reviews, and other material of interest to
researchers applying statistics in a variety of disciplines.  You can read all
about the Stata Journal at {browse "http://www.stata-journal.com"}.

{pstd}
The Stata Journal is a printed and electronic journal with corresponding
software.  If you want the journal, you must subscribe, but the software is
available for no charge from our website at
{browse "http://www.stata-journal.com"}.  PDF copies of SJ articles that are
older than three years are available for download for no charge at
{browse "http://www.stata-journal.com/archives.html"}.
More recent articles may be individually purchased.


{pstd}
As an example, the table of contents for the Stata Journal, Volume 9, 
{bind:Number 9}, is

{center:{hline 73}}
{center:{bf:Articles and Columns} {space 48} 505}

{center:A menu-driven facility for sample-size calculation in novel{space 11}}
{center:{space 5}multiarm, multistage randomized controlled trials with a{space 11}}
{center:{space 5}time-to-event outcome . . . . . . . . . . . . . . . . . . . . {space 5}}
{center:{space 5}. . . . . .  F. M.-S. Barthel, P. Royston, and M. K. B. Parmar   505}
{center:cem: Coarsened exact matching in Stata . . . . . . . . . . . . . .{space 5}}
{center:{space 5} . . . . . . . .  M. Blackwell, S. Iacus, G. King, and G. Porro   524}
{center:Bootstrap assessment of the stability of multivariable models . . {space 4}}
{center:{space 5}. . . . . . . . . . . . . . . . .  P. Royston and W. Sauerbrei   547}
{center:Partial effects in probit and logit models with a triple{space 14}}
{center:{space 5}dummy-variable interaction term . . . . . . . . . . . . . . .{space 5} }
{center:{space 5} . . . . . . . . . . . . . . .  T. Cornelissen and K. Sonderhof   571}
{center:Fitting and interpreting Cragg's tobit alternative using Stata. .{space 5}}
{center:{space 5} . . . . . . . . . . . . . . . . . . . . . . . . .  W. J. Burke   584}
{center:Implementation of a new solution to the multivariate {space 17}}
{center:{space 7}Behrens-Fisher problem . . . . . . . . . . . . .  Ivan Zezula   593}
{center:{space 2}Mata Matters: File processing  . . . . . . . . . . . . .  W. Gould   599}
{center:Speaking Stata: Paired, parallel, or profile plots for changes,{space 7}}
{center:{space 5}correlations, and other comparisons  . . . . . . . . N. J. Cox   621}

{center:{bf:Notes and Comments} {space 50} 640}

{center:Stata tip 80: Constructing a group variable with specific{space 14}}
{center:{space 5}group sizes . . . . . . . . . . . . . . . . . . . . . M. Weiss   640}
{center:{space 1}Stata tip 81: A table of graphs  . . . . . M. L. Buis and M. Weiss   643}
{center:{space 1}Stata tip 82: Grounds for grids on graphs  . . . . . . . N. J. Cox   648}

{center:{bf:Software Updates} {space 52} 652}
{center:{hline 73}}

{pstd}
The Stata Journal, Volume 1, Issue 1, began publication in the fourth quarter
of 2001.  The predecessor to the Stata Journal was the Stata Technical Bulletin
(STB); see {help stb}.  The STB began publication in May 1991 and was the
first publication of its kind for statistical software users.

{pstd}
To see the table of contents for the latest SJ (or any SJ), see
{browse "http://www.stata-journal.com/archives.html"}.


{marker software}{...}
{title:Obtaining user-written additions from the SJ}

{pstd}
The SJ user-written additions are easily obtained.
You can {net "from http://www.stata-journal.com/software":click here}

{p 4 15 2}Or {space 4} 1) Select {bf:Help > SJ and User-written Programs}{p_end}
{p 12 15 2}2) Click on Stata Journal{p_end}

{pstd}
Or use the command line and type

	    {inp:. net from http://www.stata-journal.com/software}

{pstd}
See {manhelp net R}.  What to do next will be obvious.


{marker subscribe}{...}
{title:Subscribing to the SJ}

{pstd}
Subscriptions to and back issues of the Stata Journal are available from
StataCorp.

	    StataCorp
	    4905 Lakeway Drive
	    College Station, Texas 77845

	    {browse "http://www.stata.com"}
	    {browse "mailto:stata@stata.com":stata@stata.com}

	    800-782-8272  (800-STATAPC, USA)
	    800-248-8272  (Canada)
	    979-696-4600  (Worldwide)
	    979-696-4601  (Fax)
