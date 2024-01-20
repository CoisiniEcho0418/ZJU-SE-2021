{smcl}
{* *! version 1.0.1  07jul2011}{...}
{vieweralsosee "[SEM] sem model description options" "mansection SEM semmodeldescriptionoptions"}{...}
{vieweralsosee "[SEM] intro 2" "mansection SEM intro2"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SEM] sem" "help sem_command"}{...}
{vieweralsosee "[SEM] sem option constraints()" "help sem_option_constraints"}{...}
{vieweralsosee "[SEM] sem option covstructure()" "help sem_option_covstructure"}{...}
{vieweralsosee "[SEM] sem option from()" "help sem_option_from"}{...}
{vieweralsosee "[SEM] sem option reliability()" "help sem_option_reliability"}{...}
{vieweralsosee "[SEM] sem path notation" "help sem_path_notation"}{...}
{vieweralsosee "[SEM] sem postestimation" "help sem_postestimation"}{...}
{viewerjumpto "Syntax" "sem_model_options##syntax"}{...}
{viewerjumpto "Description" "sem_model_options##description"}{...}
{viewerjumpto "Options" "sem_model_options##options"}{...}
{viewerjumpto "Remarks" "sem_model_options##remarks"}{...}
{viewerjumpto "Examples" "sem_model_options##examples"}{...}
{title:Title}

{p2colset 5 44 46 2}{...}
{p2col:{manlink SEM sem model description options} {hline 2}}Model description
options{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{cmd:sem} {it:paths} {cmd:... , ...} {it:model_description_options}

{synoptset 28 tabbed}{...}
{synopthdr:model_description_options}
{synoptline}
{p2coldent :* {opt cov:ariance()}}path notation for treatment of
covariances{p_end}
{p2coldent :* {opt var:iance()}}path notation for treatment of
variances{p_end}
{p2coldent :* {opt mean:s()}}path notation for treatment of means{p_end}

{p2coldent :* {opt covstr:ucture()}}alternative method to place restrictions
on covariances{p_end}

{synopt :{opt nocon:stant}}do not fit intercepts{p_end}
{synopt :{opt nomean:s}}do not fit means or intercepts{p_end}
{synopt :{opt noanchor}}do not apply default anchoring{p_end}
{synopt :{opt forcenoanchor}}programmer's option{p_end}

{p2coldent :* {opt rel:iability()}}reliability of measurement variables{p_end}

{synopt :{opt const:raints()}}specify constraints{p_end}
{synopt :{opt from()}}specify starting values{p_end}
{synoptline}
{p 4 6 2}
* Option may be specified more than once.
{p_end}


{marker description}{...}
{title:Description}

{pstd}
{it:paths} and the options above describe the model to be fit.


{marker options}{...}
{title:Options}

{phang}
{opt covariance()}, {opt variance()}, and {opt means()} fully
describe the model to be fit.  See 
{helpb sem_path_notation:[SEM] sem path notation}.

{phang}
{opt covstructure()} provides a convenient way to constrain covariances in
your model.  Alternatively or in combination, you can place constraints using
the standard path notation.  See 
{helpb sem_option_covstructure:[SEM] sem option covstructure()}.

{phang}
{opt noconstant} specifies that all intercepts be constrained to zero.  See
{helpb sem_path_notation:[SEM] sem path notation}.

{phang}
{opt nomeans} specifies that means and intercepts not be fit.  The means and
intercepts are concentrated out of the function being optimized, which
is typically the likelihood function.  Results for all other
parameters are the same whether or not this option is specified.

{p 8 8 2}
This option is seldom specified.  {cmd:sem} issues this option to itself when
you use SSD data that do not include summary statistics for the means.

{phang}
{opt noanchor} specifies that {cmd:sem} is not to check for lack of
identification and fill in anchors where needed.  {cmd:sem} is instead
to issue an error message if anchors would be needed.  You specify this option
when you believe you have specified the necessary normalization constraints
and if you are wrong, want to hear about it.  See
{it:{mansection SEM intro3RemarksIdentification2Normalizationconstraints(anchoring):Identification 2: Normalization constraints (anchoring)}}
in {manlink SEM intro 3}. 

{phang}
{opt forcenoanchor} is similar to {opt noanchor} except that rather than
issue an error message, {cmd:sem} proceeds to estimation.  There is no reason
you should specify this option.  {opt forcenoanchor} is used in testing of
{cmd:sem} at StataCorp.

{phang}
{opt reliability()} specifies the fraction of variance not due to measurement
error for a variable.  See 
{helpb sem_option_reliability:[SEM] sem option reliability()}.

{phang}
{opt constraints()} specifies parameter constraints you wish to impose on your
model; see {helpb sem_option_constraints:[SEM] sem option constraints()}.
Constraints can also be specified as described in 
{helpb sem_path_notation##constraints:[SEM] sem path notation}, and they
are usually more conveniently specified using the path notation.

{phang}
{opt from()} specifies the starting values to be used in the optimization
process; see {helpb sem_option_from:[SEM] sem option from()}.  Starting values
can also be specified by using the {cmd:init()} suboption as described in 
{helpb sem_path_notation##initialvalues:[SEM] sem path notation}.


{marker remarks}{...}
{title:Remarks}

{pstd}
To use {cmd:sem} successfully, you need to understand {it:paths}, 
{opt covariance()}, {opt variance()}, and {opt means()}; see 
{mansection SEM intro2RemarksUsingpathdiagramstospecifythemodel:Using path diagrams to specify the model} in {manlink SEM intro 2} and see {helpb sem_path_notation:[SEM] sem path notation}.

{pstd}
{opt covstructure()} is often convenient; see 
{helpb sem_option_covstructure:[SEM] sem option covstructure()}.


{marker examples}{...}
{title:Examples}

{pstd}
Examples of these options may be found in the indicated help files.

{synoptset 26 tabbed}{...}
{synopt:{cmd:covariance()}, {cmd:variance()}}see examples in
         {helpb sem path notation##examples:[SEM] sem path notation}{p_end}
{synopt:{space 2}and {cmd:mean()}}{p_end}
{synopt:{cmd:covstructure()}}see examples in
         {helpb sem option covstructure##examples:[SEM] sem option covstructure()}{p_end}
{synopt:{cmd:noconstant}}see examples in
         {helpb sem path notation##examples:[SEM] sem path notation}{p_end}
{synopt:{cmd:reliability()}}see examples in
         {helpb sem option reliability##examples:[SEM] sem option reliability()}{p_end}
{synopt:{cmd:constraints()}}see examples in
         {helpb sem option constraints##examples:[SEM] sem option constraints()}{p_end}
{synopt:{cmd:from()}}see examples in
         {helpb sem option from##examples:[SEM] sem option from()}{p_end}
{p2colreset}{...}
