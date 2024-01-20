{smcl}
{* *! version 2.0.3  28apr2011}{...}
{viewerdialog query "dialog query"}{...}
{vieweralsosee "[R] query" "mansection R query"}{...}
{vieweralsosee "[R] set" "mansection R set"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] creturn" "help creturn"}{...}
{vieweralsosee "limits" "help limits"}{...}
{vieweralsosee "[M-3] mata set" "help mata set"}{...}
{vieweralsosee "[R] set_defaults" "help set_defaults"}{...}
{viewerjumpto "Syntax" "query##syntax"}{...}
{viewerjumpto "Description" "query##description"}{...}
{viewerjumpto "Example" "query##example"}{...}
{title:Title}

{p2colset 5 18 20 2}{...}
{p2col :{manlink R query} {hline 2}}Display system parameters{p_end}
{p2col 5 16 18 2:{manlink R set} {hline 2}}Overview of system parameters{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}{cmd:set} [{it:setcommand ...}]

{p 8 16 2}{cmdab:q:uery} [ {opt mem:ory} | {opt out:put} |
		{opt inter:face} | {opt graph:ics} |
		{opt eff:iciency} | {opt net:work} | {opt up:date} |
		{opt trace} | {opt mata} | {opt oth:er} ]


{center:For info. on            See               }
{center:{hline 42}}
{center:{cmd:set adosize}             {help adosize}           }
{center:{cmd:set autotabgraphs}       {help autotabgraphs}     }

{center:{cmd:set cformat}             {help set cformat}       }
{center:{cmd:set checksum}            {help checksum}          }
{center:{cmd:set conren}              {help conren}            }
{center:{cmd:set copycolor}           {help set printcolor}    }

{center:{cmd:set dockable}            {help dockable}          }
{center:{cmd:set dockingguides}       {help dockingguides}     }
{center:{cmd:set doublebuffer}        {help doublebuffer}      }
{center:{cmd:set dp}                  {help format}            }

{center:{cmd:set emptycells}          {help emptycells}        }
{center:{cmd:set eolchar}             {help eolchar}           }

{center:{cmd:set fastscroll}          {help fastscroll}        }
{center:{cmd:set floatresults}        {help floatresults}      }
{center:{cmd:set floatwindows}        {help floatwindows}      }

{center:{cmd:set graphics}            {help set graphics}      }

{center:{cmd:set httpproxy}           {help netio}             }
{center:{cmd:set httpproxyauth}       {help netio}             }
{center:{cmd:set httpproxyhost}       {help netio}             }
{center:{cmd:set httpproxyport}       {help netio}             }
{center:{cmd:set httpproxypw}         {help netio}             }
{center:{cmd:set httpproxyuser}       {help netio}             }

{center:{cmd:set include_bitmap}      {help include_bitmap}    }

{center:{cmd:set level}               {help level}             }
{center:{cmd:set linegap}             {help linegap}           }
{center:{cmd:set linesize}            {help log}               }
{center:{cmd:set locksplitters}       {help locksplitters}     }
{center:{cmd:set logtype}             {help log}               }
{center:{cmd:set lstretch}            {help lstretch}          }

{center:{cmd:set matastrict}          {help mata set}          }
{center:{cmd:set matalnum}            {help mata set}          }
{center:{cmd:set mataoptimize}        {help mata set}          }
{center:{cmd:set matafavor}           {help mata set}          }
{center:{cmd:set matacache}           {help mata set}          }
{center:{cmd:set matalibs}            {help mata set}          }
{center:{cmd:set matamofirst}         {help mata set}          }
{center:{cmd:set matsize}             {help matsize}           }
{center:{cmd:set maxdb}               {help db}                }
{center:{cmd:set maxiter}             {help maximize}          }
{center:{cmd:set maxvar}              {help memory}            }
{center:{cmd:set max_memory}          {help memory}            }
{center:{cmd:set min_memory}          {help memory}            }
{center:{cmd:set more}                {help more}              }

