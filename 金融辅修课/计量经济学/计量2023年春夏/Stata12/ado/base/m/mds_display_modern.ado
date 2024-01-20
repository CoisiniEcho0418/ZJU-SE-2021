*! version 1.0.0  20mar2007
program mds_display_modern
	version 10

	syntax [, CONfig noPLot ]

	dis _n as txt "Modern multidimensional scaling"

	mds_dataheader

	dis _col(5) as txt "Loss criterion: {res:`e(loss)' = `e(losstitle)'}"
	dis _col(5) as txt "Transformation: {res:`e(transftitle)'}" _n

	dis _col(51) as txt "Number of obs    = " as res %9.0f e(N)
	if "`e(W)'" == "matrix" {
		dis _col(51) as txt "Number of Wght>0 = " as res %9.0g e(npos)
		dis _col(51) as txt "Sum of weights   = " as res %9.0g e(wsum)
	}

	dis _col(51) as txt "Dimensions       = " as res %9.0f e(p)
	if inlist("`e(norm)'","principal","none") {
		dis _col( 5) as txt "Normalization: {res:`e(norm)'}" _c
	}
	dis _col(51) as txt "Loss criterion   = " as res %9.4f `e(critval)'

	if inlist("`e(norm)'", "target", "classical") {
		local tm = cond("`e(norm)'"=="target", ///
			"`e(targetmatrix)'", "classical-MDS")

		dis _n _col( 5) as txt "Normalization:"      ///
			_col(51) as txt "Dilation factor = "  ///
			as res %9.0g el(e(norm_stats),1,2)

		dis    _col( 5) as txt "{res:Rotation w/target `tm'}" ///
			_col(51) as txt "Procrustes P     = "          ///
			as res %9.4f el(e(norm_stats),1,3)
	}

	if ("`config'" != "")  estat config
	if ("`plot'"   == "")  mdsconfig
end
exit
