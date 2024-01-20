*! version 1.1.0  15jun2005
version 9
mata:

void pathsplit(string scalar upath, ulhs, urhs)
{
	real scalar 	len, i1, i2, i
	string scalar	path
	string scalar	c

	len = strlen(path = upath)
	if (!len) {
		ulhs = urhs = ""
		return
	}
	if (len==1) {
		ulhs = ""
		urhs = path
		return 
	}

	/* ------------------------------------------------------------ */
	if (pathisurl(path)) {
		c = substr(path, 1, 7)
		pathsplit(substr(path, 8, .), ulhs, urhs)
		if (ulhs!="") ulhs = c + ulhs
		else	      urhs = c + urhs
		return 
	}
	if (substr(path, 2, 1)==":") {
		c = substr(path, 1, 2)
		pathsplit(substr(path, 3, .), ulhs, urhs)
		if (ulhs!="") ulhs = c + ulhs
		else	      urhs = c + urhs
		return 
	}
	if (substr(path,1,1)=="\" & substr(path,2,1)=="\") {
		pathsplit(substr(path, 3, .), ulhs, urhs)
		if (ulhs!="") ulhs = "\\" + ulhs
		else	      urhs = "\\" + urhs
		return 
	}
	/* ------------------------------------------------------------ */


	path = strreverse(path)
	c = substr(path, 1, 1)
	if (c=="/" | c=="\") path = substr(path, 2, .)

	i1 = strpos(path, "/")
	i2 = strpos(path, "\") 

	if (!i1 & !i2) {
		ulhs = ""
		urhs = strreverse(path)
		return 
	}
	i = (i1 ? (i2 ? (i1<i2 ? i1: i2) : i1) : i2)

	urhs = strreverse(substr(path, 1, i-1))
	if ((ulhs = strreverse(substr(path, i+1, .)))=="") {
		ulhs = substr(path, i, 1)
	}
}

end
