*! version 1.0.2  23nov2008
program _tvc_notallowed
	version 10
	args optname optval
	if `:length local optval' {
		if "`optname'" == "svy" {
			di as err "{p 0 0 2}" ///
`"option tvc() not allowed with the svy prefix;{break}"'
		}
		else if "`optname'" == "scores" {
			di as err "{p 0 0 2}" ///
`"predicting scores is not allowed after estimation with tvc();{break}"'
		}
		else if "`optname'" == "predict" {
			di as err "{p 0 0 2}" ///
`"this prediction is not allowed after estimation with tvc();{break}"'
		}
		else if "`optname'" == "command" {
			di as err "{p 0 0 2}" ///
`"this post-estimation command is not allowed after estimation with tvc();{break}"'
		}
		else {
			di as err "{p 0 0 2}" ///
`"option `optname' may not be combined with option tvc();{break}"'
		}
		di as err ///
`"see {help tvc note} for an alternative to the tvc() option"'
		di as err "{p_end}"
		exit 198
	}
end
exit
