{smcl}
{* *! version 1.1.4  11feb2011}{...}
{vieweralsosee "[M-5] crossdev()" "mansection M-5 crossdev()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-5] cross()" "help mf_cross"}{...}
{vieweralsosee "[M-5] quadcross()" "help mf_quadcross"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] statistical" "help m4_statistical"}{...}
{vieweralsosee "[M-4] utility" "help m4_utility"}{...}
{viewerjumpto "Syntax" "mf_crossdev##syntax"}{...}
{viewerjumpto "Description" "mf_crossdev##description"}{...}
{viewerjumpto "Remarks" "mf_crossdev##remarks"}{...}
{viewerjumpto "Conformability" "mf_crossdev##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_crossdev##diagnostics"}{...}
{viewerjumpto "Source code" "mf_crossdev##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 crossdev()} {hline 2} Deviation cross products


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real matrix}
{cmd:crossdev(}{it:X}{cmd:,}
{it:x}{cmd:,}
{it:Z}{cmd:,}
{it:z}{cmd:)}

{p 8 12 2}
{it:real matrix}
{cmd:crossdev(}{it:X}{cmd:,}
{it:x}{cmd:,}
{it:w}{cmd:,}
{it:Z}{cmd:,}
{it:z}{cmd:)}

{p 8 12 2}
{it:real matrix}
{cmd:crossdev(}{it:X}{cmd:,}
{it:xc}{cmd:,}
{it:x}{cmd:,}
{it:Z}{cmd:,}
{it:zc}{cmd:,}
{it:z}{cmd:)}

{p 8 12 2}
{it:real matrix}
{cmd:crossdev(}{it:X}{cmd:,}
{it:xc}{cmd:,}
{it:x}{cmd:,}
{it:w}{cmd:,}
{it:Z}{cmd:,}
{it:zc}{cmd:,}
{it:z}{cmd:)}


{p 4 8 2}
where

	             {it:X}:  {it:real matrix X}
	            {it:xc}:  {it:real scalar xc}
	             {it:x}:  {it:real rowvector x}

	             {it:w}:  {it:real vector w}

	             {it:Z}:  {it:real matrix Z}
	            {it:zc}:  {it:real scalar zc}
	             {it:z}:  {it:real rowvector z}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:crossdev()} makes calculations of the form 

		({it:X}:-{it:x})'({it:X}:-{it:x})

		({it:X}:-{it:x})'({it:Z}:-{it:z})

		({it:X}:-{it:x})'diag({it:w})({it:X}:-{it:x})

		({it:X}:-{it:x})'diag({it:w})({it:Z}:-{it:z})

{p 4 4 2}
{cmd:crossdev()} is a variation on 
{bf:{help mf_cross:[M-5] cross()}}.
{cmd:crossdev()}
mirrors {cmd:cross()} in every respect except that it has two 
additional arguments:  {it:x} and {it:z}.
{it:x} and {it:z} record the amount by which {it:X} and {it:Z} are to be
deviated.  {it:x} and {it:z} usually contain the (appropriately
weighted) column means of {it:X} and {it:Z}.



