{smcl}
{* *! version 1.1.2  11feb2011}{...}
{vieweralsosee "[P] makecns" "mansection P makecns"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] constraint" "help constraint"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] cnsreg" "help cnsreg"}{...}
{vieweralsosee "[P] ereturn" "help ereturn"}{...}
{vieweralsosee "[P] macro (local)" "help local"}{...}
{vieweralsosee "[P] matrix" "help matrix"}{...}
{vieweralsosee "[P] matrix get" "help get()"}{...}
{vieweralsosee "[R] ml" "help ml"}{...}
{viewerjumpto "Syntax" "makecns##syntax"}{...}
{viewerjumpto "Description" "makecns##description"}{...}
{viewerjumpto "Options" "makecns##options"}{...}
{viewerjumpto "Example" "makecns##example"}{...}
{viewerjumpto "Saved results" "makecns##saved_results"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col :{manlink P makecns} {hline 2}}Constrained estimation{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

    Build constraints

{p 8 15 2}
{cmd:makecns}
	[{it:clist}|{it:matname}]
	[{cmd:,} {it:options}]


    Create constraint matrix 

{p 8 15 2}
{cmd:matcproc} {it:T a C}


{phang}
where {it:clist} is a list of constraint numbers, separated by commas or
dashes; {it:matname} is an existing matrix representing the constraints and
must have one more column than the {hi:e(b)} and {hi:e(V)} matrices.

{phang}
{it:T}, {it:a}, and {it:C} are names of new or existing matrices.

{synoptset 12}{...}
{synopthdr}
{synoptline}
{synopt:{opt nocnsnote:s}}do not display notes when constraints are dropped{p_end}
{synopt:{opt di:splaycns}}display the system-stored constraint matrix{p_end}
{synopt:{opt r}}return the accepted constraints in {hi:r()}; this option overrides {opt displaycns}{p_end}
{synoptline}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
{cmd:makecns} is a programmer's command that facilitates adding constraints to
estimation commands.

{pstd}
{cmd:makecns} will create a constraint matrix and displays a note for each
constraint that is dropped because of an error.  The constraint matrix
is stored in {hi:e(Cns)}.

{pstd}
{cmd:matcproc} returns matrices helpful for performing constrained estimation,
including the constraint matrix.

{pstd}
If your interest is simply in using constraints in a command that supports
constrained estimation, see {manhelp constraint R}.


{marker options}{...}
{title:Options}

{phang}
{cmd:nocnsnotes} prevents notes from being displayed when constraints are
dropped.

{phang}
{cmd:displaycns} displays the system-stored constraint matrix in readable
form.

{phang}
{cmd:r} returns the accepted constraints in {cmd:r()}.  This option overrides
{cmd:displaycns}.


{marker example}{...}
{title:Example}

{pstd}
Here is an outline for programs to perform constrained estimation using
{cmd:makecns}:

{cmd}{...}
	program {it:myest}, eclass properties(...)
		version {ccl stata_version}
		if replay() {	// {it:replay the results}
			if ("`e(cmd)'" != "{it:myest}") error 301
			syntax [, Level(cilevel) ]
                        makecns , displaycns
		}
		else {		// {it:fit the model}
			syntax {it:whatever} [,			     ///
				{it:whatever}			     ///
				Constraints(string)	    	///
				Level(cilevel)			///
			]
			// {it:any other parsing of the user's estimate request}
			tempname b V C T a bc Vc
			local p={it:number of parameters}
			// {it:define the model} ({it:set the row and column}
			// {it:names}) {it:in `b'}
			if "`constraints'" != "" {
				matrix `V' = `b''*`b'
				ereturn post `b' `V'	// {it:a dummy solution}
				makecns `constraints', display
				matcproc `T' `a' `C'
				// {it:obtain solution in `bc' and `Vc'}
				matrix `b' = `bc'*`T' + `a'
				matrix `V' = `T'*`Vc'*`T''	// {it:note prime}
				ereturn post `b' `V' `C', {it:options}
			}
			else {
				// {it:obtain standard solution in `b' and `V'}
				ereturn post `b' `V', {it:options}
			}
			// {it:store whatever else you want in e}()
			ereturn local cmd "{it:myest}"
		}
		// {it:output any header above the coefficient table}
		ereturn display, level(`level')
	end
{reset}{txt}{...}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:makecns} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(k_autoCns)}}number of base, empty, and omitted constraints{p_end}

{p2col 5 15 19 2: Macro}{p_end}
{synopt:{cmd:r(clist)}}constraints used (numlist or matrix name){p_end}
{p2colreset}{...}
