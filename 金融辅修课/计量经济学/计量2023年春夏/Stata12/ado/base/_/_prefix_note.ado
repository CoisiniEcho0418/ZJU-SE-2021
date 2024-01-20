*! version 1.0.0  25feb2005
program _prefix_note
	version 9
	syntax name(name=cmdname id="command name") [, noDOTS ]

	if ("`dots'" != "") exit

	di as txt "(running `cmdname' on estimation sample)"
end
exit
