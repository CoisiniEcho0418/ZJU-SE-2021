{smcl}
{* *! version 1.3.1  11feb2011}{...}
{vieweralsosee "[ST] epitab" "mansection ST epitab"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[ST] stcox" "help stcox"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] bitest" "help bitest"}{...}
{vieweralsosee "[R] ci" "help ci"}{...}
{vieweralsosee "[R] clogit" "help clogit"}{...}
{vieweralsosee "[R] dstdize" "help dstdize"}{...}
{vieweralsosee "[R] glogit" "help glogit"}{...}
{vieweralsosee "[R] logistic" "help logistic"}{...}
{vieweralsosee "[R] poisson" "help poisson"}{...}
{vieweralsosee "[R] symmetry" "help symmetry"}{...}
{vieweralsosee "[R] tabulate twoway" "help tabulate_twoway"}{...}
{vieweralsosee "[U] 19 Immediate command" "help immed"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col :{manlink ST epitab} {hline 2}}Tables for epidemiologists{p_end}
{p2colreset}{...}


{title:Description}

{pstd}
To calculate appropriate statistics and suppress inappropriate statistics, the
{cmd:ir}, {cmd:cs}, {cmd:cc}, {cmd:tabodds}, {cmd:mhodds}, and {cmd:mcc}
commands, along with their immediate counterparts, are organized in the way
epidemiologists conceptualize data. {cmd:ir} processes incidence-rate data
from prospective studies; {cmd:cs}, cohort study data with equal follow-up
time (cumulative incidence); {cmd:cc}, {cmd:tabodds}, and {cmd:mhodds},
case-control or cross-sectional (prevalence) data; and {cmd:mcc}, matched
case-control data.  With the exception of {cmd:mcc}, these commands work with
both simple and stratified tables.

{pstd}
Epidemiological data are often summarized in a contingency table from which
various statistics are calculated.  The rows of the table reflect cases and
noncases or cases and person-time, and the columns reflect exposure to a risk
factor.  To an epidemiologist, cases and noncases refer to the outcomes of the
process being studied.  For instance, a case might be a person with cancer and
a noncase a person without cancer.

{pstd}
A factor is something that might affect the chances of being ultimately
designated a case or a noncase.  Thus, a case might be a cancer patient and
the factor, smoking behavior.  A person is said to be exposed or unexposed to
the factor.  Exposure can be classified as a dichotomy, smokes or does not
smoke, or as multiple levels, such as number of cigarettes smoked per week.


            Cohort studies
                {helpb ir:ir and iri}
                {helpb cs:cs and csi}

            Case-control studies
                {helpb cc:cc and cci}
                {helpb tabodds}
                {helpb mhodds}

            Matched case-control studies
                {helpb mcc:mcc and mcci}
