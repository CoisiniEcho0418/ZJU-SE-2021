*! version 1.0.0  03jan2005
program _prefix_run_error
	version 9
	args rc caller cmdname

	di as err `"an error occurred when `caller' executed `cmdname'"'
	exit `rc'
end
exit
