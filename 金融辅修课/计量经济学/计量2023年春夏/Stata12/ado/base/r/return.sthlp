{smcl}
{* *! version 1.1.9  15mar2011}{...}
{viewerdialog "return/ereturn list" "dialog return_list"}{...}
{vieweralsosee "[P] return" "mansection P return"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] ereturn" "help ereturn"}{...}
{vieweralsosee "[P] _return" "help _return"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] creturn" "help creturn"}{...}
{vieweralsosee "[P] _estimates" "help _estimates"}{...}
{vieweralsosee "[R] saved results" "help saved_results"}{...}
{viewerjumpto "Syntax" "return##syntax"}{...}
{viewerjumpto "Description" "return##description"}{...}
{viewerjumpto "Options" "return##options"}{...}
{viewerjumpto "Examples" "return##examples"}{...}
{title:Title}

{p2colset 5 19 21 2}{...}
{p2col :{manlink P return} {hline 2}}Return saved results{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{pstd}Return results for general commands, stored in r()

{p 8 15 2}{cmdab:ret:urn} {cmdab:li:st} [{cmd:,} {cmd:all}]

{p 8 15 2}{cmdab:ret:urn} {cmd:clear}

{p 8 15 2}{cmdab:ret:urn} {cmdab:sca:lar} {it:name} {cmd:=} {it:{help exp}}

{p 8 15 2}{cmdab:ret:urn} {cmdab:loc:al} {it:name} {cmd:=} {it:{help exp}}

{p 8 15 2}{cmdab:ret:urn} {cmdab:loc:al} {it:name} [{cmd:"}]{it:{help strings:string}}[{cmd:"}]

{p 8 15 2}{cmdab:ret:urn} {cmdab:mat:rix} {it:name} [{cmd:=}] {it:matname}
	[{cmd:,} {cmd:copy}]

{p 8 15 2}{cmdab:ret:urn} {cmd:add}


    Return results for estimation commands, stored in e()

{p 8 16 2}{cmdab:eret:urn} {cmdab:li:st} [{cmd:,} {cmd:all}]

{p 8 16 2}{cmdab:eret:urn} {cmd:clear}

{p 8 16 2}{cmdab:eret:urn} {cmd:post} [{it:b} [{it:V} [{it:Cns}]]] {weight}
[{cmd:,} {cmdab:dep:name:(}{it:{help strings:string}}{cmd:)} {cmdab:o:bs:(}{it:#}{cmd:)}
{cmdab:d:of:(}{it:#}{cmd:)} {cmdab:e:sample:(}{varname}{cmd:)}
{opth prop:erties(strings:string)}]

{p 8 16 2}{cmdab:eret:urn} {cmdab:sca:lar} {it:name} {cmd:=} {it:{help exp}}

{p 8 16 2}{cmdab:eret:urn} {cmdab:loc:al} {it:name} {cmd:=} {it:{help exp}}

{p 8 16 2}{cmdab:eret:urn} {cmdab:loc:al} {it:name} [{cmd:"}]{it:{help strings:string}}[{cmd:"}]

{p 8 16 2}{cmdab:eret:urn} {cmdab:mat:rix} {it:name} [{cmd:=}] {it:matname}
	[{cmd:,} {cmd:copy}]

{p 8 16 2}{cmdab:eret:urn} {cmd:repost} [{cmd:b =} {it:b}] [{cmd:V =} {it:V}]
[{cmd:Cns =} {it:Cns}]
{weight} [{cmd:,} {cmdab:e:sample:(}{varname}{cmd:)} {cmdab:ren:ame}
{opth prop:erties(strings:string)}]


{pstd}Return results for parsing commands, stored in s()

{p 8 16 2}{cmdab:sret:urn} {cmdab:li:st}

{p 8 16 2}{cmdab:sret:urn} {cmd:clear}

{p 8 16 2}{cmdab:sret:urn} {cmdab:loc:al} {it:name} {cmd:=} {it:{help exp}}

{p 8 16 2}{cmdab:sret:urn} {cmdab:loc:al} {it:name} [{cmd:"}]{it:{help strings:string}}[{cmd:"}]


{phang}
where {it:b}, {it:V}, and {it:Cns} are {it:matname}s, which is the name of an
existing matrix.

{pstd}
{cmd:fweight}s, {cmd:aweight}s, {cmd:iweight}s, and {cmd:pweight}s are
allowed; see {help weight}.


{marker description}{...}
{title:Description}

{pstd}
Results of calculations are saved by many Stata commands so that they can be
easily accessed and substituted into subsequent commands.  This entry
summarizes for programmers how to save results.  If your interest is in using
previously saved results, see {helpb saved_results:[R] saved results}.

{pstd}
Stata commands -- and new commands that you and others write -- can
be classified as follows:

{p 4 14 2}r-class:{space 2}general commands such as {helpb summarize}.  Results
are returned in {hi:r()} and generally must be used before executing more
commands.

{p 14 14 2}{cmd:return list} lists results stored in {hi:r()}.
{cmd:return local}, {cmd:return scalar}, and {cmd:return matrix} save macros,
scalars, and matrices in {cmd:return()}.  {cmd:return add} adds the current
{hi:r()} values to {cmd:return()}.  {cmd:return clear} clears {cmd:return()}.
{cmd:return()} is local to the program.  At the end of an r-class program,
items in {cmd:return()} are placed in {hi:r()} for final return.

{p 4 14 2}e-class:{space 2}estimation commands such as {helpb regress},
{helpb logistic}, etc., that fit statistical models.  Such estimation
results stay around until the next model is fit.  Results are returned
in {hi:e()}.

{p 14 14 2}{cmd:ereturn list} lists results stored in {hi:e()}.
{cmd:ereturn local}, {cmd:ereturn scalar}, and {cmd:ereturn matrix} save
macros, scalars, and matrices in {hi:e()}.  See {manhelp ereturn P} for
more details and information on the other subcommands.

{p 4 14 2}s-class:  programming commands that assist in parsing.  These commands
are relatively rare.  Results are returned in {hi:s()}.

{p 14 14 2}{cmd:sreturn list} lists results stored in {hi:s()}.
{cmd:sreturn local} saves macros in {hi:s()}.

{p 4 14 2}n-class:  commands that do not save results at all or, more correctly,
do not save "extra" results because where they save what they save is
explicitly specified.  {helpb generate} and {helpb replace} are examples.

{pstd}
There is also a c-class, {hi:c()}, containing the values of system parameters
and settings, along with certain constants, such as the value of pi; see
{manhelp creturn P}.  A program cannot be c-class.


{marker options}{...}
{title:Options}

{phang}
{cmd:all} is for use with {cmd:return list} or {cmd:ereturn list}.  {cmd:all}
specifies that hidden and historical saved results be listed along with the
usual saved results.  This option is seldom used.  See
{mansection P returnRemarksUsinghiddenandhistoricalsavedresults:{it:Using hidden and historical saved results}}
and
{mansection P returnRemarksProgramminghiddenandhistoricalsavedresults:{it:Programming hidden and historical saved results}}
under {it:Remarks} of {bf:[P] return} for more information.  These sections are
written in terms of {cmd:return list}, but everything said there applies
equally to {cmd:ereturn list}.

{pmore}
{cmd:all} is not allowed with {cmd:sreturn list} because {cmd:s()} does not
allow hidden or historical results.

{phang}
{cmd:copy} specified with {cmd:return matrix} or {cmd:ereturn matrix}
indicates that the matrix is to be copied; that is, the original matrix should
be left in place.  The default is to "steal" or "rename" the existing matrix,
which is fast and conserves memory.

{phang}
{cmd:depname(}{it:{help strings:string}}{cmd:)} is for use with
{cmd:ereturn post}.
It supplies the name of the dependent variable to appear in the estimation
output.  The name specified need not be the name of an existing variable.

{phang}
{cmd:obs(}{it:#}{cmd:)} is for use with {cmd:ereturn post}.
It specifies the number of observations on which the estimation was performed.
This number is stored in {hi:e(N)}, and {cmd:obs()} is provided to simply for
convenience.  Results are no different from those for {cmd:ereturn post}
followed by {cmd:ereturn scalar N =} {it:#}.

{phang}
{cmd:dof(}{it:#}{cmd:)} is for use with {cmd:ereturn post}. 
It specifies the number of denominator degrees of freedom to be used with t
and F statistics and so is used in calculating significance levels and
confidence intervals.  The number specified is saved in {hi:e(df_r)}, and
{cmd:dof()} is provided simply for convenience.  Results are no different from
those for {cmd:ereturn} {cmd:post} followed by {cmd:ereturn} {cmd:scalar}
{cmd:df_r} {cmd:=} {it:#}.

{phang}
{opth esample(varname)} is for use with {cmd:ereturn} {cmd:post} and
{cmd:ereturn} {cmd:repost}.  It specifies the name of a 0/1 variable that is
to become the {cmd:e(sample)} function.  {it:varname} must contain 0 and 1
values only, with 1 indicating that the observation is in the estimation
subsample.  {cmd:ereturn} {cmd:post} and {cmd:ereturn} {cmd:repost} will be
able to execute a little more quickly if {it:varname} is stored as a
{cmd:byte} variable.

{pmore}
{it:varname} is dropped from the dataset, or more correctly, it is stolen and
stashed in a secret place.

{phang}
{opth properties:(strings:string)} specified with {cmd:ereturn} {cmd:post} or
{cmd:ereturn} {cmd:repost} sets the {cmd:e(properties)} macro.  By default,
{cmd:e(properties)} is set to {cmd:b V} if {cmd:properties()} is not specified.

{phang}
{cmd:rename} is for use with the {cmd:b} {cmd:=} {it:b} syntax of
{cmd:ereturn} {cmd:repost}.  All numeric estimation results remain unchanged,
but the labels of {it:b} are substituted for the variable and equation names
of the already posted results.


{marker examples}{...}
{title:Examples}

{pstd}The following r-class command demonstrates returning results via
the {cmd:return} command:

	{cmd:program mysum, rclass}
		{cmd:syntax varname}
		{cmd:return local varname `varlist'}
		{cmd:tempvar new}
		{cmd:quietly {c -(}}
			{cmd:count if !missing(`varlist')}
			{cmd:return scalar N = r(N)}
			{cmd:gen double `new' = sum(`varlist')}
			{cmd:return scalar sum = `new'[_N]}
			{cmd:return scalar mean = return(sum)/return(N)}
		{cmd:{c )-}}
	{cmd:end}

{pstd}You can run this program and then list the returned results:

	{cmd:. sysuse auto}
	{cmd:. mysum mpg}
	{cmd:. return list}

	scalars:
	       r(mean)     =  21.2972972972973
	       r(sum)      =  1576
	       r(N)        =  74

	macros:
	       r(varname)  : "mpg"

{pstd}The values {hi:r(mean)}, {hi:r(sum)}, {hi:r(N)}, and {hi:r(varname)}
can now be referred to directly.

	{cmd:. display "The variable is " r(varname) " with mean " r(mean)}
	The variable is mpg with mean 21.297297
