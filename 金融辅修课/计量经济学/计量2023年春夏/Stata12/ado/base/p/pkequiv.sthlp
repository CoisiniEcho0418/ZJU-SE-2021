{smcl}
{* *! version 1.1.5  11feb2011}{...}
{viewerdialog pkequiv "dialog pkequiv"}{...}
{vieweralsosee "[R] pkequiv" "mansection R pkequiv"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] pk" "help pk"}{...}
{viewerjumpto "Syntax" "pkequiv##syntax"}{...}
{viewerjumpto "Description" "pkequiv##description"}{...}
{viewerjumpto "Options" "pkequiv##options"}{...}
{viewerjumpto "Remarks" "pkequiv##remarks"}{...}
{viewerjumpto "Examples" "pkequiv##examples"}{...}
{viewerjumpto "Saved results" "pkequiv##saved_results"}{...}
{viewerjumpto "Reference" "pkequiv##reference"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col :{manlink R pkequiv} {hline 2}}Perform bioequivalence tests{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmd:pkequiv} {it:outcome treatment period sequence id} {ifin} [{cmd:,}
{it:options}]

{synoptset 19 tabbed}{...}
{synopthdr}
{synoptline}
{syntab :Options}
{synopt :{opth com:pare(strings:string)}}compare the two specified values of the
treatment variable{p_end}
{synopt :{opt li:mit(#)}}equivalence limit (between 0.10 and 0.99); default is
0.2{p_end}
{synopt :{opt le:vel(#)}}set confidence level; default is
{cmd:level(90)}{p_end}
{synopt :{opt fie:ller}}calculate confidence interval by Fieller's theorem{p_end}
{synopt :{opt sym:metric}}calculate symmetric equivalence interval{p_end}
{synopt :{opt ander:son}}Anderson and Hauck hypothesis test for
bioequivalence{p_end}
{synopt :{opt tost}}two one-sided hypothesis tests for bioequivalence{p_end}
{synopt :{opt nob:oot}}do not estimate probability that CI lies within
confidence limits{p_end}
{synoptline}
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Statistics > Epidemiology and related > Other > Bioequivalence tests}


{marker description}{...}
{title:Description}

{pstd}
{cmd:pkequiv} performs bioequivalence testing for two treatments.  By
default, {cmd:pkequiv} calculates a standard confidence interval symmetric
about the difference between the two treatment means.  {cmd:pkequiv} also
calculates confidence intervals symmetric about zero and intervals based on
Fieller's theorem.  Also, {cmd:pkequiv} can perform interval
hypothesis tests for bioequivalence.

{pstd}
{cmd:pkequiv} is one of the pk commands.  Please read {helpb pk} before reading
this entry.


{marker options}{...}
{title:Options}

{dlgtab:Options}

{phang}
{opth compare:(strings:string)} specifies the two treatments to be tested for
equivalence.  Sometimes there may be more than two treatments, but the
equivalence can be determined only between any two treatments.

{phang}
{opt limit(#)} specifies the equivalence limit.  The default is 0.2.  The
equivalence limit can be changed only symmetrically; that is, it is not
possible to have a 0.15 lower limit and a 0.2 upper limit in the same test.

{phang}
{opt level(#)} specifies the confidence level, as a percentage, for confidence
intervals.  The default is {cmd:level(90)}.  This setting is not controlled
by the {cmd:set level} command.

{phang}
{opt fieller} specifies that an equivalence interval based on Fieller's
theorem be calculated.

{phang}
{opt symmetric} specifies that a symmetric equivalence interval be calculated.

{phang}
{opt anderson} specifies that the
{help pkequiv##AH1983:Anderson and Hauck (1983)} hypothesis test for
bioequivalence be computed.  This option is ignored when calculating
equivalence intervals based on Fieller's theorem or when calculating a
confidence interval that is symmetric about zero.

{phang}
{opt tost} specifies that the two one-sided hypothesis tests for
bioequivalence be computed.  This option is ignored when calculating
equivalence intervals based on Fieller's theorem or when calculating a
confidence interval that is symmetric about zero.

{phang}
{opt noboot} prevents the estimation of the probability that the confidence
interval lies within the confidence limits.  If this option is not specified,
this probability is estimated by resampling the data.


{marker remarks}{...}
{title:Remarks}

{pstd}
{cmd:pkequiv} is designed to conduct tests for bioequivalence on the basis of
data from a crossover experiment.  {cmd:pkequiv} requires that the user
specify the {it:outcome}, {it:treatment}, {it:period}, {it:sequence}, and
{it:id} variables.  The data must be in the same format as produced by
{helpb pkshape}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse pkdata3}{p_end}

{pstd}Calculate bioequivalence test{p_end}
{phang2}{cmd:. pkequiv outcome treat period seq id}{p_end}

{phang}Calculate symmetric equivalence interval{p_end}
{phang2}{cmd:. pkequiv outcome treat period seq id, symmetric}{p_end}

{phang}Calculate Schuirmann's two one-sided tests{p_end}
{phang2}{cmd:. pkequiv outcome treat period seq id, tost}

{phang}Calculate Anderson and Hauck test{p_end}
{phang2}{cmd:. pkequiv outcome treat period seq id, anderson}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:pkequiv} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(stddev)}}pooled-sample standard deviation of period differences
from both sequences{p_end}
{synopt:{cmd:r(uci)}}upper confidence interval for a classic interval{p_end}
{synopt:{cmd:r(lci)}}lower confidence interval for a classic interval{p_end}
{synopt:{cmd:r(delta)}}delta value used in calculating a symmetric confidence
interval{p_end}
{synopt:{cmd:r(u3)}}upper confidence interval for Fieller's confidence
interval{p_end}
{synopt:{cmd:r(l3)}}lower confidence interval for Fieller's confidence
interval{p_end}
{p2colreset}{...}


{marker reference}{...}
{title:Reference}

{marker AH1983}{...}
{phang}
Anderson, S., and W. W. Hauck. 1983. A new procedure for testing equivalence
in comparative bioavailability and other clinical trials.
{it:Communications in Statistics, Theory and Methods} 12: 2663-2692.
{p_end}
