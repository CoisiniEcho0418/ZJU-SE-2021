{smcl}
{* *! version 1.0.0  07jul2011}{...}
{vieweralsosee "[SEM] sem option covstructure()" "mansection SEM semoptioncovstructure()"}{...}
{findalias assemcu}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SEM] sem" "help sem_command"}{...}
{vieweralsosee "[SEM] sem path notation" "help sem_path_notation"}{...}
{vieweralsosee "[SEM] sem postestimation" "help sem_postestimation"}{...}
{viewerjumpto "Syntax" "sem_option_covstructure##syntax"}{...}
{viewerjumpto "Description" "sem_option_covstructure##description"}{...}
{viewerjumpto "Option" "sem_option_covstructure##option"}{...}
{viewerjumpto "Remarks" "sem_option_covstructure##remarks"}{...}
{viewerjumpto "Examples" "sem_option_covstructure##examples"}{...}
{title:Title}

{p2colset 5 40 42 2}{...}
{p2col:{manlink SEM sem option covstructure()} {hline 2}}Specifying covariance
restrictions{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{cmd:sem} {cmd:... }[{cmd:, ...} {opt covstr:ucture(variables, structure)} 
{cmd: ... }]

{p 8 12 2}
{cmd:sem} {cmd:... }[{cmd:, ...} {cmdab:covstr:ucture(}{it:groupid: variables, structure}{cmd:)} {cmd: ... }]

{phang}
where {it:variables} is one of 

{p 8 12 2}
1.  a list of (a subset of the) exogenous variables in your model,
for example,{p_end}

{p 12 14 2}       
{cmd:. sem ..., ... covstruct(x1 x2, }{it: structure}{cmd:)}{p_end}
                            
{p 8 12 2}
2.  {opt _OEx}, meaning all observed exogenous variables in your model{p_end}
        
{p 8 12 2}
3.  {opt _LEx}, meaning all latent exogenous variables in your model{p_end}

{p 8 12 2}
4.  {opt _Ex}, meaning all exogenous variables in your model{p_end}

{phang}
or where {it:variables} is one of
                                
{p 8 12 2}
1.  a list of (a subset of the) error variables in your model, for example,
{p_end}
        
{p 12 14 2}       
{cmd:. sem ..., ... covstruct(e.y1 e.y2 e.Aspect,}
{it:structure}{cmd:)}{p_end}

{p 8 12 2}
2.  {opt e._OEn}, meaning all error variables associated with observed
endogenous variables in your model{p_end}

{p 8 12 2}
3.  {opt e._LEn}, meaning all error variables associated with latent
endogenous variables in your model{p_end}

{p 8 12 2}
4.  {opt e._En}, meaning all error variables in your model{p_end}

{phang}
and where {it:structure} is

{p2colset 8 30 32 2}{...}
{p2col:{it:structure}}Description{p_end}
{p2line}
{p2col :{opt diag:onal}}all variances unrestricted{p_end}
{p2col: }all covariances fixed at 0{p_end}

{p2col :{opt un:structured}}all variances unrestricted {p_end}
{p2col: }all covariances unrestricted{p_end}

{p2col :{opt id:entity}}all variances equal{p_end}
{p2col: }all covariances fixed at 0{p_end}

{p2col :{opt ex:changeable}}all variances equal{p_end}
{p2col: }all covariances equal{p_end}

{p2col :{opt zero}}all variances fixed at 0{p_end}
{p2col: }all covariances fixed at 0{p_end}

{p2col :* {opth pat:tern(matname)}}covariances (variances) unrestricted if
matname[i,j] {ul:>} {cmd:.} {p_end}
{p2col: }covariances (variances) equal if matname[i,j] = matname[k,l]{p_end}

{p2col :+ {opth fix:ed(matname)}}covariances (variances) unrestricted if
matname[i,j] {ul:>} {cmd:.} {p_end}
{p2col: }covariances (variances) fixed at matname[i,j] otherwise{p_end}
{p2line}
{p2colreset}{...}
{p 6 10 2}(*) Only elements in the lower triangle of matname are used.  All
values in matname are interpreted as the {helpb floor()} of the value if
noninteger values appear.  Row and column stripes of matname are ignored.

{p 6 10 2}(+) Only elements on the lower triangle of matname are used.  Row and
column stripes of matname are ignored.

{pstd}
{it:groupid} may be specified only when option {opt group()} is also
specified, and even then it is optional; see 
{helpb sem_group_options:[SEM] sem group options}.


{marker description}{...}
{title:Description}

{pstd}
{cmd:sem} option {opt covstructure()} provides a convenient way to constrain
the covariances of your model. 

{pstd}
Alternatively or in combination, you can place constraints on the
covariances using the standard path notation, such as

{phang2}{cmd:. sem ..., ... cov(}{it:name1}{cmd:*}{it:name2}{cmd:@}{it:c1} 
{it:name3}{cmd:*}{it:name4}{cmd:@}{it:c1}{cmd:) ...}{p_end}

{pstd}
See {helpb sem_path_notation##constraints:[SEM] sem path notation}.


{marker option}{...}
{title:Option}

{phang}
{cmd: covstruct(}[{it:groupid:}] {it:variables}{cmd:,} {it:structure}{cmd:)} is
used either (1) to modify the covariance structure among the exogenous
variables of your model or (2) to modify the covariance structure among the
error variables of your model. 

{p 8 8 2}
You may specify the {opt covstruct()} option multiple times.

{p 8 8 2}
The default covariance structure for the exogenous variables is 
{cmd:covstruct(_Ex, unstructured)}.  

{p 8 8 2}
The default covariance structure for the error variables is 
{cmd:covstruct(e._En, diagonal)}. 


{marker remarks}{...}
{title:Remarks}
     
{pstd}
See {findalias semcu}.

{pstd}
SEM allows covariances among exogenous variables, both latent and
observed, and allows covariances among the error variables.  Covariances
between exogenous variables and error variables are disallowed (assumed to be
0). 

{pstd}
Some authors refer to the covariances among the exogenous variables as matrix
{cmd:Phi} and to the covariances among the error variables as matrix
{cmd:Psi}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sem_mimic1}{p_end}

{pstd}MIMIC model{p_end}
{phang2}{cmd:. sem (SubjSES -> s_income s_occpres s_socstat)}{break}
	{cmd: (SubjSES <- income occpres)}{p_end}

{pstd}Let error variance of {cmd:s_income} and {cmd:s_occpres} be unstructured{p_end}
{phang2}{cmd:. sem (SubjSES -> s_income s_occpres s_socstat)}{break}
	{cmd: (SubjSES <- income occpres),}{break}
	{cmd: covstructure(e.s_income e.s_occpres, unstructured)}{p_end}

{pstd}Set error variances of observed endogenous variables to be equal{p_end}
{phang2}{cmd:. sem (SubjSES -> s_income s_occpres s_socstat)}{break}
	{cmd: (SubjSES <- income occpres),}{break}
	{cmd: covstructure(e.s_income e.s_occpres e.s_socstat, identity)}{p_end}

{pstd}Same as above, but using the keyword _OEn{p_end}
{phang2}{cmd:. sem (SubjSES -> s_income s_occpres s_socstat)}{break}
	{cmd: (SubjSES <- income occpres),}{break}
	{cmd: covstructure(e._OEn, identity)}{p_end}
