{smcl}
{* *! version 1.0.0  24jun2011}{...}
{bf:Datasets for Stata Structural Equation Modeling Reference Manual, Release 12}
{hline}
{p 4 4 2}
Datasets used in the Stata Documentation were selected to demonstrate
 the use of Stata.  Datasets were sometimes altered so that a particular
 feature could be explained.  Do not use these datasets for
 analysis purposes.
{p_end}
{hline}

    {title:Example 1 - Single-factor measurement model}
	sem_1fmm.dta{col 30}{stata "use http://www.stata-press.com/data/r12/sem_1fmm.dta":use} | {stata "describe using  http://www.stata-press.com/data/r12/sem_1fmm.dta":describe}

{hline}

    {title:Example 3 - Two-factor measurement model}
	sem_2fmm.dta{col 30}{stata "use http://www.stata-press.com/data/r12/sem_2fmm.dta":use} | {stata "describe using  http://www.stata-press.com/data/r12/sem_2fmm.dta":describe}

    {title:Example 4 - Goodness-of-fit statistics}
	sem_2fmm.dta{col 30}{stata "use http://www.stata-press.com/data/r12/sem_2fmm.dta":use} | {stata "describe using  http://www.stata-press.com/data/r12/sem_2fmm.dta":describe}

{hline}

    {title:Example 5 - Modification indices}
	sem_2fmm.dta{col 30}{stata "use http://www.stata-press.com/data/r12/sem_2fmm.dta":use} | {stata "describe using  http://www.stata-press.com/data/r12/sem_2fmm.dta":describe}

{hline}

    {title:Example 7 - Nonrecursive structural model}
	sem_sm1.dta{col 30}{stata "use http://www.stata-press.com/data/r12/sem_sm1.dta":use} | {stata "describe using  http://www.stata-press.com/data/r12/sem_sm1.dta":describe}

{hline}

    {title:Example 8 - Testing that coefficients are equal, and constraining them}
	sem_sm1.dta{col 30}{stata "use http://www.stata-press.com/data/r12/sem_sm1.dta":use} | {stata "describe using  http://www.stata-press.com/data/r12/sem_sm1.dta":describe}

{hline}

    {title:Example 9 - Structural model with measurement component}
	sem_sm2.dta{col 30}{stata "use http://www.stata-press.com/data/r12/sem_sm2.dta":use} | {stata "describe using  http://www.stata-press.com/data/r12/sem_sm2.dta":describe}

{hline}

    {title:Example 10 - MIMIC model}
	sem_mimic1.dta{col 30}{stata "use http://www.stata-press.com/data/r12/sem_mimic1.dta":use} | {stata "describe using  http://www.stata-press.com/data/r12/sem_mimic1.dta":describe}

{hline}

    {title:Example 11 - estat framework}
	sem_mimic1.dta{col 30}{stata "use http://www.stata-press.com/data/r12/sem_mimic1.dta":use} | {stata "describe using  http://www.stata-press.com/data/r12/sem_mimic1.dta":describe}

{hline}

    {title:Example 13 - Equation-level Wald test}
	auto.dta{col 30}{stata "use http://www.stata-press.com/data/r12/auto.dta":use} | {stata "describe using  http://www.stata-press.com/data/r12/auto.dta":describe}

{hline}

    {title:Example 14 - Predicted values}
	sem_1fmm.dta{col 30}{stata "use http://www.stata-press.com/data/r12/sem_1fmm.dta":use} | {stata "describe using  http://www.stata-press.com/data/r12/sem_1fmm.dta":describe}

{hline}

    {title:Example 15 - Higher-order CFA}
	sem_hcfa1.dta{col 30}{stata "use http://www.stata-press.com/data/r12/sem_hcfa1.dta":use} | {stata "describe using  http://www.stata-press.com/data/r12/sem_hcfa1.dta":describe}

{hline}

    {title:Example 16 - Correlation}
	census13.dta{col 30}{stata "use http://www.stata-press.com/data/r12/census13.dta":use} | {stata "describe using  http://www.stata-press.com/data/r12/census13.dta":describe}

{hline}

    {title:Example 17 - Correlated uniqueness model}
	sem_cu1.dta{col 30}{stata "use http://www.stata-press.com/data/r12/sem_cu1.dta":use} | {stata "describe using  http://www.stata-press.com/data/r12/sem_cu1.dta":describe}

{hline}

    {title:Example 18 - Latent growth model}
	sem_lcm.dta{col 30}{stata "use http://www.stata-press.com/data/r12/sem_lcm.dta":use} | {stata "describe using  http://www.stata-press.com/data/r12/sem_lcm.dta":describe}

{hline}

    {title:Example 20 - Two-factor measurement model by group}
	sem_2fmmby.dta{col 30}{stata "use http://www.stata-press.com/data/r12/sem_2fmmby.dta":use} | {stata "describe using  http://www.stata-press.com/data/r12/sem_2fmmby.dta":describe}

{hline}

    {title:Example 21 - Group-level goodness of fit}
	sem_2fmmby.dta{col 30}{stata "use http://www.stata-press.com/data/r12/sem_2fmmby.dta":use} | {stata "describe using  http://www.stata-press.com/data/r12/sem_2fmmby.dta":describe}

{hline}

    {title:Example 22 - Testing parameter equality across groups}
	sem_2fmmby.dta{col 30}{stata "use http://www.stata-press.com/data/r12/sem_2fmmby.dta":use} | {stata "describe using  http://www.stata-press.com/data/r12/sem_2fmmby.dta":describe}

{hline}

    {title:Example 23 - Specifying parameter constraints across groups}
	sem_2fmmby.dta{col 30}{stata "use http://www.stata-press.com/data/r12/sem_2fmmby.dta":use} | {stata "describe using  http://www.stata-press.com/data/r12/sem_2fmmby.dta":describe}

{hline}

    {title:Example 24 - Reliability}
	sem_rel.dta{col 30}{stata "use http://www.stata-press.com/data/r12/sem_rel.dta":use} | {stata "describe using  http://www.stata-press.com/data/r12/sem_rel.dta":describe}

{hline}

    {title:Example 26 - Fitting a model using data missing at random}
	cfa_missing.dta{col 30}{stata "use http://www.stata-press.com/data/r12/cfa_missing.dta":use} | {stata "describe using  http://www.stata-press.com/data/r12/cfa_missing.dta":describe}

{hline}

{p 4 4 2}
StataCorp gratefully acknowledges that some datasets in the Reference
 Manuals are proprietary and have been used in our printed documentation
  with the express permission of the copyright holders. If any copyright
 holder believes that by making these datasets available to the public,
 StataCorp is in violation of the letter or spirit of any such agreement,
 please contact {browse "mailto:tech-support@stata.com":tech-support@stata.com}
 and any such materials will be removed from this webpage.
{p_end}
