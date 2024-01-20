{smcl}
{* *! version 2.2.9  16may2011}{...}
{viewerdialog predict "dialog asmprobit_p"}{...}
{viewerdialog estat "dialog asmprobit_estat"}{...}
{vieweralsosee "[R] asmprobit postestimation" "mansection R asmprobitpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] asmprobit" "help asmprobit"}
{viewerjumpto "Description" "asmprobit postestimation##description"}{...}
{viewerjumpto "Special-interest postestimation commands" "asmprobit postestimation##special"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax for predict" "asmprobit postestimation##syntax_predict"}{...}
{viewerjumpto "Options for predict" "asmprobit postestimation##options_predict"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Syntax for estat alternatives" "asmprobit postestimation##syntax_estat_alternatives"}{...}
{viewerjumpto "Syntax for estat covariance" "asmprobit postestimation##syntax_estat_covariance"}{...}
{viewerjumpto "Options for estat covariance" "asmprobit postestimation##options_estat_covariance"}{...}
{viewerjumpto "Syntax for estat correlation" "asmprobit postestimation##syntax_estat_correlation"}{...}
{viewerjumpto "Options for estat correlation" "asmprobit postestimation##options_estat_correlation"}{...}
{viewerjumpto "Syntax for estat facweights" "asmprobit postestimation##syntax_estat_facweights"}{...}
{viewerjumpto "Options for estat facweights" "asmprobit postestimation##options_estat_facweights"}{...}
{viewerjumpto "Syntax for estat mfx" "asmprobit postestimation##syntax_estat_mfx"}{...}
{viewerjumpto "Options for estat mfx" "asmprobit postestimation##options_estat_mfx"}{...}
{viewerjumpto "" "--"}{...}
{viewerjumpto "Examples" "asmprobit postestimation##examples"}{...}
{viewerjumpto "Saved results" "asmprobit postestimation##saved_results"}{...}
{title:Title}

{p2colset 5 37 39 2}{...}
{p2col :{manlink R asmprobit postestimation} {hline 2}}Postestimation tools for
asmprobit{p_end} {p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation commands are of special interest after
{cmd:asmprobit}:

{synoptset 20}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{synopt :{helpb asmprobit postestimation##estatalt:estat alternatives}}alternative summary statistics{p_end}
{synopt :{helpb asmprobit postestimation##estatcov:estat covariance}}covariance matrix of the latent-variable errors for the alternatives{p_end}
{synopt :{helpb asmprobit postestimation##estatcor:estat correlation}}correlation matrix of the latent-variable errors for the alternatives{p_end}
{synopt :{helpb asmprobit postestimation##estatfac:estat facweights}}covariance factor weights matrix{p_end}
{synopt :{helpb asmprobit postestimation##estatmfx:estat mfx}}marginal
effects{p_end}
{synoptline}
{p2colreset}{...}

{pstd}
The following standard postestimation commands are also available:

{synoptset 11}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
INCLUDE help post_estat
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_lrtest
INCLUDE help post_nlcom
{synopt :{helpb asmprobit postestimation##predict:predict}}predicted probabilities, estimated linear predictor and its standard error{p_end}
INCLUDE help post_predictnl
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}


{marker special}{...}
{title:Special-interest postestimation commands}

{pstd}
{cmd: estat alternatives} displays summary statistics about the alternatives
in the estimation sample and provides a mapping between the index numbers that
label the covariance parameters of the model and their associated values and
labels for the alternative variable.

{pstd}
{cmd: estat covariance} computes the estimated variance-covariance matrix of
the latent-variable errors for the alternatives.  The estimates are displayed,
and the variance-covariance matrix is stored in {hi:r(cov)}.

{pstd}
{cmd: estat correlation} computes the estimated correlation matrix of the
latent-variable errors for the alternatives.  The estimates are displayed, and
the correlation matrix is stored in {hi:r(cor)}.

{pstd}
{cmd: estat facweights} displays the covariance factor weights matrix and
stores it in {hi:r(C)}.

{pstd}
{cmd: estat mfx} computes the simulated probability marginal effects.


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 16 2}
{cmd:predict} {dtype} {newvar} {ifin} [{cmd:,} {it:statistic} {opt altwise}]

{p 8 16 2}
{cmd:predict}
{dtype}
{c -(}{it:stub*}{c |}{it:{help newvarlist}}{c )-}
{ifin}
{cmd:,} {opt sc:ores}

{synoptset 11 tabbed}{...}
{synopthdr :statistic}
{synoptline}
{syntab:Main}
{synopt :{opt p:r}}probability alternative is chosen; the default{p_end}
{synopt :{cmd:xb}}linear prediction{p_end}
{synopt :{cmd:stdp}}standard error of the linear prediction{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help esample


INCLUDE help menu_predict


{marker options_predict}{...}
{title:Options for predict}

{dlgtab:Main}

{phang}
{opt pr}, the default, calculates the probability that alternative {it:j}
is chosen in case {it:i}.

{phang}
{opt xb} calculates the linear prediction for alternative {it:j} and case
{it:i}.

{phang}
{opt stdp} calculates the standard error of the linear predictor.

{phang}
{opt altwise} specifies that alternativewise deletion be used when
marking out observations due to missing values in your variables.  The default
is to use casewise deletion.  The {cmd:xb} and {cmd:stdp} options always use
alternativewise deletion.

{phang}
{opt scores} calculates the scores for each coefficient in {cmd:e(b)}.
This option requires a new variable list of length equal to 
the number of columns in {cmd:e(b)}.  Otherwise, use the {it:stub}{cmd:*}
option to have {cmd:predict} generate enumerated variables with
prefix {it:stub}.


{marker syntax_estat_alternatives}{...}
{marker estatalt}{...}
{title:Syntax for estat alternatives}

{p 8 16 2}
{cmd:estat}
{opt alt:ernatives}


INCLUDE help menu_estat


{marker syntax_estat_covariance}{...}
{marker estatcov}{...}
{title:Syntax for estat covariance}

{p 8 16 2}
{cmd:estat}
{opt cov:ariance} [{cmd:,} {opth for:mat(%fmt)}
{opth bor:der(matlist##bspec:bspec)} 
{opt left(#)}]


INCLUDE help menu_estat


{marker options_estat_covariance}{...}
{title:Options for estat covariance}

{phang}
{opth format(%fmt)} sets the matrix display format.  The default is
{cmd:format(%9.0g)}.

{phang}
{opt border(bspec)} sets the matrix display border style.  The default is
{cmd:border(all)}.  See {manhelp matlist P}.

{phang}
{opt left(#)} sets the matrix display left indent.  The default is
{cmd:left(2)}.  See {manhelp matlist P}.


{marker syntax_estat_correlation}{...}
{marker estatcor}{...}
{title:Syntax for estat correlation}

{p 8 16 2}
{cmd:estat}
{opt cor:relation} [{cmd:,} {opth for:mat(%fmt)}
{opth bor:der(matlist##bspec:bspec)} 
{opt left(#)}]


INCLUDE help menu_estat


{marker options_estat_correlation}{...}
{title:Options for estat correlation}

{phang}
{opth format(%fmt)} sets the matrix display format.  The default is 
{cmd:format(%9.4f)}.

{phang}
{opt border(bspec)} sets the matrix display border style.  The default is
{cmd:border(all)}.  See {manhelp matlist P}.

{phang} 
{opt left(#)} sets the matrix display left indent.  The default is
{cmd:left(2)}.  See {manhelp matlist P}.


{marker syntax_estat_facweights}{...}
{marker estatfac}{...}
{title:Syntax for estat facweights}

{p 8 16 2}
{cmd:estat}
{opt facw:eights} [{cmd:,} {opth for:mat(%fmt)}
{opth bor:der(matlist##bspec:bspec)} 
{opt left(#)}]


INCLUDE help menu_estat


{marker options_estat_facweights}{...}
{title:Options for estat facweights}

{phang}
{opth format(%fmt)} sets the matrix display format.  The default is 
{cmd:format(%9.0f)}.

{phang}
{opt border(bspec)} sets the matrix display border style.  The default is
{cmd:border(all)}.  See {manhelp matlist P}.

{phang} 
{opt left(#)} sets the matrix display left indent.  The default is
{cmd:left(2)}.  See {manhelp matlist P}.


{marker syntax_estat_mfx}{...}
{marker estatmfx}{...}
{title:Syntax for estat mfx}

{p 8 16 2}
{cmd:estat}
{opt mfx}
{ifin}
[{cmd:,} {it:options}]

{synoptset 35 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}

{synopt : {opth var:list(varlist)}}display marginal effects for
{it:varlist}{p_end}
{synopt : {cmd:at(mean} [{it:{help asmprobit postestimation##atlist:atlist}}]|{cmd:median} [{it:{help asmprobit postestimation##atlist:atlist}}]{cmd:)}}calculate marginal effects at these values{p_end}

{syntab:Options}
{synopt : {opt l:evel(#)}}set confidence interval level; default is {cmd:level(95)}{p_end}
{synopt : {opt nodisc:rete}}treat indicator variables as continuous{p_end}
{synopt :{opt noe:sample}}do not restrict calculation of means and medians
to the estimation sample{p_end}
{synopt :{opt now:ght}}ignore weights when calculating means and medians{p_end}
{synoptline}
{p2colreset}{...}


INCLUDE help menu_estat


{marker options_estat_mfx}{...}
{title:Options for estat mfx}

{dlgtab:Main}

{phang}
{opth varlist(varlist)} specifies the variables for which to display marginal
effects.  The default is all variables.

{marker atlist}{...}
{* although the code is such that you can type at(mean), at(mean atlist),}{...}
{* at(median), at(median atlist), or just at(atlist); we are documenting}{...}
{* as such that you have to type either mean or median with atlist}{...}
{phang}
{cmd:at(}{cmd:mean} [{it:atlist}]|{cmd:median} [{it:atlist}]{cmd:)}
specifies the values at which the marginal effects are to be calculated.
{it:atlist} is

{pmore2}
[[{it:alternative}{cmd::}{it:variable} {cmd:=} {it:#}] [{it:variable} {cmd:=} {it:#}] [...]]

{pmore}
The default is to calculate the marginal effects at the means of the independent
variables at the estimation sample, {cmd:at(mean)}.

{pmore}
After specifying the summary statistic, you can specify a series of specific
values for variables.  You can specify values for alternative-specific
variables by alternative, or you can specify one value for all alternatives.
You can specify only one value for case-specific variables.  For example, in
the {cmd:travel} dataset, {cmd:income} is a case-specific variable, whereas 
{cmd:termtime} and {cmd:travelcost} are alternative-specific variables.  The
following would be a legal syntax for {cmd:estat mfx}:

{p 12 16 2}{cmd:. estat mfx, at(mean air:termtime=50 travelcost=100 income=60)}
{p_end}

{pmore}
When {opt nodiscrete} is not specified, {cmd:at(mean} [{it:atlist}{cmd:])} or
{cmd:at(median} [{it:atlist}]{cmd:)} has no effect on computing marginal
effects for indicator variables, which are calculated as the discrete change
in the simulated probability as the indicator variable changes from 0 to 1.

{pmore}
The mean and median computations respect any {cmd:if} or {cmd:in}
qualifiers, so you can restrict the data over which the means or medians are
computed. You can even restrict the values to a specific case; for example, 

{p 12 16 2}{cmd:. estat mfx if case==21}{p_end}

{dlgtab:Options}

{phang}
{opt level(#)} specifies the confidence level, as a percentage, for confidence
intervals.  The default is {cmd:level(95)} or as set by {helpb set level}.

{phang}
{opt nodiscrete} specifies that indicator variables be treated as continuous
variables.  An indicator variable is one that takes on the value 0 or 1 in the
estimation sample.  By default, the discrete change in the simulated
probability is computed as the indicator variable changes from 0 to 1.

{phang}
{opt noesample} specifies that the whole dataset be considered instead of only
those marked in the {cmd:e(sample)} defined by the {cmd:asmprobit} command.

{phang}
{opt nowght} specifies that weights be ignored when calculating the means or
medians.


{marker examples}{...}
{title:Examples}

    {hline}
    Setup
{phang2}{cmd:. webuse travel}{p_end}
{phang2}{cmd:. asmprobit choice travelcost termtime, case(id)}
        {cmd:alternatives(mode) casevars(income)}{p_end}

{pstd}Obtain correlation matrix of the alternatives{p_end}
{phang2}{cmd:. estat correlation}{p_end}

{pstd}Obtain variance-covariance matrix of the alternatives{p_end}
{phang2}{cmd:. estat covariance}{p_end}

{pstd}Calculate probability alternative is chosen{p_end}
{phang2}{cmd:. predict p}{p_end}

{pstd}Calculate marginal effects for the case-specific variable {cmd:income}
and the alternative-specific variables {cmd:termtime} and {cmd:travelcost}{p_end}
{phang2}{cmd:. estat mfx, at(air: termtime=50 travelcost=100 income=60)}{p_end}

    {hline}
    Setup
{phang2}{cmd:. webuse travel, clear}{p_end}
{phang2}{cmd:. asmprobit choice travelcost termtime, case(id)}
          {cmd:alternatives(mode) casevars(income)}{p_end}
{phang2}{cmd:. estimates store full}{p_end}
{phang2}{cmd:. asmprobit choice travelcost termtime, case(id)}
          {cmd:alternatives(mode) casevars(income)}
          {cmd:correlation(exchangeable)}{p_end}

{pstd}Perform likelihood-ratio test to compare models{p_end}
{phang2}{cmd:. lrtest full .}{p_end}
    {hline}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:estat mfx} saves the following in {opt r()}:

{pstd}Scalars

{phang2}
{cmd: r(pr_}{it:alt}{opt )} scalars containing the computed probability
of each alternative evaluated at the value that is labeled X in the table
output.  Here {it:alt} are the labels in the macro {cmd:e(alteqs)}.

{pstd}Matrices

{phang2}
{cmd: r(}{it:alt}{opt )} matrices containing the computed marginal effects and
associated statistics.  There is one matrix for each alternative, where
{it:alt} are the labels in the macro {cmd:e(alteqs)}.  Column 1 of each matrix
contains the marginal effects; column 2, their standard errors; columns 3 and
4, their z statistics and the p-values for the z statistics; and columns 5 and
6, the confidence intervals.  Column 7 contains the values of the independent
variables used to compute the probabilities {cmd:r(pr_}{it:alt}{opt )}.
{p_end}
