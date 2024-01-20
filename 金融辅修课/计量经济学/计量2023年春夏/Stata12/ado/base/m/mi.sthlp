{smcl}
{* *! version 1.0.19  07jun2011}{...}
{viewerdialog mi "dialog mi"}{...}
{vieweralsosee "[MI] intro" "mansection MI intro"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MI] Glossary" "help mi_glossary"}{...}
{vieweralsosee "[MI] intro substantive" "help mi_intro_substantive"}{...}
{vieweralsosee "[MI] styles" "help mi_styles"}{...}
{vieweralsosee "[MI] workflow" "help mi_workflow"}{...}
{viewerjumpto "Syntax" "mi##syntax"}{...}
{viewerjumpto "Description" "mi##description"}{...}
{viewerjumpto "Remarks" "mi##remarks"}{...}
{viewerjumpto "Acknowledgments" "mi##ack"}{...}
{title:Title}

{p2colset 5 19 21 2}{...}
{p2col :{manlink MI intro} {hline 2}}Introduction to mi{p_end}
{p2colreset}{...}

{p 8 9 9}
{it:[Suggestion:  Read}
{bf:{help mi_intro_substantive:[MI] intro substantive}}
{it:first.]}


{marker syntax}{...}
{title:Syntax}

    {c TLC}{hline 61}{c TRC}
    {c |} To become familiar with {cmd:mi} as quickly as possible{col 67}{c |}
    {c |}{col 67}{c |}
    {c |}    1.  See {it:{help mi##example:A simple example}} under {...}
{bf:{help mi##remarks:Remarks}} below.{col 67}{c |}
    {c |}{col 67}{c |}
    {c |}    2.  If you have data that require imputing, see{col 67}{c |}
    {c |}        {bf:{help mi_set:[MI] mi set}}{col 67}{c |}
    {c |}        {bf:{help mi_impute:[MI] mi impute}}{col 67}{c |}
    {c |}{col 67}{c |}
    {c |}    3.  Alternatively, if you have already imputed data, see{col 67}{c |}
    {c |}        {bf:{help mi_import:[MI] mi import}}{col 67}{c |}
    {c |}{col 67}{c |}
    {c |}    4.  To fit your model, see{col 67}{c |}
    {c |}        {bf:{help mi_estimate:[MI] mi estimate}}{col 67}{c |}
    {c BLC}{hline 61}{c BRC}


{p 4 4 2}
To create {cmd:mi} data from original data

{col 7}{...}
{...}
{...}
{col 7}{...}
{hline 70}
{...}
{...}
{...}
{...}
{col 7}{bf:{help mi_set:mi set}}{...}
{col 30}declare data to be {cmd:mi} data
{...}
{...}
{col 7}{bf:{help mi_set:mi register}}{...}
{col 30}register imputed, passive, or regular variables
{...}
{...}
{col 7}{bf:{help mi_set:mi unregister}}{...}
{col 30}unregister previously registered variables
{...}
{...}
{col 7}{bf:{help mi_set:mi unset}}{...}
{col 30}return data to unset status (rarely used)
{...}
{...}
{col 7}{...}
{hline 70}
{p 6 6 2}
See {it:{help mi##description:Description}} below for a 
summary of {cmd:mi} data and these commands.
See {bf:{help mi_glossary:[MI] Glossary}} for a definition of terms.


{p 4 4 2}
To import data that already have imputations for the missing values
(do not {cmd:mi} {cmd:set} the data)

{col 7}{...}
{hline 70}
{col 7}{bf:{help mi_import:mi import}}{...}
{col 30}import {cmd:mi} data
{...}
{...}
{col 7}{bf:{help mi_export:mi export}}{...}
{col 30}export {cmd:mi} data to non-Stata application
{...}
{...}
{col 7}{...}
{hline 70}
{p 6 6 2}


{p 4 4 2}
Once data are {cmd:mi set} or {cmd:mi import}ed

{col 7}{...}
{hline 70}
{col 7}{bf:{help mi_describe:mi query}}{...}
{col 30}query whether and how {cmd:mi set}
{...}
{...}
{col 7}{bf:{help mi_describe:mi describe}}{...}
{col 30}describe {cmd:mi} data
{...}
{...}
{col 7}{bf:{help mi_varying:mi varying}}{...}
{col 30}identify variables that vary over {it:m}
{...}
{...}
{col 7}{bf:{help mi_misstable:mi misstable}}{...}
{col 30}tabulate missing values
{...}
{...}
{col 7}{bf:{help mi_passive:mi passive}}{...}
{col 30}create passive variable and register it
{col 7}{...}
{hline 70}


{p 4 4 2}
To perform estimation on {cmd:mi} data

{col 7}{...}
{hline 70}
{col 7}{bf:{help mi_impute:mi impute}}{...}
{col 30}impute missing values
{...}
{...}
{col 7}{bf:{help mi_estimate:mi estimate}}{...}
{col 30}perform and combine estimation on {it:m}>0
{...}
{...}
{col 7}{bf:{help mi_ptrace:mi ptrace}}{...}
{col 30}check stability of MCMC
{...}
{...}
{col 7}{bf:{help mi_test:mi test}}{...}
{col 30}perform tests on coefficients
{...}
{...}
{col 7}{bf:{help mi_test:mi testtransform}}{...}
{col 30}perform tests on transformed coefficients
{...}
{...}
{col 7}{bf:{help mi_predict:mi predict}}{...}
{col 30}obtain linear predictions
{...}
{...}
{col 7}{bf:{help mi_predict:mi predictnl}}{...}
{col 30}obtain nonlinear predictions
{...}
{...}
{...}
{col 7}{...}
{hline 70}


{p 4 4 2}
To {cmd:stset}, {cmd:svyset}, {cmd:tsset}, or {cmd:xtset} any {cmd:mi} 
data that were not set at the time they were {cmd:mi} {cmd:set}

{col 7}{...}
{hline 70}
{col 7}{bf:{help mi_xxxset:mi fvset}}{...}
{col 30}{cmd:fvset}   for {cmd:mi} data
{...}
{col 7}{bf:{help mi_xxxset:mi svyset}}{...}
{col 30}{cmd:svyset}  for {cmd:mi} data
{...}
{...}
{col 7}{bf:{help mi_xxxset:mi xtset}}{...}
{col 30}{cmd:xtset}   for {cmd:mi} data
{...}
{...}
{col 7}{bf:{help mi_xxxset:mi tsset}}{...}
{col 30}{cmd:tsset}   for {cmd:mi} data
{...}
{...}
{col 7}{bf:{help mi_xxxset:mi stset}}{...}
{col 30}{cmd:stset}   for {cmd:mi} data
{...}
{...}
{col 7}{bf:{help mi_xxxset:mi streset}}{...}
{col 30}{cmd:streset} for {cmd:mi} data
{...}
{...}
{col 7}{bf:{help mi_xxxset:mi st}}{...}
{col 30}{cmd:st}      for {cmd:mi} data
{...}
{...}
{col 7}{...}
{hline 70}


{p 4 4 2}
To perform data management on {cmd:mi} data

{col 7}{...}
{hline 70}
{col 7}{bf:{help mi_rename:mi rename}}{...}
{col 30}rename variable
{...}
{...}
{col 7}{bf:{help mi_append:mi append}}{...}
{col 30}{cmd:append}  for {cmd:mi} data
{...}
{...}
{col 7}{bf:{help mi_merge:mi merge}}{...}
{col 30}{cmd:merge}   for {cmd:mi} data
{...}
{...}
{col 7}{bf:{help mi_expand:mi expand}}{...}
{col 30}{cmd:expand}  for {cmd:mi} data
{...}
{...}
{col 7}{bf:{help mi_reshape:mi reshape}}{...}
{col 30}{cmd:reshape} for {cmd:mi} data
{...}
{...}
{col 7}{bf:{help mi_stsplit:mi stsplit}}{...}
{col 30}{cmd:stsplit} for {cmd:mi} data
{...}
{...}
{col 7}{bf:{help mi_stsplit:mi stjoin}}{...}
{col 30}{cmd:stjoin}  for {cmd:mi} data
{...}
{...}
{col 7}{bf:{help mi_add:mi add}}{...}
{col 30}add imputations from one {cmd:mi} dataset to another
{...}
{...}
{col 7}{...}
{hline 70}


{p 4 4 2}
To perform data management for which no {cmd:mi} prefix command exists 

{col 7}{...}
{hline 70}
{col 7}{bf:{help mi_extract:mi extract 0}}{...}
{col 30}extract {it:m}=0 data
{col 7}{help mi_replace0:...}{...}
{col 30}perform data management the usual way
{col 7}{bf:{help mi_replace0:mi replace0}}{...}
{col 30}replace {it:m}=0 data in {cmd:mi} data
{col 7}{...}
{hline 70}


{p 4 4 2}
To perform the same data-management or data-reporting command(s) on 
{it:m}=0, {it:m}=1, ...

{col 7}{...}
{hline 70}
{col 7}{bf:{help mi_xeq:mi xeq:}} ...{...}
{col 30}execute commands on {it:m}=0, {it:m}=1, {it:m}=2, ..., {it:m}={it:M}
{...}
{col 7}{bf:{help mi_xeq:mi xeq #:}} ...{...}
{col 30}execute commands on {it:m}=#
{...}
{col 7}{bf:{help mi_xeq:mi xeq # # ...:}} ...{...}
{col 30}execute commands on specified values of {it:m}
{col 7}{...}
{hline 70}


{p 4 4 2}
Useful utility commands

{col 7}{...}
{hline 70}
{col 7}{bf:{help mi_convert:mi convert}}{...}
{col 30}convert {cmd:mi} data from one style to another
{...}

{...}
{col 7}{bf:{help mi_extract:mi extract #}}{...}
{col 30}extract {it:m}={it:#} from {cmd:mi} data
{...}
{...}
{col 7}{bf:{help mi_select:mi select #}}{...}
{col 30}programmer's command similar to {cmd:mi} {cmd:extract}

{...}
{...}
{col 7}{bf:{help mi_copy:mi copy}}{...}
{col 30}copy {cmd:mi} data
{...}
{...}
{col 7}{bf:{help mi_erase:mi erase}}{...}
{col 30}erase files containing {cmd:mi} data
{...}
{...}

{col 7}{bf:{help mi_update:mi update}}{...}
{col 30}verify/make {cmd:mi} data consistent
{...}
{...}
{col 7}{bf:{help mi_reset:mi reset}}{...}
{col 30}reset imputed or passive variable
{col 7}{...}
{hline 70}


{p 4 4 2}
For programmers interested in extending {cmd:mi}

{col 7}{...}
{hline 70}
{col 7}{bf:{help mi_technical:[MI] technical}}{...}
{col 30}Detail for programmers
{col 7}{hline 70}


{marker sum_styles}{...}
{p 4 4 2}
{it:Summary of styles}

{p 6 6 2}
There are four styles or formats in which {cmd:mi} data are stored: 
flongsep, flong, mlong, and wide.

{p 8 12 2}
1.  Flongsep:  {it:m}=0, {it:m=1}, ..., {it:m}={it:M} are each separate
    {cmd:.dta} datasets.  If {it:m}=0 data are stored 
    in {cmd:pat.dta}, then {it:m}=1 data are stored in {cmd:_1_pat.dta}, 
    {it:m}=2 in {cmd:_2_pat.dta}, and so on.
    Flongsep stands for {it:full long and separate}.

{p 8 12 2}
2.  Flong:  {it:m}=0, {it:m}=1, ..., {it:m}={it:M} are stored 
    in one dataset with {it:_N} = {bind:{it:N} + {it:M}*{it:N}}
    observations, where 
    {it:N} is the number of observations in {it:m}=0.
    Flong stands for {it:full long}. 

{p 8 12 2}
3.  Mlong:  {it:m=0}, {it:m=1}, ..., {it:m}={it:M} are stored 
    in one dataset with {it:_N} = {bind:{it:N} + {it:M}*{it:n}}
    observations,
    where {it:n} is the number of incomplete observations in {it:m}=0.
    Mlong stands for {it:marginal long}.

{p 8 12 2}
4.  Wide:  {it:m=0}, {it:m=1}, ..., {it:m}={it:M} are stored 
    in one dataset with {it:_N} = {it:N} observations.  Each imputed and 
    passive variable has {it:M} additional variables associated with it.
    If variable {cmd:bp} contains the values in {it:m}=0, then 
    values for {it:m}=1 are contained in variable {cmd:_1_bp}, 
    values for {it:m}=2 in {cmd:_2_bp}, and so on.
    Wide stands for {it:wide}.

{p 6 6 2}
See 
{it:{help mi_glossary##def_style:style}} in 
{bf:{help mi_glossary:[MI] Glossary}}
and see 
{bf:{help mi_styles:[MI] styles}} for examples.
See {bf:{help mi_technical:[MI] technical}} for programmer's 
details.  


{marker description}{...}
{title:Description}

{p 4 4 2}
The {cmd:mi} suite of commands deals with multiple-imputation data, 
abbreviated as {cmd:mi} data.  

{p 4 4 2}
In summary, 

{p 8 12 2}
1.  {cmd:mi} data may be stored in one of four formats -- 
    flongsep, flong, mlong, and wide -- known as styles.
    Descriptions are provided in
    {it:{help mi##sum_styles:Summary of styles}} 
    directly above.

{p 8 12 2}
2.  {cmd:mi} data contain {it:M} imputations numbered {it:m} = 1, 2, ...,
    {it:M}, and contain {it:m}=0, the original data with missing values.

{p 8 12 2}
3.  Each variable in {cmd:mi} data is registered as
    imputed, passive, or regular, or it is unregistered.
{p_end}
{p 12 16 2}
a.
    Unregistered variables are mostly treated like regular variables.  
{p_end}
{p 12 16 2}
b.  Regular
    variables usually do not contain missing, or if they do, the missing
    values are not imputed in {it:m}>0.
{p_end}
{p 12 16 2}
c.  Imputed variables contain missing in
    {it:m}=0, and those values are imputed, or are to be imputed, in {it:m}>0.
{p_end}
{p 12 16 2}
d.  Passive variables are algebraic combinations of imputed,
    regular, or other passive variables.

{p 8 12 2}
4.  If an imputed variable contains a value greater 
    than {cmd:.} in {it:m}=0 -- it contains {cmd:.a}, {cmd:.b}, ..., 
    {cmd:.z} -- then that value is considered a hard missing and the missing
    value persists in {it:m}>0.

{p 4 4 2}
See {bf:{help mi_glossary:[MI] Glossary}} for a more thorough description 
of terms used throughout this manual.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
Remarks are presented under the following headings:

	{help mi##example:A simple example}
	{help mi##order:Suggested reading order}


{marker example}{...}
{title:{it:A simple example}}

{pstd}
We are about to type six commands:

	. {cmd:webuse mheart5}{right:(1)    }

	. {cmd:mi set mlong}{right:(2)    }

	. {cmd:mi register imputed age bmi}{right:(3)    }

	. {cmd:set seed 29390}{right:(4)    }

	. {cmd:mi impute mvn age bmi = attack smokes hsgrad female, add(10)}{right:(5)    }

	. {cmd:mi estimate: logistic attack smokes age bmi hsgrad female}{right:(6)    }

{pstd}
The story is that we want to fit  

	. {cmd:logistic attack smokes age bmi hsgrad female}

{pstd} 
but the {cmd:age} and {cmd:bmi} variables contain missing values.  Fitting
the model by typing {cmd:logistic} ... would ignore some of the information in
our data.  Multiple imputation (MI) attempts to recover that information.
The method imputes {it:M} values to fill in each of the missing values. 
After that, statistics are performed on the {it:M} imputed datasets
separately and the results combined.  The goal is to obtain better estimates
of parameters and their standard errors.

{pstd}
In the solution shown above, 

{p 8 12 2}
1.  We load the data.

{p 8 12 2}
2.  We set our data to be {cmd:mi}.

{p 8 12 2}
3.  We inform {cmd:mi} which variables containing missing values 
    for which we want to impute values.

{p 8 12 2}
4.  We impute values in command 5; we prefer that our results be 
    reproducible, so we set the random-number seed in command 4.  This step is
    optional.

{p 8 12 2}
5.  We create {it:M}=10 imputations for each missing value in the 
    variables we registered in command 3.

{p 8 12 2}
6.  We fit the desired model separately on each of the 10 imputed datasets
    and combine the results. 

{pstd}
The results of running the six-command solution are

{hline}
{* ----------------------------------------------- junk1.smcl}{...}
{...}
{...}
{...}
{...}
{com}. webuse mheart5
{txt}(Fictional heart attack data, bmi and age missing)

{com}. mi set mlong 
{txt}
{com}. mi register imputed age bmi
{txt}{p}
(28 {it:m}=0 obs. now marked as incomplete)
{p_end}

{com}. set seed 29390
{txt}
{com}. mi impute mvn age bmi = attack smokes hsgrad female, add(10)
{res}
{txt}Performing EM optimization:
{txt}{p 0 6}note: 12 {txt}observations {txt}omitted from EM estimation because of all {txt}imputation variables missing{p_end}
{txt}  observed log likelihood = {res}-651.75868{txt} at iteration 7
{res}
{txt}Performing MCMC data augmentation ... 
{res}{txt}
Multivariate imputation{txt}{col 45}{ralign 12:Imputations }= {res}      10
{txt}Multivariate normal regression{txt}{col 45}{ralign 12:added }= {res}      10
{txt}Imputed: {it:m}=1 through {it:m}=10{txt}{col 45}{ralign 12:updated }= {res}       0

{txt}Prior: uniform{txt}{col 45}{ralign 12:Iterations }= {res}    1000
{txt}{col 45}{ralign 12:burn-in }= {res}     100
{txt}{col 45}{ralign 12:between }= {res}     100

{txt}{hline 19}{c TT}{hline 35}{hline 11}
{txt}{col 20}{c |}{center 46:  Observations per {it:m}}
{txt}{col 20}{c LT}{hline 35}{c TT}{hline 10}
{txt}{col 11}Variable {c |}{ralign 12:Complete }{ralign 13:Incomplete }{ralign 10:Imputed }{c |}{ralign 10:Total}
{hline 19}{c +}{hline 35}{c +}{hline 10}
{txt}{ralign 19:age }{c |}{res}        142           12        12 {txt}{c |}{res}       154
{txt}{ralign 19:bmi }{c |}{res}        126           28        28 {txt}{c |}{res}       154
{txt}{hline 19}{c BT}{hline 35}{c BT}{hline 10}
{p 0 1 1 66}(complete + incomplete = total; imputed is the minimum across {it:m}
 of the number of filled-in observations.){p_end}
{res}{txt}
{com}. mi estimate: logistic attack smokes age bmi hsgrad female
{res}
{txt}Multiple-imputation estimates{col 51}Imputations{col 67}= {res}        10
{txt}Logistic regression{col 51}Number of obs{col 67}= {res}       154
{txt}{col 51}Average RVI{col 67}= {res}    0.1031
{txt}{col 51}Largest FMI{col 67}= {res}    0.3256
{txt}DF adjustment:{ralign 15: {res:Large sample}}{col 51}DF:     min{col 67}= {res}     92.90
{txt}{col 51}        avg{col 67}= {res}  25990.98
{txt}{col 51}        max{col 67}= {res}  77778.66
{txt}Model F test:{ralign 16: {res:Equal FMI}}{col 51}F({res}   5{txt},{res} 3279.8{txt}){col 67}= {res}      3.27
{txt}Within VCE type: {ralign 12:{res:OIM}}{col 51}Prob > F{col 67}= {res}    0.0060

{txt}{hline 13}{c TT}{hline 11}{hline 11}{hline 9}{hline 8}{hline 13}{hline 12}
{col 1}      attack{col 14}{c |}      Coef.{col 26}   Std. Err.{col 38}      t{col 46}   P>|t|{col 54}     [95% Con{col 67}f. Interval]
{hline 13}{c +}{hline 11}{hline 11}{hline 9}{hline 8}{hline 13}{hline 12}
{space 6}smokes {c |}{col 14}{res}{space 2}  1.18324{col 26}{space 2} .3605462{col 37}{space 1}    3.28{col 46}{space 3}0.001{col 54}{space 4} .4765251{col 67}{space 3} 1.889954
{txt}{space 9}age {c |}{col 14}{res}{space 2} .0321028{col 26}{space 2}  .016145{col 37}{space 1}    1.99{col 46}{space 3}0.047{col 54}{space 4} .0004071{col 67}{space 3} .0637984
{txt}{space 9}bmi {c |}{col 14}{res}{space 2} .1100667{col 26}{space 2} .0546424{col 37}{space 1}    2.01{col 46}{space 3}0.047{col 54}{space 4} .0015561{col 67}{space 3} .2185772
{txt}{space 6}hsgrad {c |}{col 14}{res}{space 2} .1413171{col 26}{space 2} .4043884{col 37}{space 1}    0.35{col 46}{space 3}0.727{col 54}{space 4}-.6512819{col 67}{space 3}  .933916
{txt}{space 6}female {c |}{col 14}{res}{space 2}-.0759589{col 26}{space 2}  .416927{col 37}{space 1}   -0.18{col 46}{space 3}0.855{col 54}{space 4}-.8931367{col 67}{space 3} .7412189
{txt}{space 7}_cons {c |}{col 14}{res}{space 2} -5.38815{col 26}{space 2}  1.85184{col 37}{space 1}   -2.91{col 46}{space 3}0.004{col 54}{space 4}-9.047656{col 67}{space 3}-1.728644
{txt}{hline 13}{c BT}{hline 11}{hline 11}{hline 9}{hline 8}{hline 13}{hline 12}
{res}
{txt}
{* ----------------------------------------------- junk1.smcl}{...}
{hline}

{pstd}
Note that the output from the last command, 

	. {cmd:mi estimate: logistic attack smokes age bmi hsgrad female}

{pstd}
reported coefficients rather than odds ratios, which {cmd:logistic} 
would usually report.  That is because the estimation command is 
not {cmd:logistic}, it is {cmd:mi} {cmd:estimate}, and {cmd:mi} 
{cmd:estimate} happened to use {cmd:logistic} to obtain results 
that {cmd:mi} {cmd:estimate} combined into its own estimation results.

{pstd}
{cmd:mi} {cmd:estimate} by default displays coefficients.
If we now wanted to see odds ratios, we could type 

	. {cmd:mi estimate, or}
	  {it:(output showing odds ratios would appear)}

{pstd}
Note carefully: We replay results by typing {cmd:mi} {cmd:estimate},
not by typing {cmd:logistic}.  If we had wanted to see the odds ratios 
from the outset, we would have typed 

	. {cmd:mi estimate, or: logistic attack smokes age bmi hsgrad female}



{marker order}{...}
{title:{it:Suggested reading order}}

{p 4 4 2}
The order of suggested reading of this manual is

	{bf:{help mi_intro_substantive:[MI] intro substantive}}
	{bf:[MI] intro} 
	{bf:{help mi_glossary:[MI] Glossary}}
	{bf:{help mi_workflow:[MI] workflow}}

	{bf:{help mi_set:[MI] mi set}}
	{bf:{help mi_import:[MI] mi import}}
	{bf:{help mi_describe:[MI] mi describe}}
	{bf:{help mi_misstable:[MI] mi misstable}}

	{bf:{help mi_impute:[MI] mi impute}} 
	{bf:{help mi_estimate:[MI] mi estimate}}

	{bf:{help mi_styles:[MI] styles}}
	{bf:{help mi_convert:[MI] mi convert}}
	{bf:{help mi_update:[MI] mi update}}

	{bf:{help mi_rename:[MI] mi rename}}
	{bf:{help mi_copy:[MI] mi copy}}
	{bf:{help mi_erase:[MI] mi erase}}
	{bf:{help mi_xxxset:[MI] mi XXXset}}

	{bf:{help mi_extract:[MI] mi extract}}
	{bf:{help mi_replace0:[MI] mi replace0}}

	{bf:{help mi_append:[MI] mi append}}
	{bf:{help mi_add:[MI] mi add}}
	{bf:{help mi_merge:[MI] mi merge}}
	{bf:{help mi_reshape:[MI] mi reshape}}
	{bf:{help mi_stsplit:[MI] mi stsplit}}
	{bf:{help mi_varying:[MI] mi varying}}

{p 4 4 2}
Programmers will want to see 
{bf:{help mi_technical:[MI] technical}}.


{marker ack}{...}
{title:Acknowledgments}

{p 4 4 2}
We thank Jerry (Jerome)
Reiter of Duke University, 
Patrick Royston of the MRC Clinical Trials Unit, and 
Ian White of the MRC Biostatistics Unit
for their comments and assistance in the development of {cmd:mi}.  We also
thank 
James Carpenter of the London School of Hygiene and Tropical Medicine and 
Jonathan Sterne of the University of Bristol for their comments.

{p 4 4 2}
Previous and still ongoing work on multiple imputation in Stata 
influenced the design of {cmd:mi}.
For their past and current contributions, we thank
Patrick Royston and Ian White again for {cmd:ice};
John Carlin and John Galati, both 
of the Murdoch Children's Research Institute and 
University of Melbourne, and 
Patrick Royston and Ian White (yet again)
for {cmd:mim}; 
John Galati for {cmd:inorm};
and Rodrigo Alfaro of the Banco Central de Chile for {cmd:mira}. 
{p_end}
