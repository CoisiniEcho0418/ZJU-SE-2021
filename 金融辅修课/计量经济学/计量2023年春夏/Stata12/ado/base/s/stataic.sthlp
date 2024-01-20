{smcl}
{* *! version 1.3.2  21jun2011}{...}
{vieweralsosee "[R] about" "help about"}{...}
{vieweralsosee "[D] data types" "help data_types"}{...}
{vieweralsosee "[R] matsize" "help matsize"}{...}
{vieweralsosee "[D] memory" "help memory"}{...}
{vieweralsosee "[R] set" "help set"}{...}
{vieweralsosee "[U] 5 Flavors of Stata" "help flavors"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "limits" "help limits"}{...}
{vieweralsosee "Small Stata" "help small_stata"}{...}
{vieweralsosee "Stata/MP" "help statamp"}{...}
{vieweralsosee "Stata/SE" "help statase"}{...}
{viewerjumpto "Using Stata/IC" "stataic##use"}{...}
{viewerjumpto "Contents" "stataic##contents"}{...}
{marker use}{...}
{title:Using Stata/IC}

{pstd}
There are four flavors of Stata:

{col 13}Flavor{col 29}Description
{col 13}{hline 47}
{col 13}{bf:Small Stata}{col 29}for undergraduate students
{col 10}-> {bf:Stata/IC}{col 29}standard version 
{col 13}{bf:Stata/SE}{col 29}Stata/IC + large datasets
{col 13}{bf:Stata/MP}{col 29}Stata/SE + parallel processing
{col 13}{hline 47}
{col 13}See {bf:{help flavors:[U] 5 Flavors of Stata}} for descriptions

{pstd}
To determine which flavor of Stata you are running, type

	    {cmd:. about}

{pstd}
If you are using a different flavor of Stata, click on the appropriate
link:  

{col 13}{hline 47}
{col 13}{bf:{help small_stata:Small Stata}}{col 29}Using Small Stata
{col 13}{bf:{help statase:Stata/SE}}{col 29}Using Stata/SE
{col 13}{bf:{help statamp:Stata/MP}}{col 29}Using Stata/MP
{col 13}{hline 47}

{pstd}
For information on upgrading to Stata/IC, Stata/SE or Stata/MP, point your
browser to {browse "http://www.stata.com"}.


