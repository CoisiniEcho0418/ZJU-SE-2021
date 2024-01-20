{smcl}
{* *! version 1.2.2  11feb2011}{...}
{vieweralsosee "[R] meta" "mansection R meta"}{...}
{viewerjumpto "Remarks" "meta##remarks"}{...}
{viewerjumpto "References" "meta##references"}{...}
{title:Title}

{p2colset 5 17 19 2}{...}
{p2col:{manlink R meta} {hline 2}}Meta-analysis{p_end}
{p2colreset}{...}


{marker remarks}{...}
{title:Remarks}

{pstd}
Stata does not have a meta-analysis command.  Stata users, however, have
developed an excellent suite of commands for performing meta-analysis,
including commands for performing standard and cumulative meta-analysis,
commands for producing forest plots and contour-enhanced funnel plots,
and commands for nonparametric analysis of publication bias.

{pstd}
Many articles describing these commands have been published in the
{it:Stata Technical Bulletin} and the {it:Stata Journal}.
These articles were updated and published in a cohesive collection:
{it:Meta-Analysis in Stata: An Updated Collection from the Stata Journal}.

{pstd}
In this collection, editor Jonathan Sterne discusses how
these articles relate to each other and how they fit in the overall literature
of meta-analysis.  Sterne has organized the collection into four areas: classic
meta-analysis; meta-regression; graphical and analytic tools for detecting
bias; and recent advances such as meta-analysis for dose-response
curves, diagnostic accuracy, multivariate analysis, and studies containing
missing values.

{pstd}
All meta-analysis commands discussed in this collection may be downloaded
by visiting {browse "http://www.stata-press.com/books/mais.html"}.

{pstd}
We highly recommend that Stata users interested in meta-analysis read
this book.  Since the publication of the meta-analysis collection,
{help meta##KR2010:Kontopantelis and Reeves (2010)} published an article in the
Stata Journal describing a new command {cmd:metaan} that performs fixed- or
random-effects meta-analysis.

{pstd}
Please also see the following FAQ on the Stata website:

        What meta-analysis features are available in Stata?
        {browse "http://www.stata.com/support/faqs/stat/meta.html"}


{marker references}{...}
{title:References}

{marker KR2010}{...}
{phang}
Kontopantelis, E., and D. Reeves. 2010. metaan: Random-effects meta-analysis.
{browse "http://www.stata-journal.com/article.html?article=st0201":{it:Stata Journal} 10: 395-407}.

{phang}
Sterne, J. A. C. 2009.
{browse "http://www.stata.com/bookstore/mais.html":{it:Meta-Analysis in Stata: An Updated Collection from the Stata Journal}.}
College Station, TX: Stata Press.
{p_end}
