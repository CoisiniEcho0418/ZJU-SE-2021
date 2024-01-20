{smcl}
{* *! version 1.1.16  14apr2011}{...}
{vieweralsosee "[R] about" "help about"}{...}
{vieweralsosee "[D] compress" "help compress"}{...}
{vieweralsosee "[D] data types" "help data_types"}{...}
{vieweralsosee "[D] import" "help import"}{...}
{vieweralsosee "[D] infile (fixed format)" "help infile2"}{...}
{vieweralsosee "[D] infile (free format)" "help infile1"}{...}
{vieweralsosee "[R] matsize" "help matsize"}{...}
{vieweralsosee "[D] memory" "help memory"}{...}
{vieweralsosee "[D] obs" "help obs"}{...}
{viewerjumpto "Maximum size limits" "limits##size"}{...}
{viewerjumpto "Notes" "limits##notes"}{...}
{viewerjumpto "Matrix size" "limits##matsize"}{...}
{viewerjumpto "Determining which flavor of Stata you are running" "limits##about"}{...}
{marker size}{...}
{title:Maximum size limits}

					                         {help statamp:Stata/MP} and
					  Small       {help stataic:Stata/IC}       {help SpecialEdition:Stata/SE}
{hline}
   # of observations  (1)                 1,200  2,147,483,647  2,147,483,647
   # of variables                            99          2,047         32,767
   width of a dataset in bytes              800         24,564        393,192

   value of {helpb matsize}                         100            800         11,000

   # characters in a command              8,697        165,216      1,081,527
   # options for a command                   70             70             70

   # of elements in a {it:{help numlist}}             1,600          1,600          1,600

   # of interacted continuous variables       8              8              8
   # of interacted factor variables           8              8              8

   # of unique time-series operators in
       a command                            100            100            100
   # seasonal suboperators per time-series
       operator                               8              8              8

   # of dyadic operators in an expression    66            800            800
   # of numeric literals in an expression    50            300            300
   # of string literals in an expression    256            512            512
   length of string in string expression    244            244            244
   # of sum functions in an expression        5              5              5
   # of pairs of nested parentheses         249            249            249

   # of characters in a macro             8,681        165,200      1,081,511

   # of nested do-files                      64             64             64

   # of lines in a program                3,500          3,500          3,500
   # of characters in a program         135,600        135,600        135,600

   length of a variable name                 32             32             32
   length of ado-command name                32             32             32
   length of a global macro name             32             32             32
   length of a local macro name              31             31             31

   length of a string variable              244            244            244

   {helpb anova}
       # of variables in one {cmd:anova} term       8              8              8
       # of terms in the {cmd:repeated()} option    4              4              4

   {helpb char}
       length of one characteristic       8,681         67,784         67,784

   {helpb constraint}
       # of constraints                   1,999          1,999          1,999

   {helpb encode} and {helpb decode}
       # of unique values                 1,000         65,536         65,536

   {helpb _estimates} {cmd:hold}
       # of stored estimation results       300            300            300

   {helpb estimates} {cmd:store}
       # of stored estimation results       300            300            300

   {helpb exlogistic} and {helpb expoisson}
       maximum memory specification in      2gb            2gb            2gb
       {opt memory(#)}

   {helpb grmeanby}
       # of unique values in {varlist}       _N/2           _N/2           _N/2

   {helpb graph twoway}
       # of variables in a plot             100            100            100
       # of styles in an option's stylelist  20             20             20

   {helpb impute}
       # of variables in {varlist}             31             31             31

   {helpb infile}
       record length without dictionary    none           none           none
       record length with a dictionary  524,275        524,275        524,275

   {helpb infix}
       record length with a dictionary  524,275        524,275        524,275

   {helpb label}
       length of dataset label               80             80             80
       length of variable label              80             80             80
       length of value label string      32,000         32,000         32,000
       length of name of value label         32             32             32
       # of codings within one
	   value label                    1,000         65,536         65,536

   {helpb label language}
       # of different languages             100            100            100

   {help macros}
       # of nested macros                    20             20             20

   {helpb manova}
       # of variables in single {cmd:manova} term   8              8              8

   {helpb matrix}  (2)
       dimension of single matrix       40 x 40      800 x 800  11,000x11,000

   {help maximize} options
       {cmd:iterate()} maximum                 16,000         16,000         16,000

   {helpb mprobit}
       # of categories in a {depvar}           30             30             30

   {helpb net} (also see {helpb usersite})
       # of description lines in .pkg file  100            100            100

   {helpb nlogit} and {helpb nlogittree}
       # of levels in model                   8              8              8

   {helpb notes}
       length of one note                 8,681         67,784         67,784
       # of notes attached to _dta        9,999          9,999          9,999
       # of notes attached to each
	   variable                       9,999          9,999          9,999

   {it:{help numlist}}
       # of elements in the numeric list  1,600          1,600          1,600

   {helpb reg3}, {helpb sureg}, and other system estimators
       # of equations                        40            800         11,000

   {cmd:set} {helpb adosize}
       memory ado-files may consume       1000K          1000K          1000K

   {cmd:set} {helpb scrollbufsize}
       memory for Results window buffer   2000K          2000K          2000k

   {helpb slogit}
       # of categories in a {depvar}           30             30             30

   {helpb snapshot}
       length of label                       80             80             80
       # of saved snapshots               1,000          1,000          1,000

   {helpb stcox}
       # of variables in {cmd:strata()} option      5              5              5

   {helpb stcurve}
       # of curves plotted on the same graph 10             10             10

   {helpb table} and {helpb tabdisp}
       # of by variables                      4              4              4
       # of margins, i.e., sum of rows,
	 columns, supercolumns, and
	 by groups                        3,000          3,000          3,000

   {helpb tabulate}  
       # of rows in one-way table           500          3,000         12,000
       # of rows & cols in two-way table 160x20         300x20       1,200x80

   {cmd:tabulate, summarize} (see {helpb tabsum})
       # of cells (rows X cols)             375            375            375

   {cmd:xt} estimation commands (e.g., {helpb xtgee},
       {helpb xtgls}, {helpb xtpoisson}, {helpb xtprobit}, {helpb xtreg}
       with {cmd:mle} option, and {helpb xtpcse} when
       neither option {cmd:hetonly} nor option
       {cmd:independent} is specified)

       # of time periods within panel        40            800         11,000
       # of integration points accepted      40            800         11,000
         by {opt intpoints(#)}                    195            195            195
{hline}


{marker notes}{...}
{title:Notes}

{p 4 8 2}(1)  2,147,483,647 is a theoretical maximum; memory availability will
certainly impose a smaller maximum.

{p 4 8 2}(2)  In Mata, matrices are limited only by the amount of memory on your
               computer.


{marker matsize}{...}
{title:Matrix size}

{p 4 4 2}See {helpb matsize}.


{marker about}{...}
{title:Determining which flavor of Stata you are running}

    Type

	    {cmd:. about}

{p 4 4 2}
The response will be Stata/MP, Stata/SE, Stata/IC, or Small Stata.
Other information is also shown, including your serial number.
See {helpb about}.
{p_end}