{marker contents}{...}
{title:Contents}

	1.  {help stataic##starting:Starting Stata/IC}

	2.  {help stataic##setting:Setting Stata/IC's limits}
	    2.1 {help stataic##matsize:Advice on setting matsize}

	3.  {help stataic##dta:Sharing .dta datasets with non-IC users}

	4.  {help stataic##query:Querying memory usage}

	5.  {help stataic##programming:Advice to programmers:  Determining flavor}



{marker starting}{...}
{title:1.  Starting Stata/IC}

{pstd}
You start Stata/IC as follows:

{p 8 12 4}
    Windows:{break}
	Select {bf:Start > Programs > Stata > Stata {ccl stata_version}}

{p 8 12 4}
    Mac:{break}
        Double-click the file {hi:Stata.do} from the {hi:data} folder, or
        double-click the {hi:Stata} icon from the {hi:Stata} folder.

{p 8 12 4}
    Unix:{break}
	At the Unix command prompt, type {cmd:xstata} to invoke the
	GUI version of Stata/IC, or type {cmd:stata} to invoke the
	console version.


{marker setting}{...}
{title:2.  Setting Stata/IC's limits}

{pstd}
The two limits for Stata/IC are as follows:

{p 8 16 4}
    1.  {cmd:maxvar}{break}
	    The maximum number of variables allowed in a dataset.
	    This limit is set to 2,047 and cannot be reset.

{p 8 16 4}
   2.  {cmd:matsize}{break}
	    The maximum size of matrices, or said differently, the
	    maximum number of independent variables allowed in the models that
	    you fit.  This limit is initially set to 400, and you can
	    increase it up to 800.

{pstd}
You set the limit by using the

	    {cmd:set matsize}   {it:#}          [{cmd:,} {cmdab:perm:anently}]

{pstd}
command.  For instance, you might type

	    {cmd:. set matsize 500}

{pstd}
If you specify the {cmd:permanently} option when you set a limit, in addition
to making the change for the present session, Stata/IC will remember the new
limit and use it in the future when you invoke Stata/IC:

	    {cmd:. set matsize 500, permanently}

{pstd}
You can reset the present or permanent limit whenever and as often as you
wish.


{marker matsize}{...}
{title:2.1  Advice on setting matsize}

	    {cmd:set matsize} {it:#} [{cmd:,} {cmdab:perm:anently}]{right:10 <= {it:#} <= 800       }


{pstd}
The name {cmd:matsize} is unfortunate because it suggests something that is
only partially true.  It suggests that the maximum size of matrices is
{cmd:matsize} {it:x} {cmd:matsize}.  {cmd:matsize}, however, is 
irrelevant for the size of matrices in Mata, Stata's modern matrix-programming
language.  Regardless of the value of {cmd:matsize}, Mata
matrices be larger or smaller than that.

{pstd}
{cmd:matsize} specifies the maximum size of matrices in Stata's old matrix
language -- and that is not of great importance -- and it specifies the
maximum number of variables that may appear in Stata's estimation commands --
and that is important.  A better name for {cmd:matsize} would be
{cmd:modelsize}.

{pstd}
With that introduction, let us begin.

{pstd}
The value of
{cmd:matsize} has a dramatic effect on memory usage, the formula being

{center:Number of megabytes = (8*{cmd:matsize}^2 + 88*{cmd:matsize})/(1024^2)}

{pstd}
For instance, 

{center:{c TLC}{hline 11}{c TT}{hline 14}{c TRC}}
{center:{c |}  {cmd:matsize}  {c |}  memory use  {c |}}
{center:{c LT}{hline 11}{c +}{hline 14}{c RT}}
{center:{c |}       40  {c |}       .015M  {c |}}
{center:{c |}      100  {c |}       .084M  {c |}}
{center:{c |}      200  {c |}       .322M  {c |}}
{center:{c |}      400  {c |}      1.254M  {c |}}
{center:{c |}      800  {c |}      4.950M  {c |}}
{center:{c BLC}{hline 11}{c BT}{hline 14}{c BRC}}

{pstd}
The formula, in fact, understates the amount of memory certain
Stata commands use and understates what you will use
yourself if you use Stata's old matrix language matrices directly.  The
formula gives the amount of memory required for one matrix and 11 vectors.  If
two matrices are required, the numbers above are nearly doubled.

{pstd}
Choose a reasonable value given the kinds of models
you fit.


{marker dta}{...}
{title:3.  Sharing .dta datasets with non-IC users}

{pstd}
You may share datasets with Stata/SE and Stata/MP users with no changes 
necessary.

{pstd}
You may share datasets with Small Stata users as long as your dataset does not
have more variables or observations than are allowed in Small Stata; see
{help limits}.


{marker query}{...}
{title:4.  Querying memory usage}

{pstd}
The command

	    {cmd:. memory}

{pstd}
will display the current memory report and the command 

	    {cmd:. query memory}

{pstd}
will display the current memory settings.
See {help memory:help memory}.


{marker programming}{...}
{title:5.  Advice to programmers:  Determining flavor}

{pstd}
Programmers can determine which flavor of Stata is running by 
examining the {help creturn} values

		                 creturn values
                        {c |} {cmd:c(flavor)   c(SE)     c(MP)}
	    {hline 12}{c +}{hline 30}
	    Small Stata {c |}  "{cmd:Small}"      0         0
	    Stata/IC    {c |}  "{cmd:IC}"         0         0
	    Stata/SE    {c |}  "{cmd:IC}"         1         0
	    Stata/MP    {c |}  "{cmd:IC}"         1         1
	    {hline 12}{c BT}{hline 30}
