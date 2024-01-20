{smcl}
{* *! version 1.1.3  11feb2011}{...}
{viewerdialog "irf set" "dialog irf_set"}{...}
{vieweralsosee "[TS] irf set" "mansection TS irfset"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] irf" "help irf"}{...}
{vieweralsosee "[TS] var intro" "help var_intro"}{...}
{vieweralsosee "[TS] vec intro" "help vec_intro"}{...}
{viewerjumpto "Syntax" "irf_set##syntax"}{...}
{viewerjumpto "Description" "irf_set##description"}{...}
{viewerjumpto "Options" "irf_set##options"}{...}
{viewerjumpto "Examples" "irf_set##examples"}{...}
{viewerjumpto "Saved results" "irf_set##saved_results"}{...}
{title:Title}

{p2colset 5 21 23 2}{...}
{p2col:{manlink TS irf set} {hline 2}}Set the active IRF file{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{pstd}Report identity of active file

{p 8 24 2}
{cmd:irf} {opt set}


{pstd}Set, and if necessary create, active file

{p 8 24 2}
{cmd:irf} {opt set} {it:irf_filename}


{pstd}Create, and if necessary replace, active file

{p 8 24 2}
{cmd:irf} {opt set} {it:irf_filename}{cmd:,} {opt replace}


{pstd}Clear any active IRF file

{p 8 24 2}
{cmd:irf} {opt set}{cmd:,} {opt clear}


{title:Menu}

{phang}
{bf:Statistics > Multivariate time series > Manage IRF results and files >}
    {bf:Set active IRF file}


{marker description}{...}
{title:Description}

{pstd}
In the first syntax, {opt irf set} reports the identity of the active
file, if there is one.  Also see {manhelp irf_describe TS:irf describe} for
obtaining reports on the contents of an IRF file.

{pstd}
In the second syntax, {opt irf set} {it:irf_filename} specifies that the
file be set as the active file and, if the file does not exist, that it be
created as well.

{pstd}
In the third syntax, {opt irf set} {it:irf_filename}{cmd:,}
{opt replace} specifies that even if file {it:irf_filename} exists, a new,
empty file is to be created and set.

{pstd}
In the rarely used fourth syntax, {opt irf set}{cmd:,} {opt clear}
specifies that, if any IRF file is set, it be unset and that there be no
active IRF file.

{pstd}
IRF files are just files: they can be erased by {cmd:erase}, listed by
{cmd:dir}, and copied by {cmd:copy}; see {helpb erase:[D] erase},
{helpb dir:[D] dir}, and {helpb copy:[D] copy}.

{pstd}
If {it:irf_filename} is specified without an extension, {opt .irf} is assumed.


{marker options}{...}
{title:Options}

{phang}
{opt replace} specifies that if {it:irf_filename} already exists, the file is
to be erased and a new, empty IRF file is to be created in its place.  If it
does not already exist, a new, empty file is created.

{phang}
{opt clear} unsets the active IRF file.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse lutkepohl2}{p_end}

{pstd}Fit vector autoregressive model{p_end}
{phang2}{cmd:. var dln_inc dln_consump, exog(l.dln_inv)}

{pstd}Create {cmd:results2.irf} and make it the active IRF file{p_end}
{phang2}{cmd:. irf set results2}{p_end}

{pstd}Identify name of active file{p_end}
{phang2}{cmd:. irf set}

{pstd}Save estimated IRFs and FEVDs under {cmd:order1} in {cmd:results2.irf}
{p_end}
{phang2}{cmd:. irf create order1}{p_end}

{pstd}Erase existing {cmd:results2.irf} file and create a new, empty
{cmd:results2.irf} file{p_end}
{phang2}{cmd:. irf set results2, replace}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:irf set} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:r(irffile)}}name of active IRF file, if there is an active
IRF{p_end}
{p2colreset}{...}
