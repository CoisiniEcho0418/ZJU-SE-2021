{smcl}
{* *! version 1.0.5  11feb2011}{...}
{vieweralsosee undocumented "help undocumented"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-2] graph" "help graph"}{...}
{vieweralsosee "[P] _natscale" "help _natscale"}{...}
{viewerjumpto "Syntax" "_tsnatscale##syntax"}{...}
{viewerjumpto "Description" "_tsnatscale##description"}{...}
{viewerjumpto "Saved results" "_tsnatscale##saved_results"}{...}
{title:Title}

{p 4 21 2}
{hi:[P] _tsnatscale} {hline 2} Obtain nice label or tick values for time series


{marker syntax}{...}
{title:Syntax}

{p 8 20 2}
{cmd:_tsnatscale} {it:#_min} {it:#_max} {it:#_n}{cmd:,}{break}
{ {cmdab:d:aily} | {cmdab:w:eekly} | {cmdab:m:onthly} | {cmdab:q:uarterly} |
{cmdab:h:alfyearly} | {cmdab:y:early} }


{marker description}{...}
{title:Description}

{pstd}
{cmd:_tsnatscale} returns in {cmd:r()} "nice" values for labeling or ticking of
the range {it:#_min} to {it:#_max} in approximately {it:#_n} steps. The unit
of time that represents the range is taken into account to choose tick values
that fall on "nice" time boundaries.


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:_tsnatscale} returns in {cmd:r()}

	scalar {cmd:r(n)}            number of values chosen
	scalar {cmd:r(min)}          first value to label or tick
	scalar {cmd:r(max)}          last  value to label or tick
	scalar {cmd:r(delta)}        ({cmd:r(max)}-{cmd:r(min)})/{cmd:r(n)})
	scalar {cmd:r(list)}         ({cmd:for Daily and Weekly})

{pstd}
For saved results, you will either be presented with {cmd:r(delta)}, if the
ticks are a fixed distance between each other, such as with years, or you will
be presented with {cmd:r(list)}, which is a list of tick values. For example,
{cmd:r(list)} is necessary when tick values are measured in days, but ticked
on monthly boundaries.

{pstd}
The values to tick (if {cmd:r(delta)} is present) are
{cmd:r(min)},
{cmd:r(min)}+{cmd:r(delta)},
{cmd:r(min)}+2*{cmd:r(delta)},
...,
{cmd:r(min)}+({cmd:r(n)}-1)*{cmd:r(delta)}.

{pstd}
Otherwise, values to tick (if {cmd:r(list)} is present) are the values
contained in {cmd:r(list)}.
{p_end}
