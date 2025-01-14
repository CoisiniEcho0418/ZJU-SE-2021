{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-3] mata describe" "mansection M-3 matadescribe"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-5] sizeof()" "help mf_sizeof"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-3] intro" "help m3_intro"}{...}
{viewerjumpto "Syntax" "mata_describe##syntax"}{...}
{viewerjumpto "Description" "mata_describe##description"}{...}
{viewerjumpto "Option" "mata_describe##option"}{...}
{viewerjumpto "Remarks" "mata_describe##remarks"}{...}
{viewerjumpto "Diagnostics" "mata_describe##diagnostics"}{...}
{title:Title}

{phang}
{manlink M-3 mata describe} {hline 2} Describe contents of Mata's memory


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
: {cmd:mata} {cmdab:d:escribe} 
[{it:namelist}] 
[{cmd:,} 
{cmd:all} 
]

{p 8 16 2}
: {cmd:mata} {cmdab:d:escribe} 
{cmd:using} {it:libname}


{p 4 4 2}
where {it:namelist} is as defined in 
{bf:{help m3_namelists:[M-3] namelists}}.
If {it:namelist} is not specified, "{cmd:*} {cmd:*()}" is assumed.

{p 4 4 2}
This command is for use in Mata mode following Mata's colon prompt.
To use this command from Stata's dot prompt, type

		. {cmd:mata: mata describe} ...


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:mata} {cmd:describe} 
lists the names of the matrices and functions in memory, including 
the amount of memory consumed by each.

{p 4 4 2}
{cmd:mata} {cmd:describe} {cmd:using} {it:libname}
describes the contents of the specified {cmd:.mlib} library; 
see {bf:{help mata_mlib:[M-3] mata mlib}}.


{marker option}{...}
{title:Option}

{p 4 8 2}
{cmd:all} specifies that automatically loaded library functions that 
happen to be in memory are to be included in the output.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
{cmd:mata describe} is often issued without arguments, and then
everything in memory is described:

	: {cmd:mata describe}

	      {txt}# bytes   type                        name and extent
	{hline 69}
	{res}           50   {txt}real matrix                 {res}foo{txt}()
	{res}        1,600   {txt}real matrix                 {res}X{txt}[10,20]
	{res}            8   {txt}real scalar                 {res}x
	{txt}{hline 69}

{p 4 4 2}
{cmd:mata describe using} {it:libname} lists the functions stored in a
{helpb mata_mlib:.mlib} library:

	: {cmd:mata describe using lmatabase}

	      {txt}# bytes   type                        name and extent
	{hline 69}
	{res}          984   {txt}auto numeric vector         {res}Corr{txt}()
	{res}          340   {txt}auto real matrix            {res}Hilbert{txt}()
	{it:(output omitted)}
	{res}          528   {txt}auto transmorphic colvector {res}vech{txt}()
	
	{txt}{hline 69}


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
The reported memory usage does not include overhead, which usually amounts 
to 64 bytes, but can be less (as small as zero for recently 
used scalars).

{p 4 4 2}
The reported memory usage in the case of pointer matrices reflects the 
memory used to store the matrix itself and does not include memory 
consumed by siblings.
{p_end}
