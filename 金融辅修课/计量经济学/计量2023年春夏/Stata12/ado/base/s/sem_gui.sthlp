{smcl}
{* *! version 1.0.1  07jul2011}{...}
{viewerdialog "SEM Builder" "stata sembuilder"}{...}
{vieweralsosee "[SEM] GUI" "mansection SEM GUI"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SEM] sem intro" "help sem_intro"}{...}
{vieweralsosee "[SEM] sem examples" "help sem_examples"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SEM] sem path notation" "help sem_path_notation"}{...}
{viewerjumpto "Description" "sem_gui##description"}{...}
{viewerjumpto "Remarks" "sem_gui##remarks"}{...}
{title:Title}

{p2colset 5 18 20 2}{...}
{p2col:{manlink SEM GUI} {hline 2}}Graphical user interface{p_end}
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Statistics > Structural equation modeling (SEM) > Model building and estimation}


{marker description}{...}
{title:Description}

{pstd}
Individual structural equation models are usually described using path
diagrams.  See {manlink SEM intro 2} for details on these diagrams.

{pstd}
Path diagrams can be used in {cmd:sem}'s GUI as the input to describe the model
to be fit.  


{marker remarks}{...}
{title:Remarks}

{pstd}
See {manlink SEM GUI}.

{pstd}
{cmd:sem} also provides a command language interface.  This interface is
similar to path diagrams and is typable.  See
{helpb sem_path_notation:[SEM] sem path notation}.
{p_end}
