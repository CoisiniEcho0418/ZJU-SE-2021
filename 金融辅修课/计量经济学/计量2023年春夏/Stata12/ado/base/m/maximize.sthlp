{smcl}
{* *! version 1.3.16  10jun2011}{...}
{vieweralsosee "[R] maximize" "mansection R maximize"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] ml" "help ml"}{...}
{vieweralsosee "[M-5] moptimize()" "help mf_moptimize"}{...}
{vieweralsosee "[M-5] optimize()" "help mf_optimize"}{...}
{viewerjumpto "Syntax" "maximize##syntax"}{...}
{viewerjumpto "Description" "maximize##description"}{...}
{viewerjumpto "Maximization options" "maximize##options_max"}{...}
{viewerjumpto "Option for set maxiter" "maximize##option_set_maxiter"}{...}
{viewerjumpto "Remarks" "maximize##remarks"}{...}
{viewerjumpto "Saved results" "maximize##saved_results"}{...}
{viewerjumpto "Reference" "maximize##reference"}{...}
{title:Title}

{p2colset 5 21 23 2}{...}
{p2col: {manlink R maximize} {hline 2}}Details of iterative maximization{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{phang}Maximum likelihood optimization

{p 8 20 2}
{it:mle_cmd}
{it:...} [{cmd:,} {it:options}]


{phang}Set default maximum iterations

{p 8 20 2}
{cmd:set} {cmd:maxiter} {it:#} [{cmd:,} {opt perm:anently}]


{synoptset 27}
{synopthdr}
{synoptline}
{synopt:{opt dif:ficult}}use a different stepping algorithm in nonconcave
	regions{p_end}
{synopt:{opt tech:nique(algorithm_spec)}}maximization technique{p_end}
{synopt:{opt iter:ate(#)}}perform maximum of {it:#} iterations; default is
	{cmd:iterate(16000)}{p_end}
{synopt:[{cmdab:no:}]{opt lo:g}}display an iteration log of the log likelihood;
        typically, the default{p_end}
{synopt:{opt tr:ace}}display current parameter vector in iteration log{p_end}
{synopt:{opt grad:ient}}display current gradient vector in iteration log{p_end}
{synopt:{opt showstep}}report steps within an iteration log{p_end}
{synopt:{opt hess:ian}}display current negative Hessian matrix in iteration log
{p_end}
{synopt:{cmdab:showtol:erance}}report the calculated result that is compared
        to the effective convergence criterion{p_end}
{synopt:{opt tol:erance(#)}}tolerance for the coefficient vector; see 
        {it:{help maximize##tolerance:Options}} for the defaults{p_end}
{synopt:{opt ltol:erance(#)}}tolerance for the log likelihood;
        {it:{help maximize##ltolerance:Options}} for the defaults{p_end}
{synopt:{opt nrtol:erance(#)}}tolerance for the scaled gradient;
        {it:{help maximize##nrtolerance:Options}} for the defaults{p_end}
{synopt:{opt qtol:erance(#)}}when specified with algorithms {cmd:bhhh},
            {cmd:dfp}, or {cmd:bfgs}, the q-H matrix is used as the final
            check for convergence rather than {opt nrtolerance()} and
            the H matrix; seldom used{p_end}
{synopt:{opt nonrtol:erance}}ignore the {opt nrtolerance()} option{p_end}
{synopt:{opt from(init_specs)}}initial values for the coefficients{p_end}
{synoptline}
{p2colreset}{...}
{marker algorithm_spec}{...}
{p 4 6 2}
where {it:algorithm_spec} is

{p 8 8 2}
{it:algorithm} [ {it:#} [ {it:algorithm} [{it:#}] ] ... ]

{p 4 6 2}
{it:algorithm} is {c -(}{opt nr} {c |} {opt bhhh} {c |} {opt dfp} {c |} {opt bfgs}{c )-}

{p 4 6 2}
and {it:init_specs} is one of

{p 8 20 2}{it:matname} [{cmd:,} {cmd:skip} {cmd:copy} ]{p_end}

{p 8 20 2}{c -(} [{it:eqname}{cmd::}]{it:name} {cmd:=} {it:#} |
	{cmd:/}{it:eqname} {cmd:=} {it:#} {c )-} [{it:...}]{p_end}

{p 8 20 2}{it:#} [{it:#} {it:...}]{cmd:,} {cmd:copy}{p_end}


{marker description}{...}
{title:Description}

{pstd}
All Stata commands maximize likelihood functions using {cmd:moptimize()} and
{cmd:optimize()}; see
{it:{mansection R maximizeMethodsandformulas:Methods and formulas}} in
{bf:[R] maximize}.
Commands use the Newton-Raphson method with step halving and special fixups
when they encounter nonconcave regions of the likelihood.  For details, see
{manhelp moptimize M-5} and {manhelp optimize M-5}.  For more information about
programming maximum likelihood estimators in ado-files, see {manhelp ml R} and
{help maximize##GPP2010:Gould, Pitblado, and Poi (2010)}.

{pstd}
{cmd:set} {cmd:maxiter} specifies the default maximum number of iterations for
estimation commands that iterate.  The initial value is {cmd:16000}, and
{it:#} can be {cmd:0} to {cmd:16000}.  To change the maximum number of
iterations performed by a particular estimation command, you need not reset
{cmd:maxiter}; you can specify the {opt iterate(#)} option.  When
{opt iterate(#)} is not specified, the {cmd:maxiter} value is used.


{marker options_max}{...}
{title:Maximization options}

{marker difficult}{...}
{phang}
{opt difficult} specifies that the likelihood function is likely to be
difficult to maximize because of  nonconcave regions.  When the message "not
concave" appears repeatedly, {opt ml}'s standard stepping algorithm may not be
working well.  {opt difficult} specifies that a different stepping algorithm be
used in nonconcave regions.  There is no guarantee that {opt difficult} will
work better than the default; sometimes it is better and sometimes it is
worse.  You should use the {opt difficult} option only when the default stepper
declares convergence and the last iteration is "not concave" or when the
default stepper is repeatedly issuing "not concave" messages and producing only
tiny improvements in the log likelihood.

{phang}
{opt technique(algorithm_spec)} specifies how the likelihood function is to be
maximized.  The following algorithms are allowed.
For details, see 
{help maximize##GPP2010:Gould, Pitblado, and Poi (2010)}.

{pmore}
        {cmd:technique(nr)} specifies Stata's modified Newton-Raphson (NR)
        algorithm.

{pmore}
        {cmd:technique(bhhh)} specifies the Berndt-Hall-Hall-Hausman (BHHH)
        algorithm.

{pmore}
	{cmd:technique(dfp)} specifies the Davidon-Fletcher-Powell (DFP)
	algorithm.

{pmore}
        {cmd:technique(bfgs)} specifies the Broyden-Fletcher-Goldfarb-Shanno
        (BFGS) algorithm.

{pmore}The default is {cmd:technique(nr)}.

{pmore}
    You can switch between algorithms by specifying more than one in the
    {opt technique()} option.  By default, an algorithm is used for
    five iterations before switching to the next algorithm.  To specify a
    different number of iterations, include the number after the technique in
    the option.  For example, specifying {cmd:technique(bhhh 10 nr 1000)}
    requests that {cmd:ml} perform 10 iterations with the BHHH algorithm
    followed by 1000 iterations with the NR algorithm, and then switch back
    to BHHH for 10 iterations, and so on.  The process continues until
    convergence or until the maximum number of iterations is reached.

{phang}
{opt iterate(#)} specifies the maximum number of iterations.
When the number of iterations equals {cmd:iterate()}, the optimizer stops and
presents the current results.  If convergence is declared before this
threshold is reached, it will stop when convergence is declared.  Specifying
{cmd:iterate(0)} is useful for viewing results evaluated at the initial value
of the coefficient vector.  Specifying {cmd:iterate(0)} and {cmd:from()} 
together allows you to view results evaluated at a specified coefficient
vector; however, not all commands allow the {opt from()} option.
The default value of {opt iterate(#)} for both estimators programmed
internally and estimators programmed with {cmd:ml} is the current value of
{cmd:set maxiter}, which is {cmd:iterate(16000)} by default.

{phang}
{opt log} and {opt nolog} specify whether an iteration log showing the
progress of the log likelihood is to be displayed.  For most commands, the log
is displayed by default, and {opt nolog} suppresses it.  For a few commands
(such as the {opt svy} maximum likelihood estimators), you must specify
{opt log} to see the log.

{phang}
{opt trace} adds to the iteration log a display of the current
parameter vector.

{phang}
{opt gradient} adds to the iteration log a display of the current gradient
vector.

{phang}
{opt showstep} adds to the iteration log a report on the steps within an
iteration.  This option was added so that developers at StataCorp could view
the stepping when they were improving the {cmd:ml} optimizer code.  At this
point, it mainly provides entertainment.

{phang}
{opt hessian} adds to the iteration log a display of the current negative
Hessian matrix.

{phang}
{cmd:showtolerance} adds to the iteration log the calculated value that is
compared with the effective convergence criterion at the end of each iteration.
Until convergence is achieved, the smallest calculated value is reported.

{phang}
{cmd:shownrtolerance} is a synonym of {opt showtolerance}.


{hline}
{pstd}
Below we describe the three convergence tolerances.
Convergence is declared when the
{opt nrtolerance()} criterion is met and either the {opt tolerance()} or
the {opt ltolerance()} criterion is also met.
{p_end}

{phang}
{marker tolerance}
{opt tolerance(#)} specifies the tolerance for the
coefficient vector.  When the relative change in the coefficient vector from
one iteration to the next is less than or equal to {opt tolerance()}, the
{opt tolerance()} convergence criterion is satisfied.

{pmore}
{cmd:tolerance(1e-4)} is the default for estimators programmed with {cmd:ml}.

{pmore}
{cmd:tolerance(1e-6)} is the default. 

{phang}
{marker ltolerance}
{opt ltolerance(#)} specifies the tolerance for the log
likelihood.  When the relative change in the log likelihood from one
iteration to the next is less than or equal to {opt ltolerance()}, the 
{opt ltolerance()} convergence is satisfied.

{pmore}
{cmd:ltolerance(0)} is the default for estimators programmed with {help ml}.

{pmore}
{cmd:ltolerance(1e-7)} is the default.

{phang}
{marker nrtolerance}
{opt nrtolerance(#)} specifies the tolerance for the scaled gradient.
Convergence is declared when g*inv(H)*g' < {opt nrtolerance()}.
The default is {cmd:nrtolerance(1e-5)}.

{phang}
{opt qtolerance(#)} when specified with algorithms {cmd:bhhh}, {cmd:dfp}, or
{cmd:bfgs} uses the q-H matrix as the final check for convergence rather than
{opt nrtolerance()} and the H matrix.

{pmore}
Beginning with Stata 12, by default, Stata now computes the H matrix when the
q-H matrix passes the convergence tolerance, and Stata requires that H be
concave and pass the {opt nrtolerance()} criterion before concluding
convergence has occurred.

{pmore}
{opt qtolerance()} provides a way for the user to obtain Stata's earlier
behavior.

{phang}
{opt nonrtolerance} specifies that the default {opt nrtolerance()} criterion be
turned off.

{hline}


{phang}
{opt from()} specifies initial values for the coefficients.  Not all estimators
in Stata support this option. You can specify the initial values in one of
three ways: by specifying the name of a vector containing the initial values
(for example, {cmd:from(b0)}, where {cmd:b0} is a properly labeled vector); by
specifying coefficient names with the values (for example,
{cmd:from(age=2.1 /sigma=7.4)}); or by specifying a list of values (for
example, {cmd:from(2.1 7.4, copy)}).  {opt from()} is intended for use when you
are doing bootstraps (see {manhelp bootstrap R}) and in other special
situations (for example, with {cmd:iterate(0)}).  Even when the values
specified in {opt from()} are close to the values that maximize the likelihood,
only a few iterations may be saved.  Poor values in {opt from()} may lead to
convergence problems.

{phang2}
{opt skip} specifies that any parameters found in the specified initialization
vector that are not also found in the model be ignored.  The default action is
to issue an error message.

{phang2}
{opt copy} specifies that the list of values or the initialization
vector be copied into the initial-value vector by position rather than
by name.


{marker option_set_maxiter}{...}
{title:Option for set maxiter}

{phang}
{opt permanently} specifies that, in addition to making the change right now,
the {cmd:maxiter} setting be remembered and become the default setting when
you invoke Stata.


{marker remarks}{...}
{title:Remarks}

{pstd}
Only in rare circumstances would you ever need to specify any of these
options, except {opt nolog}.  The {opt nolog} option is useful
for reducing the amount of output appearing in log files.


{marker saved_results}{...}
{title:Saved results}

{pstd}
Maximum likelihood estimators save the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations; always saved{p_end}
{synopt:{cmd:e(k)}}number of parameters; always saved{p_end}
{synopt:{cmd:e(k_eq)}}number of equations in {cmd:e(b)}; usually saved{p_end}
{synopt:{cmd:e(k_eq_model)}}number of equations in overall model 
                 test; usually saved{p_end}
{synopt:{cmd:e(k_dv)}}number of dependent variables; usually saved{p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom; always saved{p_end}
{synopt:{cmd:e(r2_p)}}pseudo-R-squared; sometimes saved{p_end}
{synopt:{cmd:e(ll)}}log likelihood; always saved{p_end}
{synopt:{cmd:e(ll_0)}}log likelihood, constant-only model; saved when
	constant-only model is fit{p_end}
{synopt:{cmd:e(N_clust)}}number of clusters; saved when {cmd:vce(cluster}
        {it:clustvar}{cmd:)} is specified;
	see {findalias frrobust}{p_end}
{synopt:{cmd:e(chi2)}}chi-squared; usually saved{p_end}
{synopt:{cmd:e(p)}}significance of model of test; usually saved{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}; always saved{p_end}
{synopt:{cmd:e(rank0)}}rank of {cmd:e(V)} for constant-only model; saved
	when constant-only model is fit{p_end}
{synopt:{cmd:e(ic)}}number of iterations; usually saved{p_end}
{synopt:{cmd:e(rc)}}return code; usually saved{p_end}
{synopt:{cmd:e(converged)}}{cmd:1} if converged, {cmd:0} otherwise; usually saved{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}name of command; always saved{p_end}
{synopt:{cmd:e(cmdline)}}command as typed; always saved{p_end}
{synopt:{cmd:e(depvar)}}names of dependent variables; always saved{p_end}
{synopt:{cmd:e(wtype)}}weight type; saved when weights are specified or
	implied{p_end}
{synopt:{cmd:e(wexp)}}weight expression; saved when weights are specified or
	implied{p_end}
{synopt:{cmd:e(title)}}title in estimation output; usually saved by commands using {cmd:ml}{p_end}
{synopt:{cmd:e(clustvar)}}name of cluster variable; saved when
        {cmd:vce(cluster} {it:clustvar}{cmd:)} is specified;
        see {findalias frrobust}{p_end}
{synopt:{cmd:e(chi2type)}}{cmd:Wald} or {cmd:LR}; type of model chi-squared
	test; usually saved{p_end}
{synopt:{cmd:e(vce)}}{it:vcetype} specified in {cmd:vce()}; saved when command
        allows {cmd:vce()}{p_end}
{synopt:{cmd:e(vcetype)}}title used to label Std. Err.; sometimes saved{p_end}
{synopt:{cmd:e(opt)}}type of optimization; always saved{p_end}
{synopt:{cmd:e(which)}}{cmd:max} or {cmd:min}; whether optimizer is to perform
                         maximization or minimization; always saved{p_end}
{synopt:{cmd:e(ml_method)}}type of {cmd:ml} method; always saved by commands
using {cmd:ml}{p_end}
{synopt:{cmd:e(user)}}name of likelihood-evaluator program; always saved{p_end}
{synopt:{cmd:e(technique)}}from {cmd:technique()} option; sometimes saved{p_end}
{synopt:{cmd:e(singularHmethod)}}{cmd:m-marquardt} or {cmd:hybrid}; method used
                          when Hessian is singular; sometimes saved (1){p_end}
{synopt:{cmd:e(crittype)}}optimization criterion; always saved (1){p_end}
{synopt:{cmd:e(properties)}}estimator properties; always saved{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}; usually
	saved{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector; always saved{p_end}
{synopt:{cmd:e(Cns)}}constraints matrix; sometimes saved{p_end}
{synopt:{cmd:e(ilog)}}iteration log (up to 20 iterations); usually saved{p_end}
{synopt:{cmd:e(gradient)}}gradient vector; usually saved{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators; always
	saved{p_end}
{synopt:{cmd:e(V_modelbased)}}model-based variance; only saved when {cmd:e(V)}
	is neither the OIM nor OPG variance{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample; always saved{p_end}
    {hline 20}
{p 4 6 2}
1. Type {cmd:ereturn} {cmd:list,} {cmd:all} to view these results; see
{helpb return:[P] return}.

{pstd}
See {it:Saved results} in the manual entry for any maximum likelihood estimator
for a list of returned results.


{marker reference}{...}
{title:Reference}

{marker GPP2010}{...}
{phang}
Gould, W. W., J. Pitblado, and B. P. Poi. 2010.
{browse "http://www.stata-press.com/books/ml4.html":{it:Maximum Likelihood Estimation with Stata.} 4th ed.}  College Station, TX: Stata Press.
{p_end}
