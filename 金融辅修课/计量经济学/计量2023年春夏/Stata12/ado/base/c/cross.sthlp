{smcl}
{* *! version 1.1.4  11feb2011}{...}
{viewerdialog cross "dialog cross"}{...}
{vieweralsosee "[D] cross" "mansection D cross"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] append" "help append"}{...}
{vieweralsosee "[D] fillin" "help fillin"}{...}
{vieweralsosee "[D] joinby" "help joinby"}{...}
{vieweralsosee "[D] merge" "help merge"}{...}
{vieweralsosee "[D] save" "help save"}{...}
{viewerjumpto "Syntax" "cross##syntax"}{...}
{viewerjumpto "Description" "cross##description"}{...}
{viewerjumpto "Remarks" "cross##remarks"}{...}
{viewerjumpto "Example" "cross##example"}{...}
{title:Title}

{p2colset 5 18 20 2}{...}
{p2col :{manlink D cross} {hline 2}}Form every pairwise combination of two
datasets{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

	{cmd:cross} {cmd:using} {it:{help filename}}


{title:Menu}

{phang}
{bf:Data > Combine datasets > Form every pairwise combination of two datasets}


{marker description}{...}
{title:Description}

{pstd}
{opt cross} forms every pairwise combination of the data in memory with the
data in {it:{help filename}}.  If {it:filename} is specified without a suffix,
{opt .dta} is assumed.  


{marker remarks}{...}
{title:Remarks}

{pstd}
This command is rarely used; also see {manhelp joinby D}, {manhelp merge D},
and {manhelp append D}.

{pstd}
Crossing refers to merging two datasets in every way possible.  That is, the
first observation of the data in memory is merged with every observation of
{it:filename}, followed by the second, and so on.  Thus the result will have
N_1 N_2 observations, where N_1 and N_2 are the number of observations in
memory and in {it:filename}, respectively.

{pstd}
Typically, the datasets will have no common variables.  If they do, such
variables will take on only the values of the data in memory.


{marker example}{...}
{title:Example}

{pstd}Create {cmd:sex} dataset{p_end}

        {cmd:. input str6 sex}

                   sex
          1.  {cmd:male}
          2.  {cmd:female}
          3.  {cmd:end}

{pstd}Save {cmd:sex} dataset{p_end}
{phang2}{cmd:. save sex}

{pstd}Drop data from memory{p_end}
{phang2}{cmd:. drop _all}

{pstd}Create {cmd:agecat} dataset{p_end}

        {cmd:. input agecat}

                   agecat
          1.  {cmd:20}
          2.  {cmd:30}
          3.  {cmd:40}
          4.  {cmd:end}

{pstd}Form every pairwise combination of {cmd:agecat} with {cmd:sex}{p_end}
{phang2}{cmd:. cross using sex}

{pstd}List results{p_end}
{phang2}{cmd:. list}{p_end}
