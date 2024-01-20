{* *! version 1.0.2  03apr2011}{...}
{opth conditional(if)} specifies that imputation variable be
imputed conditionally on observations satisfying {it:{help if:exp}}.  That is,
missing values in a conditional sample, the sample identified by the
{it:exp} expression, are imputed based only on data in that conditional
sample.  Missing values outside the conditional sample are replaced with a
conditional constant, the value of the imputation variable in observations
outside the conditional sample.  As such, the imputation variable is required
to be constant outside the conditional sample.  Also, if any conditioning
variables (variables involved in the conditional specification {cmd:if}
{it:exp}) contain soft missing values ({cmd:.}), their missing values must be
nested within missing values of the imputation variable.  See 
{mansection MI miimputeRemarksConditionalimputation:{it:Conditional imputation}} under {it:Remarks} in {bf:[MI] mi impute}.
