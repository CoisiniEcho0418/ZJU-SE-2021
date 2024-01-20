*! version 1.0.3  30may2011

/*
	builds a list of common options for -mi estimate-, 
	-mi estimate using-, -mi predict-, -mi predictnl-
*/
program u_mi_estimate_get_commonopts, sclass
	version 11

	args cmdname usingspec

	local mainopts NImputations(string) Imputations(string)
	if ("`usingspec'"!="") {
		local mainopts `mainopts' ESTimations(numlist)
		local reportopts SHOWIMPutations CMDLEGend REPLAY NOERRNotes
	}
	if ("`cmdname'"=="predict" | "`cmdname'"=="predictnl") {
		if ("`cmdname'"=="predictnl") {
			local mainopts `mainopts' NOSMALL
			local diopts Level(cilevel)
			local reportopts `reportopts' `diopts'
		}
		sret clear	
		sret local common_opts	 "`mainopts' `reportopts'"
		sret local diopts	 "`diopts'"
		sret local cmddiopts	 ""
		exit
	}

	local mainopts `mainopts' NOSMALL UFMITest TRACE

	local adv ERROROK 
	local adv `adv' ESAMPVARYOK CMDOK // implied with -using- spec.

	local diopts Level(cilevel)
	local diopts `diopts' NOTABle NOMCERRor MCERRor
	local diopts `diopts' VARTable NOCITable CITable DFTable
	local diopts `diopts' NOCOEF NOTRCOEF NOWARNing
	local diopts `diopts' NOHEADer NOLEGend NOCMDLEGend POST
	// undoc.
	local diopts `diopts' NOCMDNOTE

	if inlist("`cmdname'","xtmixed","xtmelogit","xtmepoisson") {
		local cmddiopts `cmddiopts' VARiance NORETable NOFETable
		local cmddiopts `cmddiopts' ESTMetric NOGRoup
	}
	else if (substr("`cmdname'",1,2)=="xt") {
		local diopts `diopts' NOGRoup
	}

	local reportopts `reportopts' NOIsily DOTS 
	local reportopts `reportopts' `diopts' `cmddiopts'

	sret clear	
	sret local common_opts	 "`mainopts' `reportopts' `adv'"
	sret local diopts	 "`diopts'"
	sret local cmddiopts	 "`cmddiopts'"
end