{center:{cmd:set niceness}            {help memory}            }
{center:{cmd:set notifyuser}          {help notifyuser}        }

{center:{cmd:set obs}                 {help obs}               }
{center:{cmd:set odbcmgr}             {help odbc}              }
{center:{cmd:set output}              {help quietly}           }

{center:{cmd:set pagesize}            {help more}              }
{center:{cmd:set pformat}             {help set cformat}       }
{center:{cmd:set pinnable}            {help pinnable}          }
{center:{cmd:set playsnd}             {help playsnd}           }
{center:{cmd:set printcolor}          {help set printcolor}    }
{center:{cmd:set processors}          {help processors}        }

{center:{cmd:set reventries}          {help reventries}        }
{center:{cmd:set revkeyboard}         {help varkeyboard}       }
{center:{cmd:set rmsg}                {help rmsg}              }

{center:{cmd:set scheme}              {help set scheme}        }
{center:{cmd:set scrollbufsize}       {help scrollbufsize}     }
{center:{cmd:set searchdefault}       {help search}            }
{center:{cmd:set seed}                {help set seed}          }
{center:{cmd:set segmentsize}         {help memory}            }
{center:{cmd:set sformat}             {help set cformat}       }
{center:{cmd:set showbaselevels}      {help set showbaselevels}}
{center:{cmd:set showemptycells}      {help set showbaselevels}}
{center:{cmd:set showomitted}         {help set showbaselevels}}
{center:{cmd:set smoothfonts}         {help smoothfonts}       }
{center:{cmd:set sortseed}            {help sortseed}          }

{center:{cmd:set timeout1}            {help netio}             }
{center:{cmd:set timeout2}            {help netio}             }
{center:{cmd:set trace}               {help trace}             }
{center:{cmd:set tracedepth}          {help trace}             }
{center:{cmd:set traceexpand}         {help trace}             }
{center:{cmd:set tracehilite}         {help trace}             }
{center:{cmd:set traceindent}         {help trace}             }
{center:{cmd:set tracenumber}         {help trace}             }
{center:{cmd:set tracesep}            {help trace}             }
{center:{cmd:set type}                {help generate}          }

{center:{cmd:set update_interval}     {help update}            }
{center:{cmd:set update_prompt}       {help update}            }
{center:{cmd:set update_query}        {help update}            }

{center:{cmd:set varabbrev}           {help varabbrev}         }
{center:{cmd:set varkeyboard}         {help varkeyboard}       }
{center:{hline 42}}

{pstd}{cmd:set} typed without arguments is equivalent to {cmd:query}
typed without arguments.

{pstd}To reset to the factory defaults, see {manhelp set_defaults R}.


{marker description}{...}
{title:Description}

{pstd}
{cmd:set} sets the values of various system parameters.

{pstd}
{cmd:query} displays the settings of various Stata parameters.

{pstd}
{cmd:query memory} displays memory-related system parameters.

{pstd}
{cmd:query output} displays parameters related to output.

{pstd}
{cmd:query interface} displays interface settings, which control how 
Stata's interface works.

{pstd}
{cmd:query graphics} displays settings that indicate how Stata's graphics are
displayed.

{pstd}
{cmd:query efficiency} displays efficiency parameters.

{pstd}
{cmd:query network} displays network-related system parameters.

{pstd}
{cmd:query update} displays settings to determine how Stata performs updates.

{pstd}
{cmd:query trace} displays parameters related to program debugging and tracing.

{pstd}
{cmd:query mata} displays settings affecting Mata's system parameters.

{pstd}
{cmd:query other} displays other system parameters.

{pstd}
{cmd:query} without argument displays all these sets of parameters.

{pstd}
Stata's c-class, {cmd:c()}, contains the values of system parameters and
settings, along with certain constraints; see {manhelp creturn P}.


{marker example}{...}
{title:Example}

    {cmd:. query memory}

    {cmd:. set matsize 500}

    {cmd:. query}