{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
{it:x} usually contains the same number of rows as {it:X} but, if 
{it:xc}!=0, {it:x} may contain an extra element on the right 
recording the amount from which the constant 1 should be deviated.

{p 4 4 2}
The same applies to {it:z}:  it usually contains the same number of rows 
as {it:Z} but, if {it:zc}!=0, {it:z} may contain an extra element on the 
right.


    {title:Example 1:  Linear regression using one view}

	{cmd}: M = .
	: st_view(M, ., "mpg weight foreign", 0)
	:
	: means = mean(M, 1)
	: CP = crossdev(M,means , M,means)
	: xx = CP[|2,2 \ .,.|]
	: xy = CP[|2,1 \ .,1|]
	: b  = invsym(xx)*xy
	: b  = b \ means[1]-means[|2\.|]*b{txt}

{p 4 4 2}
Compare this solution with {help mf_cross##example3:example 3} in 
{bf:{help mf_cross:[M-5] cross()}}.


    {title:Example 2:  Linear regression using subviews}

	{cmd}: M = X = y = .
	: st_view(M, ., "mpg weight foreign", 0)
	: st_subview(y, M, ., 1)
	: st_subview(X, M, ., (2\.))
	:
	: xmean = mean(X, 1)
	: ymean = mean(y, 1)
	: xx    = crossdev(X,xmean , X,xmean)
	: xy    = crossdev(X,xmean , y,ymean)
	: b     = invsym(xx)*xy
	: b     = b \ ymean-xmean*b{txt}

{p 4 4 2}
Compare this solution with {help mf_cross##example4:example 4} in 
{bf:{help mf_cross:[M-5] cross()}}.


    {title:Example 3:  Weighted linear regression}

	{cmd}: M = X = y = w = .
	: st_view(M, ., "w mpg weight foreign", 0)
	: st_subview(w, M, ., 1)
	: st_subview(y, M, ., 2)
	: st_subview(X, M, ., (3\.))
	:
	: xmean = mean(X, w)
	: ymean = mean(y, w)
	: xx    = crossdev(X,xmean, w, X,xmean)
	: xy    = crossdev(X,xmean, w, y,ymean)
	: b     = invsym(xx)*xy
	: b     = b \ ymean-xmean*b{txt}

{p 4 4 2}
Compare this solution with {help mf_cross##example6:example 6} in 
{bf:{help mf_cross:[M-5] cross()}}.


    {title:Example 4:  Variance matrix}

	{cmd}: X = .
	: st_view(X, ., "mpg weight displ", 0)
	:
	: n     = rows(X)
	: means = mean(X, 1)
	: xx    = crossdev(X,means , X,means)
	: cov   = xx:/(n-1){txt}

{p 4 4 2}
This is exactly what {cmd:variance()} does; see 
{bf:{help mf_mean:[M-5] mean()}}.
Compare this solution with {help mf_cross##example12:example 12} in 
{bf:{help mf_cross:[M-5] cross()}}.


    {title:Example 5:  Weighted variance matrix}

	{cmd}: M = w = X = .
	: st_view(M, ., "w mpg weight displ", 0)
	: st_subview(w, M, ., 1)
	: st_subview(X, M, ., (2\.))
	:
	: n     = colsum(w)
	: means = mean(X, w)
	: cov   = crossdev(X,means, w, X,means) :/ (n-1){txt}

{p 4 4 2}
This is exactly what {cmd:variance()} does with weighted data; see 
{bf:{help mf_mean:[M-5] mean()}}.
Compare this solution with {help mf_cross##example14:example 14} in 
{bf:{help mf_cross:[M-5] cross()}}.


{marker conformability}{...}
{title:Conformability}

{p 4 8 2}
{cmd:crossdev(}{it:X}{cmd:,}
{it:xc}{cmd:,}
{it:x}{cmd:,}
{it:w}{cmd:,}
{it:Z}{cmd:,}
{it:zc}{cmd:,}
{it:z}{cmd:)}:
{p_end}
		{it:X}:  {it:n x v1} or 1 {it:x} 1, 1 {it:x} 1 treated as if {it:n x} 1
	       {it:xc}:  1 {it:x} 1                        (optional)
		{it:x}:  1 {it:x v1} or 1 {it:x} {it:v1}+({it:xc}!=0)
		{it:w}:  {it:n x} 1 or 1 {it:x n} or 1 {it:x} 1      (optional)
		{it:Z}:  {it:n x v2}
	       {it:zc}:  1 {it:x} 1                        (optional)
		{it:z}:  1 {it:x v2} or 1 {it:x} {it:v2}+({it:zc}!=0)
	   {it:result}:  ({it:v1}+({it:xc}!=0)) {it:x} ({it:v2}+({it:zc}!=0))


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:crossdev(}{it:X}{cmd:,}
{it:xc}{cmd:,}
{it:x}{cmd:,}
{it:w}{cmd:,}
{it:Z}{cmd:,}
{it:zc}{cmd:,}
{it:z}{cmd:)}
omits rows in {it:X} and {it:Z} that contain missing values.


{marker source}{...}
{title:Source code}

{p 4 4 2}
Function is built in.
{p_end}
