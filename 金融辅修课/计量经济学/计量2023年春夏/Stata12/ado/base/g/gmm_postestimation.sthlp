{smcl}
{* *! version 1.0.10  10may2011}{...}
{viewerdialog predict "dialog gmm_p"}{...}
{viewerdialog estat "dialog gmm_estat"}{...}
{vieweralsosee "[R] gmm postestimation" "mansection R gmmpostestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] gmm" "help gmm"}{...}
{viewerjumpto "Description" "gmm postestimation##description"}{...}
{viewerjumpto "Special-interest postestimation commands" "gmm postestimation##special"}{...}
{viewerjumpto "Syntax for predict" "gmm postestimation##syntax_predict"}{...}
{viewerjumpto "Option for predict" "gmm postestimation##option_predict"}{...}
{viewerjumpto "Syntax for estat overid" "gmm postestimation##syntax_estat_overid"}{...}
{viewerjumpto "Examples" "gmm postestimation##examples"}{...}
{viewerjumpto "Saved results" "gmm postestimation##saved_results"}{...}
{title:Title}

{p2colset 5 31 33 2}{...}
{p2col :{manlink R  gmm postestimation} {hline 2}}Postestimation tools for gmm{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The following postestimation command is of special interest after 
{cmd:gmm}:

{synoptset 14}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{synopt :{helpb gmm postestimation##estatoverid:estat overid}}perform test of overidentifying restrictions{p_end}
{synoptline}
{p2colreset}{...}

{pstd}
The following standard postestimation commands are also available:

{synoptset 14}{...}
{p2coldent :Command}Description{p_end}
{synoptline}
{synopt :{helpb estat}}VCE{p_end}
INCLUDE help post_estimates
INCLUDE help post_lincom
INCLUDE help post_nlcom
{synopt :{helpb gmm postestimation##predict:predict}}residuals{p_end}
INCLUDE help post_predictnl
INCLUDE help post_test
INCLUDE help post_testnl
{synoptline}
{p2colreset}{...}
	

{marker special}{...}
{title:Special-interest postestimation command}

{pstd}
{cmd:estat overid} reports Hansen's J statistic, which is used to 
determine the validity of the overidentifying restrictions in a GMM 
model.  If the model is correctly specified in the sense that 
E{{bf:z}_i'u_i({bf:b})} = {bf:0}, then the sample analog to that condition 
should hold at the estimated value of {bf:b}.  Hansen's J statistic is 
valid only if the weight matrix is optimal, meaning that it equals the 
inverse of the covariance matrix of the moment conditions.  Therefore, 
{cmd:estat overid} only reports Hansen's J statistic after two-step or 
iterated estimation, or if you specified {opt winitial(matname)} when 
calling {cmd:gmm}.  In the latter case, it is your responsibility to 
determine the validity of the J statistic.


{marker syntax_predict}{...}
{marker predict}{...}
{title:Syntax for predict}

{p 8 16 2}
{cmd:predict}
{dtype}
{newvar}
{ifin}
[{cmd:,} {cmdab:eq:uation(#}{it:eqno}{c |}{it:eqname}{cmd:)}]

{p 8 16 2}
{cmd:predict}
{dtype}
{c -(}{it:stub}{cmd:*}{c |}{it:{help newvar:newvar_1}}
    {it:{help newvar:newvar_2}} ... {it:{help newvar:newvar_q}}{c )-}
{ifin}

{p 4 6 4}Residuals are available both in and out of sample; 
type {cmd:predict} ... {cmd:if e(sample)} ... if wanted only for the 
estimation sample.

{p 4 6 4}You specify one new variable and (optionally) {cmd:equation()}, 
or you specify {it:stub}{cmd:*} or {it:q} new variables, where {it:q} is 
the number of moment equations.

INCLUDE help menu_predict


{marker option_predict}{...}
{title:Option for predict}

{dlgtab:Main}

{phang}{cmd:equation(#}{it:eqno}{c |}{it:eqname}{cmd:)} specifies the equation
for which residuals are desired.  Specifying {cmd:equation(#1)} indicates that
the calculation is to be made for the first moment equation.  Specifying
{cmd:equation(demand)} would indicate that the calculation is to be made for
the moment equation named {cmd:demand}, assuming there is an equation named
{cmd:demand} in the model.

{pmore}
If you specify one new variable name and omit {cmd:equation()}, 
results are the same as if you had specified {cmd:equation(#1)}.

{pmore}
For more information on using {cmd:predict} after multiple-equation
estimation commands, see {manhelp predict R}.


{marker syntax_estat_overid}{...}
{marker estatoverid}{...}
{title:Syntax for estat overid}

{p 8 16 2}
{cmd:estat} {cmdab:over:id} 


INCLUDE help menu_estat


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse supDem}{p_end}
{phang2}{cmd:. global demand "demand: quantity - {xb1:price pcompete income} - {b0}"}{p_end}
{phang2}{cmd:. global supply "supply: quantity - {xb2:price praw} - {c0}"}{p_end}
{phang2}{cmd:. gmm ($demand) ($supply), wmatrix(robust)}
        {cmd:inst(demand:praw pcompete income)}
        {cmd:inst(supply:praw pcompete income) winit(unadj,indep)}
        {cmd:deriv(1/xb1 = -1) deriv(1/b0 = -1)}
        {cmd:deriv(2/xb2 = -1) deriv(2/c0 = -1) twostep}{p_end}

{pstd}Obtain residuals for supply equation{p_end}
{phang2}{cmd:. predict rhat, equation(supply)}{p_end}

{pstd}Obtain residuals for all equations, storing them in double-precision
{p_end}
{phang2}{cmd:. predict double r*}{p_end}

{pstd}Same as above{p_end}
{phang2}{cmd:. predict double s1 double s2}{p_end}

{pstd}Test whether the overidentifying restrictions are valid{p_end}
{phang2}{cmd:. estat overid}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:estat overid} saves the following in {cmd:r()}:

{synoptset 10 tabbed}{...}
{p2col 5 10 14 2: Scalars}{p_end}
{synopt:{cmd:r(J)}}Hansen's J statistic{p_end}
{synopt:{cmd:r(J_df)}}J statistic degrees of freedom{p_end}
{synopt:{cmd:r(J_p)}}J statistic p-value{p_end}
