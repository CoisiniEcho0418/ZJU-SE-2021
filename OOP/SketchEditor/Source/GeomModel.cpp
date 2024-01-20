// GeomModel.cpp: implementation of the GeomModel class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "SketchEditor.h"
#include "GeomModel.h"


#include <math.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

GeomModel::GeomModel()
{

}

GeomModel::~GeomModel()
{

}
///////////////////////////////////////////////////////////////////////
// glmUnitize: "unitize" a model by translating it to the origin and
//  scaling it to fit in a unit cube around the origin.  Returns the
//  scalefactor used.
// 
//  model - properly initialized GLMmodel structure 
///////////////////////////////////////////////////////////////////////
GLfloat GeomModel::glmUnitize()
{
	GLuint  i;
	GLfloat maxx, minx, maxy, miny, maxz, minz;
	GLfloat cx, cy, cz, w, h, d;
	GLfloat scale;

//  assert(model);
	assert(vertices);

  /* get the max/mins */
	maxx = minx = vertices[3 + X];
	maxy = miny = vertices[3 + Y];
	maxz = minz = vertices[3 + Z];
	for (i = 1; i <= numvertices; i++) 
	{
		if (maxx < vertices[3 * i + X])
			maxx = vertices[3 * i + X];
		if (minx > vertices[3 * i + X])
			minx = vertices[3 * i + X];

		if (maxy < vertices[3 * i + Y])
			maxy = vertices[3 * i + Y];
		if (miny > vertices[3 * i + Y])
			miny = vertices[3 * i + Y];

		if (maxz < vertices[3 * i + Z])
			maxz = vertices[3 * i + Z];
		if (minz > vertices[3 * i + Z])
			minz = vertices[3 * i + Z];
	}

  /* calculate model width, height, and depth */
	w = _glmAbs(maxx) + _glmAbs(minx);
	h = _glmAbs(maxy) + _glmAbs(miny);
	d = _glmAbs(maxz) + _glmAbs(minz);

  /* calculate center of the model */
	cx = (maxx + minx) / 2.0;
	cy = (maxy + miny) / 2.0;
	cz = (maxz + minz) / 2.0;

  /* calculate unitizing scale factor */
	scale = 2.0 / _glmMax(_glmMax(w, h), d);

  /* translate around center then scale */
	for (i = 1; i <= numvertices; i++) 
	{
		vertices[3 * i + X] -= cx;
		vertices[3 * i + Y] -= cy;
		vertices[3 * i + Z] -= cz;
		vertices[3 * i + X] *= scale;
		vertices[3 * i + Y] *= scale;
		vertices[3 * i + Z] *= scale;
	}

	return scale;

}

GLvoid GeomModel::glmDimensions(GLfloat *dimensions)
{
	GLuint i;
	GLfloat maxx, minx, maxy, miny, maxz, minz;

//  assert(model);
	assert(vertices);
	assert(dimensions);

  /* get the max/mins */
	maxx = minx = vertices[3 + X];
	maxy = miny = vertices[3 + Y];
	maxz = minz = vertices[3 + Z];

	for (i = 1; i <= numvertices; i++) 
	{
		if (maxx < vertices[3 * i + X])
			maxx =vertices[3 * i + X];
		if (minx > vertices[3 * i + X])
			minx = vertices[3 * i + X];

		if (maxy < vertices[3 * i + Y])
			maxy = vertices[3 * i + Y];
		if (miny > vertices[3 * i + Y])
			miny = vertices[3 * i + Y];

		if (maxz < vertices[3 * i + Z])
			maxz = vertices[3 * i + Z];
		if (minz > vertices[3 * i + Z])
			minz = vertices[3 * i + Z];
	}

  /* calculate model width, height, and depth */
	dimensions[X] = _glmAbs(maxx) + _glmAbs(minx);
	dimensions[Y] = _glmAbs(maxy) + _glmAbs(miny);
	dimensions[Z] = _glmAbs(maxz) + _glmAbs(minz);

}

GLvoid GeomModel::glmScale(GLfloat scale)
{
	GLuint i;

	for (i = 1; i <= numvertices; i++) 
	{
		vertices[3 * i + X] *= scale;
		vertices[3 * i + Y] *= scale;
		vertices[3 * i + Z] *= scale;
	}

}

GLvoid GeomModel::glmReverseWinding()
{
	GLuint i, swap;

 // assert(model);

	for (i = 0; i < numtriangles; i++) 
	{
		swap = triangles[i].vindices[0];
		triangles[i].vindices[0] = triangles[i].vindices[2];
		triangles[i].vindices[2] = swap;

		if (numnormals) 
		{
			swap = triangles[i].nindices[0];
			triangles[i].nindices[0] = triangles[i].nindices[2];
			triangles[i].nindices[2] = swap;
		}

		if (numtexcoords) 
		{
			swap = triangles[i].tindices[0];
			triangles[i].tindices[0] = triangles[i].tindices[2];
			triangles[i].tindices[2] = swap;
		}
	}	

  /* reverse facet normals */
	for (i = 1; i <= numfacetnorms; i++) 
	{
		facetnorms[3 * i + X] = -facetnorms[3 * i + X];
		facetnorms[3 * i + Y] = -facetnorms[3 * i + Y];
		facetnorms[3 * i + Z] = -facetnorms[3 * i + Z];
	}

  /* reverse vertex normals */
  for (i = 1; i <= numnormals; i++) {
    normals[3 * i + X] = -normals[3 * i + X];
    normals[3 * i + Y] = -normals[3 * i + Y];
    normals[3 * i + Z] = -normals[3 * i + Z];
  }

}

GLvoid GeomModel::glmFacetNormals()
{
	GLuint  i;
	GLfloat u[3];
	GLfloat v[3];
  
//  assert(model);
	assert(vertices);

  /* clobber any old facetnormals */
	if (facetnorms)
		free(facetnorms);

  /* allocate memory for the new facet normals */
	numfacetnorms = numtriangles;
	facetnorms = (GLfloat*)malloc(sizeof(GLfloat) *
				       3 * (numfacetnorms + 1));

	for (i = 0; i < numtriangles; i++) 
	{
		triangles[i].findex = i+1;

		u[X] = vertices[3 * triangles[i].vindices[1] + X] -
           vertices[3 * triangles[i].vindices[0] + X];
		u[Y] = vertices[3 * triangles[i].vindices[1] + Y] -
           vertices[3 * triangles[i].vindices[0] + Y];
		u[Z] = vertices[3 * triangles[i].vindices[1] + Z] -
           vertices[3 * triangles[i].vindices[0] + Z];

		v[X] = vertices[3 * triangles[i].vindices[2] + X] -
           vertices[3 * triangles[i].vindices[0] + X];
		v[Y] = vertices[3 * triangles[i].vindices[2] + Y] -
           vertices[3 * triangles[i].vindices[0] + Y];
		v[Z] = vertices[3 * triangles[i].vindices[2] + Z] -
           vertices[3 * triangles[i].vindices[0] + Z];

		_glmCross(u, v, &facetnorms[3 * (i+1)]);
		_glmNormalize(&facetnorms[3 * (i+1)]);
	}

}

GLvoid GeomModel::glmVertexNormals(GLfloat angle)
{
	GLMnode*  node;
	GLMnode*  tail;
	GLMnode** members;
	GLfloat*  Tnormals;
	GLuint    Tnumnormals;
	GLfloat   average[3];
	GLfloat   dot, cos_angle;
	GLuint    i, avg;

//  assert(model);
	assert(facetnorms);

  /* calculate the cosine of the angle (in degrees) */
	cos_angle = cos(angle * M_PI / 180.0);

  /* nuke any previous normals */
	if (normals)
		free(normals);

  /* allocate space for new normals */
	numnormals = numtriangles * 3; /* 3 normals per triangle */
	normals = (GLfloat*)malloc(sizeof(GLfloat)* 3* (numnormals+1));

  /* allocate a structure that will hold a linked list of triangle
     indices for each vertex */
	members = (GLMnode**)malloc(sizeof(GLMnode*) * (numvertices + 1));
	for (i = 1; i <= numvertices; i++)
		members[i] = NULL;
  
  /* for every triangle, create a node for each vertex in it */
	for (i = 0; i < numtriangles; i++) 
	{
		node = (GLMnode*)malloc(sizeof(GLMnode));
		node->index = i;
		node->next  = members[triangles[i].vindices[0]];
		members[triangles[i].vindices[0]] = node;

		node = (GLMnode*)malloc(sizeof(GLMnode));
		node->index = i;
		node->next  = members[triangles[i].vindices[1]];
		members[triangles[i].vindices[1]] = node;

		node = (GLMnode*)malloc(sizeof(GLMnode));
		node->index = i;
		node->next  = members[triangles[i].vindices[2]];
		members[triangles[i].vindices[2]] = node;
	}

  /* calculate the average normal for each vertex */
	Tnumnormals = 1;
	for (i = 1; i <= numvertices; i++) 
	{
    /* calculate an average normal for this vertex by averaging the
       facet normal of every triangle this vertex is in */
		node = members[i];
		if (!node)
			fprintf(stderr, "glmVertexNormals(): vertex w/o a triangle\n");
		average[0] = 0.0; average[1] = 0.0; average[2] = 0.0;
		avg = 0;
		while (node) 
		{
      /* only average if the dot product of the angle between the two
         facet normals is greater than the cosine of the threshold
         angle -- or, said another way, the angle between the two
         facet normals is less than (or equal to) the threshold angle */
			dot = _glmDot(&facetnorms[3 * triangles[node->index].findex],
 		    &facetnorms[3 * triangles[members[i]->index].findex]);
			if (dot > cos_angle) 
			{
				node->averaged = GL_TRUE;
				average[0] += facetnorms[3 * triangles[node->index].findex + 0];
				average[1] += facetnorms[3 * triangles[node->index].findex + 1];
				average[2] += facetnorms[3 * triangles[node->index].findex + 2];
				avg = 1;			/* we averaged at least one normal! */
			} 
			else 
			{
				node->averaged = GL_FALSE;
			}
			node = node->next;
		}

		if (avg) 
		{
      /* normalize the averaged normal */
			_glmNormalize(average);

      /* add the normal to the vertex normals list */
			normals[3 * Tnumnormals + 0] = average[0];
			normals[3 * Tnumnormals + 1] = average[1];
			normals[3 * Tnumnormals + 2] = average[2];
			avg = Tnumnormals;
			Tnumnormals++;
		}

		/* set the normal of this vertex in each triangle it is in */
		node = members[i];
		while (node) 
		{
			if (node->averaged) 
			{
				/* if this node was averaged, use the average normal */
				if (triangles[node->index].vindices[0] == i)
					triangles[node->index].nindices[0] = avg;
				else if (triangles[node->index].vindices[1] == i)
					triangles[node->index].nindices[1] = avg;
				else if (triangles[node->index].vindices[2] == i)
				triangles[node->index].nindices[2] = avg;
			} 
			else 
			{
				/* if this node wasn't averaged, use the facet normal */
				normals[3 * Tnumnormals + 0] = 
					facetnorms[3 * triangles[node->index].findex + 0];
				normals[3 * Tnumnormals + 1] = 
					facetnorms[3 * triangles[node->index].findex + 1];
				normals[3 * Tnumnormals + 2] = 
					facetnorms[3 * triangles[node->index].findex + 2];
				if (triangles[node->index].vindices[0] == i)
					triangles[node->index].nindices[0] = Tnumnormals;
				else if (triangles[node->index].vindices[1] == i)
					triangles[node->index].nindices[1] = Tnumnormals;
				else if (triangles[node->index].vindices[2] == i)
					triangles[node->index].nindices[2] = Tnumnormals;
				Tnumnormals++;
			}
			node = node->next;
		}
	}
  
	numnormals = Tnumnormals - 1;

  /* free the member information */
	for (i = 1; i <= numvertices; i++) 
	{
		node = members[i];
		while (node) 
		{
			tail = node;
			node = node->next;
			free(tail);
		}
	}
	free(members);

  /* pack the normals array (we previously allocated the maximum
     number of normals that could possibly be created (numtriangles *
     3), so get rid of some of them (usually alot unless none of the
     facet normals were averaged)) */
	Tnormals = normals;
	normals = (GLfloat*)malloc(sizeof(GLfloat)* 3* (numnormals+1));


	for (i = 1; i <= numnormals; i++) 
	{
		normals[3 * i + 0] = Tnormals[3 * i + 0];
		normals[3 * i + 1] = Tnormals[3 * i + 1];
		normals[3 * i + 2] = Tnormals[3 * i + 2];
	}
	free(Tnormals);

	printf("glmVertexNormals(): %d normals generated\n", numnormals);

}

GLvoid GeomModel::glmLinearTexture()
{
	GeomModelGroup *Tgroup;
	GLfloat dimensions[3];
	GLfloat x, y, scalefactor;
	GLuint i;
  
//  assert(model);

	if (texcoords)
		free(texcoords);
	numtexcoords = numvertices;
	texcoords=(GLfloat*)malloc(sizeof(GLfloat)*2*(numtexcoords+1));
  
	glmDimensions(dimensions);
	scalefactor = 2.0 / 
		_glmAbs(_glmMax(_glmMax(dimensions[0], dimensions[1]), dimensions[2]));

  /* do the calculations */
	for(i = 1; i <= numvertices; i++) 
	{
		x = vertices[3 * i + 0] * scalefactor;
		y = vertices[3 * i + 2] * scalefactor;
		texcoords[2 * i + 0] = (x + 1.0) / 2.0;
		texcoords[2 * i + 1] = (y + 1.0) / 2.0;
	}
  
  /* go through and put texture coordinate indices in all the triangles */
	Tgroup = groups;
	while(Tgroup) 
	{
		for(i = 0; i < Tgroup->numtriangles; i++) 
		{
			triangles[Tgroup->triangles[i]].tindices[0] = triangles[Tgroup->triangles[i]].vindices[0];
			triangles[Tgroup->triangles[i]].tindices[1] = triangles[Tgroup->triangles[i]].vindices[1];
			triangles[Tgroup->triangles[i]].tindices[2] = triangles[Tgroup->triangles[i]].vindices[2];
		}    
		Tgroup = Tgroup->next;
	}

#if 0
  printf("glmLinearTexture(): generated %d linear texture coordinates\n",
	  numtexcoords);
#endif

}

GLvoid GeomModel::glmSpheremapTexture()
{
	GeomModelGroup* Tgroup;
	GLfloat theta, phi, rho, x, y, z, r;
	GLuint i;
  
//  assert(model);
	assert(normals);

	if (texcoords)
		free(texcoords);
	numtexcoords = numnormals;
	texcoords=(GLfloat*)malloc(sizeof(GLfloat)*2*(numtexcoords+1));
     
  /* do the calculations */
	for (i = 1; i <= numnormals; i++) 
	{
		z = normals[3 * i + 0];	/* re-arrange for pole distortion */
		y = normals[3 * i + 1];
		x = normals[3 * i + 2];
		r = sqrt((x * x) + (y * y));
		rho = sqrt((r * r) + (z * z));
      
		if(r == 0.0) 
		{
			theta = 0.0;
			phi = 0.0;
		} 
		else 
		{
			if(z == 0.0)
				phi = 3.14159265 / 2.0;
			else
				phi = acos(z / rho);
      
#if WE_DONT_NEED_THIS_CODE
			if(x == 0.0)
				theta = 3.14159265 / 2.0;	/* asin(y / r); */
			else
				theta = acos(x / r);
#endif
      
			if(y == 0.0)
				theta = 3.141592365 / 2.0;	/* acos(x / r); */
			else
				theta = asin(y / r) + (3.14159265 / 2.0);
		}
    
		texcoords[2 * i + 0] = theta / 3.14159265;
		texcoords[2 * i + 1] = phi / 3.14159265;
	}
  
  /* go through and put texcoord indices in all the triangles */
	Tgroup = groups;
	while(Tgroup) 
	{
		for (i = 0; i < Tgroup->numtriangles; i++) 
		{
			triangles[Tgroup->triangles[i]].tindices[0] = triangles[Tgroup->triangles[i]].nindices[0];
			triangles[Tgroup->triangles[i]].tindices[1] = triangles[Tgroup->triangles[i]].nindices[1];
			triangles[Tgroup->triangles[i]].tindices[2] = triangles[Tgroup->triangles[i]].nindices[2];
		}
		Tgroup = Tgroup->next;
	}

#if 0  
  printf("glmSpheremapTexture(): generated %d spheremap texture coordinates\n",
	 model->numtexcoords);
#endif

}

GLvoid GeomModel::glmDelete()
{
	GeomModelGroup* Tgroup;
	GLuint i;

//  assert(model);

	if (pathname)   free(pathname);
	if (mtllibname) free(mtllibname);
	if (vertices)   free(vertices);
	if (normals)    free(normals);
	if (texcoords)  free(texcoords);
	if (facetnorms) free(facetnorms);
	if (triangles)  free(triangles);
	if (materials) 
	{
		for (i = 0; i < nummaterials; i++)
			free(materials[i].name);
	}
	free(materials);
	while(groups) 
	{
	    Tgroup = groups;
		groups = groups->next;
		free(Tgroup->name);
		free(Tgroup->triangles);
		free(Tgroup);
	}

//  free(model);

}

GeomModel* GeomModel::glmReadOBJ(char *filename)
{
//	GeomModel* model;
	FILE*     file;

  /* open the file */
	file = fopen(filename, "r");
	if (!file) 
	{
		fprintf(stderr, "glmReadOBJ() failed: can't open data file \"%s\".\n",
			filename);
		exit(1);
	}

#if 0
  /* announce the model name */
	printf("Model: %s\n", filename);
#endif

  /* allocate a new model */
//	this = (GeomModel*)malloc(sizeof(GeomModel));
	pathname      = strdup(filename);
	mtllibname    = NULL;
	numvertices   = 0;
	vertices      = NULL;
	numnormals    = 0;
	normals       = NULL;
	numtexcoords  = 0;
	texcoords     = NULL;
	numfacetnorms = 0;
	facetnorms    = NULL;
	numtriangles  = 0;
	triangles     = NULL;
	nummaterials  = 0;
	materials     = NULL;
	numgroups     = 0;
	groups        = NULL;
	position[0]   = 0.0;
	position[1]   = 0.0;
	position[2]   = 0.0;

  /* make a first pass through the file to get a count of the number
     of vertices, normals, texcoords & triangles */
	_glmFirstPass(file);

  /* allocate memory */
	vertices = (GLfloat*)malloc(sizeof(GLfloat) * 3 * (numvertices + 1));
	triangles = (GLMtriangle*)malloc(sizeof(GLMtriangle) * numtriangles);
	if (numnormals) 
	{
		normals = (GLfloat*)malloc(sizeof(GLfloat) * 3 * (numnormals + 1));
	}
	if (numtexcoords) 
	{
		texcoords = (GLfloat*)malloc(sizeof(GLfloat) * 2 * (numtexcoords + 1));
	}

  /* rewind to beginning of file and read in the data this pass */
	rewind(file);

	_glmSecondPass(file);

  /* close the file */
	fclose(file);

	return this;

}

GLvoid GeomModel::glmWriteOBJ(char *filename, GLuint mode)
{
	GLuint    i;
	FILE*     file;
	GeomModelGroup* Tgroup;

//  assert(model);

	/* do a bit of warning */
	if (mode & GLM_FLAT && !facetnorms) 
	{
		printf("glmWriteOBJ() warning: flat normal output requested "
			"with no facet normals defined.\n");
		mode &= ~GLM_FLAT;
	}
	if (mode & GLM_SMOOTH && !normals) 
	{
		printf("glmWriteOBJ() warning: smooth normal output requested "
			"with no normals defined.\n");
		mode &= ~GLM_SMOOTH;
	}
	if (mode & GLM_TEXTURE && !texcoords) 
	{
		printf("glmWriteOBJ() warning: texture coordinate output requested "
			"with no texture coordinates defined.\n");
		mode &= ~GLM_TEXTURE;
	}
	if (mode & GLM_FLAT && mode & GLM_SMOOTH) 
	{
		printf("glmWriteOBJ() warning: flat normal output requested "
			"and smooth normal output requested (using smooth).\n");
		mode &= ~GLM_FLAT;
	}

  /* open the file */
	file = fopen(filename, "w");
	if (!file) 
	{
		fprintf(stderr, "glmWriteOBJ() failed: can't open file \"%s\" to write.\n",
			filename);
		exit(1);
	}

  /* spit out a header */
	fprintf(file, "#  \n");
	fprintf(file, "#  Wavefront OBJ generated by GLM library\n");
	fprintf(file, "#  \n");
	fprintf(file, "#  GLM library copyright (C) 1997 by Nate Robins\n");
	fprintf(file, "#  email: ndr@pobox.com\n");
	fprintf(file, "#  www:   http://www.pobox.com/~ndr\n");
	fprintf(file, "#  \n");

	if (mode & GLM_MATERIAL && mtllibname) 
	{
		fprintf(file, "\nmtllib %s\n\n", mtllibname);
		_glmWriteMTL(filename, mtllibname);
	}

  /* spit out the vertices */
	fprintf(file, "\n");
	fprintf(file, "# %d vertices\n", numvertices);
	for (i = 1; i <= numvertices; i++) 
	{
		fprintf(file, "v %f %f %f\n", 
			vertices[3 * i + 0],
			vertices[3 * i + 1],
			vertices[3 * i + 2]);
	}

  /* spit out the smooth/flat normals */
	if (mode & GLM_SMOOTH) 
	{
		fprintf(file, "\n");
		fprintf(file, "# %d normals\n", numnormals);
		for (i = 1; i <= numnormals; i++) 
		{
			fprintf(file, "vn %f %f %f\n", 
				normals[3 * i + 0],
				normals[3 * i + 1],
				normals[3 * i + 2]);
		}
	} 
	else if (mode & GLM_FLAT) 
	{
		fprintf(file, "\n");
		fprintf(file, "# %d normals\n", numfacetnorms);
		for (i = 1; i <= numnormals; i++) 
		{
			fprintf(file, "vn %f %f %f\n", 
				facetnorms[3 * i + 0],
				facetnorms[3 * i + 1],
				facetnorms[3 * i + 2]);
		}
	}

  /* spit out the texture coordinates */
	if (mode & GLM_TEXTURE) 
	{
		fprintf(file, "\n");
		fprintf(file, "# %d texcoords\n", texcoords);
		for (i = 1; i <= numtexcoords; i++) 
		{
			fprintf(file, "vt %f %f\n", 
				texcoords[2 * i + 0],
				texcoords[2 * i + 1]);
		}
	}

	fprintf(file, "\n");
	fprintf(file, "# %d groups\n", numgroups);
	fprintf(file, "# %d faces (triangles)\n", numtriangles);
	fprintf(file, "\n");

	Tgroup = groups;
	while(Tgroup) 
	{
		fprintf(file, "g %s\n", Tgroup->name);
		if (mode & GLM_MATERIAL)
			fprintf(file, "usemtl %s\n", materials[Tgroup->material].name);
		for (i = 0; i < Tgroup->numtriangles; i++) 
		{
			if (mode & GLM_SMOOTH && mode & GLM_TEXTURE) 
			{
				fprintf(file, "f %d/%d/%d %d/%d/%d %d/%d/%d\n",
					triangles[Tgroup->triangles[i]].vindices[0], 
					triangles[Tgroup->triangles[i]].nindices[0], 
					triangles[Tgroup->triangles[i]].tindices[0],
					triangles[Tgroup->triangles[i]].vindices[1],
					triangles[Tgroup->triangles[i]].nindices[1],
					triangles[Tgroup->triangles[i]].tindices[1],
					triangles[Tgroup->triangles[i]].vindices[2],
					triangles[Tgroup->triangles[i]].nindices[2],
					triangles[Tgroup->triangles[i]].tindices[2]);
			} 
			else if (mode & GLM_FLAT && mode & GLM_TEXTURE) 
			{
				fprintf(file, "f %d/%d %d/%d %d/%d\n",
					triangles[Tgroup->triangles[i]].vindices[0],
					triangles[Tgroup->triangles[i]].findex,
					triangles[Tgroup->triangles[i]].vindices[1],
					triangles[Tgroup->triangles[i]].findex,
					triangles[Tgroup->triangles[i]].vindices[2],
					triangles[Tgroup->triangles[i]].findex);
			} 
			else if (mode & GLM_TEXTURE) 
			{
				fprintf(file, "f %d/%d %d/%d %d/%d\n",
					triangles[Tgroup->triangles[i]].vindices[0],
					triangles[Tgroup->triangles[i]].tindices[0],
					triangles[Tgroup->triangles[i]].vindices[1],
					triangles[Tgroup->triangles[i]].tindices[1],
					triangles[Tgroup->triangles[i]].vindices[2],
					triangles[Tgroup->triangles[i]].tindices[2]);
			} 
			else if (mode & GLM_SMOOTH) 
			{
				fprintf(file, "f %d//%d %d//%d %d//%d\n",
					triangles[Tgroup->triangles[i]].vindices[0],
					triangles[Tgroup->triangles[i]].nindices[0],
					triangles[Tgroup->triangles[i]].vindices[1],
					triangles[Tgroup->triangles[i]].nindices[1],
					triangles[Tgroup->triangles[i]].vindices[2], 
					triangles[Tgroup->triangles[i]].nindices[2]);
			} 
			else if (mode & GLM_FLAT) 
			{
				fprintf(file, "f %d//%d %d//%d %d//%d\n",
					triangles[Tgroup->triangles[i]].vindices[0], 
					triangles[Tgroup->triangles[i]].findex,
					triangles[Tgroup->triangles[i]].vindices[1],
					triangles[Tgroup->triangles[i]].findex,
					triangles[Tgroup->triangles[i]].vindices[2],
					triangles[Tgroup->triangles[i]].findex);
			} 
			else 
			{
				fprintf(file, "f %d %d %d\n",
					triangles[Tgroup->triangles[i]].vindices[0],
					triangles[Tgroup->triangles[i]].vindices[1],
					triangles[Tgroup->triangles[i]].vindices[2]);
			}
		}
		fprintf(file, "\n");
		Tgroup = Tgroup->next;
	}

	fclose(file);

}

GLvoid GeomModel::glmDraw(GLuint mode)
{
	GLuint i;
	GeomModelGroup* Tgroup;

//  assert(model);
	assert(vertices);

  /* do a bit of warning */
	if (mode & GLM_FLAT && !facetnorms) 
	{
		printf("glmDraw() warning: flat render mode requested "
			"with no facet normals defined.\n");
		mode &= ~GLM_FLAT;
	}
	if (mode & GLM_SMOOTH && !normals) 
	{
		printf("glmDraw() warning: smooth render mode requested "
			"with no normals defined.\n");
		mode &= ~GLM_SMOOTH;
	}
	if (mode & GLM_TEXTURE && !texcoords) 
	{
		printf("glmDraw() warning: texture render mode requested "
			"with no texture coordinates defined.\n");
		mode &= ~GLM_TEXTURE;
	}
	if (mode & GLM_FLAT && mode & GLM_SMOOTH) 
	{
		printf("glmDraw() warning: flat render mode requested "
			"and smooth render mode requested (using smooth).\n");
		mode &= ~GLM_FLAT;
	}
	if (mode & GLM_COLOR && !materials) 
	{
		printf("glmDraw() warning: color render mode requested "
			"with no materials defined.\n");
		mode &= ~GLM_COLOR;
	}
	if (mode & GLM_MATERIAL && !materials) 
	{
		printf("glmDraw() warning: material render mode requested "
			"with no materials defined.\n");
		mode &= ~GLM_MATERIAL;
	}
	if (mode & GLM_COLOR && mode & GLM_MATERIAL) 
	{
		printf("glmDraw() warning: color and material render mode requested "
			"using only material mode\n");
		mode &= ~GLM_COLOR;
	}
	if (mode & GLM_COLOR)
		glEnable(GL_COLOR_MATERIAL);
	if (mode & GLM_MATERIAL)
		glDisable(GL_COLOR_MATERIAL);

	glPushMatrix();
	glTranslatef(position[0], position[1], position[2]);

	glBegin(GL_TRIANGLES);
	Tgroup = groups;
	while (Tgroup) 
	{
		if (mode & GLM_MATERIAL) 
		{
			glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT, 
				materials[Tgroup->material].ambient);
			glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, 
				materials[Tgroup->material].diffuse);
			glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, 
				materials[Tgroup->material].specular);
			glMaterialf(GL_FRONT_AND_BACK, GL_SHININESS, 
				materials[Tgroup->material].shininess);
		}

		if (mode & GLM_COLOR) 
		{
			glColor3fv(materials[Tgroup->material].diffuse);
		}

		for (i = 0; i < Tgroup->numtriangles; i++) 
		{
			if (mode & GLM_FLAT)
				glNormal3fv(&facetnorms[3 * triangles[Tgroup->triangles[i]].findex]);
      
			if (mode & GLM_SMOOTH)
				glNormal3fv(&normals[3 * triangles[Tgroup->triangles[i]].nindices[0]]);
			if (mode & GLM_TEXTURE)
				glTexCoord2fv(&texcoords[2*triangles[Tgroup->triangles[i]].tindices[0]]);
			glVertex3fv(&vertices[3 * triangles[Tgroup->triangles[i]].vindices[0]]);
#if 0
		printf("%f %f %f\n", 
			vertices[3 * triangles[Tgroup->triangles[i]].vindices[0] + X],
			vertices[3 * triangles[Tgroup->triangles[i]].vindices[0] + Y],
			vertices[3 * triangles[Tgroup->triangles[i]].vindices[0] + Z]);
#endif
      
		if (mode & GLM_SMOOTH)
			glNormal3fv(&normals[3 * triangles[Tgroup->triangles[i]].nindices[1]]);
		if (mode & GLM_TEXTURE)
			glTexCoord2fv(&texcoords[2*triangles[Tgroup->triangles[i]].tindices[1]]);
		glVertex3fv(&vertices[3 * triangles[Tgroup->triangles[i]].vindices[1]]);
#if 0
		printf("%f %f %f\n", 
			vertices[3 * triangles[Tgroup->triangles[i]].vindices[1] + X],
			vertices[3 * triangles[Tgroup->triangles[i]].vindices[1] + Y],
			vertices[3 * triangles[Tgroup->triangles[i]].vindices[1] + Z]);
#endif
      
		if (mode & GLM_SMOOTH)
			glNormal3fv(&normals[3 * triangles[Tgroup->triangles[i]].nindices[2]]);
		if (mode & GLM_TEXTURE)
			glTexCoord2fv(&texcoords[2*triangles[Tgroup->triangles[i]].tindices[2]]);
      glVertex3fv(&vertices[3 * triangles[Tgroup->triangles[i]].vindices[2]]);
#if 0
		printf("%f %f %f\n", 
			vertices[3 * triangles[Tgroup->triangles[i]].vindices[2] + X],
			vertices[3 * triangles[Tgroup->triangles[i]].vindices[2] + Y],
			vertices[3 * triangles[Tgroup->triangles[i]].vindices[2] + Z]);
#endif
      
		}
    
		Tgroup = Tgroup->next;
	}
	glEnd();

	glPopMatrix();

}

GLuint GeomModel::glmList(GLuint mode)
{
	GLuint list;

	list = glGenLists(1);
	glNewList(list, GL_COMPILE);
	glmDraw(mode);
	glEndList();

	return list;

}

GLvoid GeomModel::glmWeld(GLfloat epsilon)
{
	GLfloat* vectors;
	GLfloat* copies;
	GLuint   numvectors;
	GLuint   i;

  /* vertices */
	numvectors = numvertices;
	vectors    = vertices;
	copies = _glmWeldVectors(vectors, &numvectors, epsilon);

	printf("glmWeld(): %d redundant vertices.\n", 
		numvertices - numvectors - 1);

	for (i = 0; i < numtriangles; i++) 
	{
		triangles[i].vindices[0] = (GLuint)vectors[3 * triangles[i].vindices[0] + 0];
		triangles[i].vindices[1] = (GLuint)vectors[3 * triangles[i].vindices[1] + 0];
		triangles[i].vindices[2] = (GLuint)vectors[3 * triangles[i].vindices[2] + 0];
	}

  /* free space for old vertices */
	free(vectors);

  /* allocate space for the new vertices */
	numvertices = numvectors;
	vertices = (GLfloat*)malloc(sizeof(GLfloat) * 
				     3 * (numvertices + 1));

  /* copy the optimized vertices into the actual vertex list */
	for (i = 1; i <= numvertices; i++) 
	{
		vertices[3 * i + 0] = copies[3 * i + 0];
		vertices[3 * i + 1] = copies[3 * i + 1];
		vertices[3 * i + 2] = copies[3 * i + 2];
	}

	free(copies);

}

GLfloat GeomModel::_glmMax(GLfloat a, GLfloat b)
{
	if (a > b)
		return a;
	return b;

}

GLfloat GeomModel::_glmAbs(GLfloat f)
{
	if (f < 0)
		return -f;
	return f;

}

GLfloat GeomModel::_glmDot(GLfloat *u, GLfloat *v)
{
	assert(u);
	assert(v);

  /* compute the dot product */
	return u[X] * v[X] + u[Y] * v[Y] + u[Z] * v[Z];

}

GLvoid GeomModel::_glmCross(GLfloat *u, GLfloat *v, GLfloat *n)
{
	assert(u);
	assert(v);
	assert(n);

  /* compute the cross product (u x v for right-handed [ccw]) */
	n[X] = u[Y] * v[Z] - u[Z] * v[Y];
	n[Y] = u[Z] * v[X] - u[X] * v[Z];
	n[Z] = u[X] * v[Y] - u[Y] * v[X];

}

GLvoid GeomModel::_glmNormalize(GLfloat *n)
{
	GLfloat l;

	assert(n);

  /* normalize */
	l = (GLfloat)sqrt(n[X] * n[X] + n[Y] * n[Y] + n[Z] * n[Z]);
	n[0] /= l;
	n[1] /= l;
	n[2] /= l;

}

GLboolean GeomModel::_glmEqual(GLfloat *u, GLfloat *v, GLfloat epsilon)
{
	if (_glmAbs(u[0] - v[0]) < epsilon &&
      _glmAbs(u[1] - v[1]) < epsilon &&
      _glmAbs(u[2] - v[2]) < epsilon) 
	{
		return GL_TRUE;
	}
	return GL_FALSE;

}

GLfloat* GeomModel::_glmWeldVectors(GLfloat *vectors, GLuint *numvectors, GLfloat epsilon)
{
	GLfloat* copies;
	GLuint   copied;
	GLuint   i, j;

	copies = (GLfloat*)malloc(sizeof(GLfloat) * 3 * (*numvectors + 1));
	memcpy(copies, vectors, (sizeof(GLfloat) * 3 * (*numvectors + 1)));

	copied = 1;
	for (i = 1; i <= *numvectors; i++) 
	{
		for (j = 1; j <= copied; j++) 
		{
			if (_glmEqual(&vectors[3 * i], &copies[3 * j], epsilon)) 
			{
				goto duplicate;
			}
		}

    /* must not be any duplicates -- add to the copies array */
		copies[3 * copied + 0] = vectors[3 * i + 0];
		copies[3 * copied + 1] = vectors[3 * i + 1];
		copies[3 * copied + 2] = vectors[3 * i + 2];
		j = copied;				/* pass this along for below */
		copied++;

duplicate:
    /* set the first component of this vector to point at the correct
       index into the new copies array */
		vectors[3 * i + 0] = (GLfloat)j;
	}

	*numvectors = copied-1;
	return copies;

}

GeomModelGroup* GeomModel::_glmFindGroup(char *name)
{
	GeomModelGroup* Tgroup;

//  assert(model);

	Tgroup = groups;
	while(Tgroup) 
	{
		if (!strcmp(name, Tgroup->name))
			break;
		Tgroup = Tgroup->next;
	}

	return Tgroup;

}

GeomModelGroup* GeomModel::_glmAddGroup(char *name)
{
	GeomModelGroup* Tgroup;

	Tgroup = _glmFindGroup(name);
	if (!Tgroup) 
	{
	    Tgroup = (GeomModelGroup*)malloc(sizeof(GeomModelGroup));
		Tgroup->name = strdup(name);
		Tgroup->material = 0;
		Tgroup->numtriangles = 0;
		Tgroup->triangles = NULL;
		Tgroup->next = groups;
		groups = Tgroup;
		numgroups++;
	}

	return Tgroup;

}

GLuint GeomModel::_glmFindMaterial(char *name)
{
	GLuint i;

	for (i = 0; i < nummaterials; i++) 
	{
		if (!strcmp(materials[i].name, name))
			goto found;
	}

  /* didn't find the name, so set it as the default material */
	printf("_glmFindMaterial():  can't find material \"%s\".\n", name);
	i = 0;

found:
	return i;

}

char* GeomModel::_glmDirName(char *path)
{
	char* dir;
	char* s;

	dir = strdup(path);

	s = strrchr(dir, '/');
	if (s)
		s[1] = '\0';
	else
		dir[0] = '\0';

	return dir;

}

GLvoid GeomModel::_glmReadMTL(char *name)
{
	FILE* file;
	char* dir;
	char* Tfilename;
	char  buf[128];
	GLuint Tnummaterials, i;

	dir = _glmDirName(pathname);
	Tfilename = (char*)malloc(sizeof(char) * (strlen(dir) + strlen(name) + 1));
	strcpy(Tfilename, dir);
	strcat(Tfilename, name);
	free(dir);

  /* open the file */
	file = fopen(Tfilename, "r");
	if (!file) 
	{
		fprintf(stderr, "_glmReadMTL() failed: can't open material file \"%s\".\n",
			Tfilename);
		exit(1);
	}
	free(Tfilename);

  /* count the number of materials in the file */
	Tnummaterials = 1;
	while(fscanf(file, "%s", buf) != EOF) 
	{
		switch(buf[0]) 
		{
			case '#':				/* comment */
			/* eat up rest of line */
				fgets(buf, sizeof(buf), file);
				break;
			case 'n':				/* newmtl */
				fgets(buf, sizeof(buf), file);
				Tnummaterials++;
				sscanf(buf, "%s %s", buf, buf);
				break;
			default:
			/* eat up rest of line */
				fgets(buf, sizeof(buf), file);
				break;
		}
	}

	rewind(file);

  /* allocate memory for the materials */
	materials = (GLMmaterial*)malloc(sizeof(GLMmaterial) * Tnummaterials);
	nummaterials = Tnummaterials;

  /* set the default material */
	for (i = 0; i < Tnummaterials; i++) 
	{
	    materials[i].name = NULL;
		materials[i].shininess = 0;
		materials[i].diffuse[0] = 0.8;
		materials[i].diffuse[1] = 0.8;
		materials[i].diffuse[2] = 0.8;
		materials[i].diffuse[3] = 1.0;
		materials[i].ambient[0] = 0.2;
		materials[i].ambient[1] = 0.2;
		materials[i].ambient[2] = 0.2;
		materials[i].ambient[3] = 1.0;
		materials[i].specular[0] = 0.0;
		materials[i].specular[1] = 0.0;
		materials[i].specular[2] = 0.0;
		materials[i].specular[3] = 1.0;
	}
	materials[0].name = strdup("default");

  /* now, read in the data */
	Tnummaterials = 0;
	while(fscanf(file, "%s", buf) != EOF) 
	{
		switch(buf[0]) 
		{
			case '#':				/* comment */
			/* eat up rest of line */
				fgets(buf, sizeof(buf), file);
				break;
			case 'n':				/* newmtl */
				fgets(buf, sizeof(buf), file);
				sscanf(buf, "%s %s", buf, buf);
				Tnummaterials++;
				materials[Tnummaterials].name = strdup(buf);
				break;
			case 'N':
				fscanf(file, "%f", &materials[Tnummaterials].shininess);
				/* wavefront shininess is from [0, 1000], so scale for OpenGL */
				materials[Tnummaterials].shininess /= 1000.0;
				materials[Tnummaterials].shininess *= 128.0;
				break;
			case 'K':
				switch(buf[1]) 
				{
					case 'd':
						fscanf(file, "%f %f %f",
							&materials[Tnummaterials].diffuse[0],
							&materials[Tnummaterials].diffuse[1],
							&materials[Tnummaterials].diffuse[2]);
						break;
					case 's':
						fscanf(file, "%f %f %f",
							&materials[Tnummaterials].specular[0],
							&materials[Tnummaterials].specular[1],
							&materials[Tnummaterials].specular[2]);
						break;
					case 'a':
						fscanf(file, "%f %f %f",
							&materials[Tnummaterials].ambient[0],
							&materials[Tnummaterials].ambient[1],
							&materials[Tnummaterials].ambient[2]);
						break;
					default:
					/* eat up rest of line */
						fgets(buf, sizeof(buf), file);
						break;
				}
				break;
			default:
			/* eat up rest of line */
				fgets(buf, sizeof(buf), file);
				break;
		}
	}

}

GLvoid GeomModel::_glmWriteMTL(char *modelpath, char *mtllibname)
{
	FILE* file;
	char* dir;
	char* Tfilename;
	GLMmaterial* material;
	GLuint i;

	dir = _glmDirName(modelpath);
	Tfilename = (char*)malloc(sizeof(char) * (strlen(dir) + strlen(mtllibname)));
	strcpy(Tfilename, dir);
	strcat(Tfilename, mtllibname);
	free(dir);

  /* open the file */
	file = fopen(Tfilename, "w");
	if (!file) 
	{
		fprintf(stderr, "_glmWriteMTL() failed: can't open file \"%s\".\n",
			Tfilename);
		exit(1);
	}
	free(Tfilename);

  /* spit out a header */
	fprintf(file, "#  \n");
	fprintf(file, "#  Wavefront MTL generated by GLM library\n");
	fprintf(file, "#  \n");
	fprintf(file, "#  GLM library copyright (C) 1997 by Nate Robins\n");
	fprintf(file, "#  email: ndr@pobox.com\n");
	fprintf(file, "#  www:   http://www.pobox.com/~ndr\n");
	fprintf(file, "#  \n\n");

	for (i = 0; i < nummaterials; i++) 
	{
		material = &materials[i];
		fprintf(file, "newmtl %s\n", material->name);
		fprintf(file, "Ka %f %f %f\n", 
			material->ambient[0], material->ambient[1], material->ambient[2]);
		fprintf(file, "Kd %f %f %f\n", 
			material->diffuse[0], material->diffuse[1], material->diffuse[2]);
		fprintf(file, "Ks %f %f %f\n", 
			material->specular[0],material->specular[1],material->specular[2]);
		fprintf(file, "Ns %f\n", material->shininess);
		fprintf(file, "\n");
	}

}

GLvoid GeomModel::_glmFirstPass(FILE *file)
{
	GLuint    Tnumvertices;		/* number of vertices in model */
	GLuint    Tnumnormals;			/* number of normals in model */
	GLuint    Tnumtexcoords;		/* number of texcoords in model */
	GLuint    Tnumtriangles;		/* number of triangles in model */
	GeomModelGroup* Tgroup;			/* current group */
	unsigned  v, n, t;
	char      buf[128];

  /* make a default group */
	Tgroup = _glmAddGroup("default");

	Tnumvertices = Tnumnormals = Tnumtexcoords = Tnumtriangles = 0;
	while(fscanf(file, "%s", buf) != EOF) 
	{
		switch(buf[0]) 
		{
			case '#':				/* comment */
			/* eat up rest of line */
				fgets(buf, sizeof(buf), file);
				break;
			case 'v':				/* v, vn, vt */
			switch(buf[1]) 
			{
				case '\0':			/* vertex */
				/* eat up rest of line */
					fgets(buf, sizeof(buf), file);
					Tnumvertices++;
					break;
				case 'n':				/* normal */
				/* eat up rest of line */
					fgets(buf, sizeof(buf), file);
					Tnumnormals++;
					break;
				case 't':				/* texcoord */
				/* eat up rest of line */
					fgets(buf, sizeof(buf), file);
					Tnumtexcoords++;
					break;
				default:
					printf("_glmFirstPass(): Unknown token \"%s\".\n", buf);
					exit(1);
					break;
			}
			break;
			case 'm':
				fgets(buf, sizeof(buf), file);
				sscanf(buf, "%s %s", buf, buf);
				mtllibname = strdup(buf);
				_glmReadMTL(buf);
				break;
			case 'u':
				/* eat up rest of line */
				fgets(buf, sizeof(buf), file);
				break;
			case 'g':				/* group */
				/* eat up rest of line */
				fgets(buf, sizeof(buf), file);
				sscanf(buf, "%s", buf);
				Tgroup = _glmAddGroup(buf);
				break;
			case 'f':				/* face */
				v = n = t = 0;
				fscanf(file, "%s", buf);
				/* can be one of %d, %d//%d, %d/%d, %d/%d/%d %d//%d */
				if (strstr(buf, "//")) 
				{
					/* v//n */
					sscanf(buf, "%d//%d", &v, &n);
					fscanf(file, "%d//%d", &v, &n);
					fscanf(file, "%d//%d", &v, &n);
					Tnumtriangles++;
					Tgroup->numtriangles++;
					while(fscanf(file, "%d//%d", &v, &n) > 0) 
					{
						Tnumtriangles++;
						Tgroup->numtriangles++;
					}
				} 
				else if (sscanf(buf, "%d/%d/%d", &v, &t, &n) == 3) 
				{
					/* v/t/n */
					fscanf(file, "%d/%d/%d", &v, &t, &n);
					fscanf(file, "%d/%d/%d", &v, &t, &n);
					Tnumtriangles++;
					Tgroup->numtriangles++;
			
					while(fscanf(file, "%d/%d/%d", &v, &t, &n) > 0) 
					{
						Tnumtriangles++;
						Tgroup->numtriangles++;
					}
				} 
				else if (sscanf(buf, "%d/%d", &v, &t) == 2) 
				{
					/* v/t */
					fscanf(file, "%d/%d", &v, &t);
					fscanf(file, "%d/%d", &v, &t);
					Tnumtriangles++;
					Tgroup->numtriangles++;
					while(fscanf(file, "%d/%d", &v, &t) > 0) 
					{
						Tnumtriangles++;
						Tgroup->numtriangles++;
					}
				} 
				else 
				{
					/* v */
					fscanf(file, "%d", &v);
					fscanf(file, "%d", &v);
					Tnumtriangles++;
					Tgroup->numtriangles++;
					while(fscanf(file, "%d", &v) > 0) 
					{
						Tnumtriangles++;
						Tgroup->numtriangles++;
					}
				}
				break;

			default:
				/* eat up rest of line */
				fgets(buf, sizeof(buf), file);
				break;
		}
	}

#if 0
  /* announce the model statistics */
	printf(" Vertices: %d\n", Tnumvertices);
	printf(" Normals: %d\n", Tnumnormals);
	printf(" Texcoords: %d\n", Tnumtexcoords);
	printf(" Triangles: %d\n", Tnumtriangles);
	printf(" Groups: %d\n", numgroups);
#endif

  /* set the stats in the model structure */
	numvertices  = Tnumvertices;
	numnormals   = Tnumnormals;
	numtexcoords = Tnumtexcoords;
	numtriangles = Tnumtriangles;

  /* allocate memory for the triangles in each group */
	Tgroup = groups;
	while(Tgroup) 
	{
		Tgroup->triangles = (GLuint*)malloc(sizeof(GLuint) * Tgroup->numtriangles);
		Tgroup->numtriangles = 0;
		Tgroup = Tgroup->next;
	}

}

GLvoid GeomModel::_glmSecondPass(FILE *file)
{
	GLuint    Tnumvertices;		/* number of vertices in model */
	GLuint    Tnumnormals;			/* number of normals in model */
	GLuint    Tnumtexcoords;		/* number of texcoords in model */
	GLuint    Tnumtriangles;		/* number of triangles in model */
	GLfloat*  Tvertices;			/* array of vertices  */
	GLfloat*  Tnormals;			/* array of normals */
	GLfloat*  Ttexcoords;			/* array of texture coordinates */
	GeomModelGroup* Tgroup;			/* current group pointer */
	GLuint    material;			/* current material */
	GLuint    v, n, t;
	char      buf[128];

  /* set the pointer shortcuts */
	Tvertices     = vertices;
	Tnormals      = normals;
	Ttexcoords    = texcoords;
	Tgroup        = groups;

  /* on the second pass through the file, read all the data into the
     allocated arrays */
	Tnumvertices = Tnumnormals = Tnumtexcoords = 1;
	Tnumtriangles = 0;
	material = 0;
	while(fscanf(file, "%s", buf) != EOF) 
	{
		switch(buf[0]) 
		{
			case '#':				/* comment */
				/* eat up rest of line */
				fgets(buf, sizeof(buf), file);
				break;
			case 'v':				/* v, vn, vt */
				switch(buf[1]) 
				{
					case '\0':			/* vertex */
						fscanf(file, "%f %f %f", 
							&Tvertices[3 * Tnumvertices + X], 
							&Tvertices[3 * Tnumvertices + Y], 
							&Tvertices[3 * Tnumvertices + Z]);
						Tnumvertices++;
						break;
					case 'n':				/* normal */
						fscanf(file, "%f %f %f", 
							&Tnormals[3 * Tnumnormals + X],
							&Tnormals[3 * Tnumnormals + Y], 
							&Tnormals[3 * Tnumnormals + Z]);
						Tnumnormals++;
						break;
					case 't':				/* texcoord */
						fscanf(file, "%f %f", 
							&Ttexcoords[2 * Tnumtexcoords + X],
							&Ttexcoords[2 * Tnumtexcoords + Y]);
						Tnumtexcoords++;
						break;
				}
				break;
		case 'u':
			fgets(buf, sizeof(buf), file);
			sscanf(buf, "%s %s", buf, buf);
			Tgroup->material = material = _glmFindMaterial(buf);
			break;
		case 'g':				/* group */
			/* eat up rest of line */
			fgets(buf, sizeof(buf), file);
			sscanf(buf, "%s", buf);
			Tgroup = _glmFindGroup(buf);
			Tgroup->material = material;
			break;
		case 'f':				/* face */
			v = n = t = 0;
			fscanf(file, "%s", buf);
			/* can be one of %d, %d//%d, %d/%d, %d/%d/%d %d//%d */
			if (strstr(buf, "//")) 
			{
				/* v//n */
				sscanf(buf, "%d//%d", &v, &n);
				triangles[Tnumtriangles].vindices[0] = v;
				triangles[Tnumtriangles].nindices[0] = n;
				fscanf(file, "%d//%d", &v, &n);
				triangles[Tnumtriangles].vindices[1] = v;
				triangles[Tnumtriangles].nindices[1] = n;
				fscanf(file, "%d//%d", &v, &n);
				triangles[Tnumtriangles].vindices[2] = v;
				triangles[Tnumtriangles].nindices[2] = n;
				Tgroup->triangles[Tgroup->numtriangles++] = Tnumtriangles;
				Tnumtriangles++;
				while(fscanf(file, "%d//%d", &v, &n) > 0) 
				{
					triangles[Tnumtriangles].vindices[0] = triangles[Tnumtriangles-1].vindices[0];
					triangles[Tnumtriangles].nindices[0] = triangles[Tnumtriangles-1].nindices[0];
					triangles[Tnumtriangles].vindices[1] = triangles[Tnumtriangles-1].vindices[2];
					triangles[Tnumtriangles].nindices[1] = triangles[Tnumtriangles-1].nindices[2];
					triangles[Tnumtriangles].vindices[2] = v;
					triangles[Tnumtriangles].nindices[2] = n;
					Tgroup->triangles[Tgroup->numtriangles++] = Tnumtriangles;
					Tnumtriangles++;
				}
			} 
			else if (sscanf(buf, "%d/%d/%d", &v, &t, &n) == 3) 
			{
				/* v/t/n */
				triangles[Tnumtriangles].vindices[0] = v;
				triangles[Tnumtriangles].tindices[0] = t;
				triangles[Tnumtriangles].nindices[0] = n;
				fscanf(file, "%d/%d/%d", &v, &t, &n);
				triangles[Tnumtriangles].vindices[1] = v;
				triangles[Tnumtriangles].tindices[1] = t;
				triangles[Tnumtriangles].nindices[1] = n;
				fscanf(file, "%d/%d/%d", &v, &t, &n);
				triangles[Tnumtriangles].vindices[2] = v;
				triangles[Tnumtriangles].tindices[2] = t;
				triangles[Tnumtriangles].nindices[2] = n;
				Tgroup->triangles[Tgroup->numtriangles++] = Tnumtriangles;
				Tnumtriangles++;
				while(fscanf(file, "%d/%d/%d", &v, &t, &n) > 0) 
				{
					triangles[Tnumtriangles].vindices[0] = triangles[Tnumtriangles-1].vindices[0];
					triangles[Tnumtriangles].tindices[0] = triangles[Tnumtriangles-1].tindices[0];
					triangles[Tnumtriangles].nindices[0] = triangles[Tnumtriangles-1].nindices[0];
					triangles[Tnumtriangles].vindices[1] = triangles[Tnumtriangles-1].vindices[2];
					triangles[Tnumtriangles].tindices[1] = triangles[Tnumtriangles-1].tindices[2];
					triangles[Tnumtriangles].nindices[1] = triangles[Tnumtriangles-1].nindices[2];
					triangles[Tnumtriangles].vindices[2] = v;
					triangles[Tnumtriangles].tindices[2] = t;
					triangles[Tnumtriangles].nindices[2] = n;
					Tgroup->triangles[Tgroup->numtriangles++] = Tnumtriangles;
					Tnumtriangles++;
				}
			} 
			else if (sscanf(buf, "%d/%d", &v, &t) == 2) 
			{
				/* v/t */
				triangles[Tnumtriangles].vindices[0] = v;
				triangles[Tnumtriangles].tindices[0] = t;
				fscanf(file, "%d/%d", &v, &t);
				triangles[Tnumtriangles].vindices[1] = v;
				triangles[Tnumtriangles].tindices[1] = t;
				fscanf(file, "%d/%d", &v, &t);
				triangles[Tnumtriangles].vindices[2] = v;
				triangles[Tnumtriangles].tindices[2] = t;
				Tgroup->triangles[Tgroup->numtriangles++] = Tnumtriangles;
				Tnumtriangles++;
				while(fscanf(file, "%d/%d", &v, &t) > 0) 
				{
					triangles[Tnumtriangles].vindices[0] = triangles[Tnumtriangles-1].vindices[0];
					triangles[Tnumtriangles].tindices[0] = triangles[Tnumtriangles-1].tindices[0];
					triangles[Tnumtriangles].vindices[1] = triangles[Tnumtriangles-1].vindices[2];
					triangles[Tnumtriangles].tindices[1] = triangles[Tnumtriangles-1].tindices[2];
					triangles[Tnumtriangles].vindices[2] = v;
					triangles[Tnumtriangles].tindices[2] = t;
					Tgroup->triangles[Tgroup->numtriangles++] = Tnumtriangles;
					Tnumtriangles++;
				}
			} 
			else 
			{
				/* v */
				sscanf(buf, "%d", &v);
				triangles[Tnumtriangles].vindices[0] = v;
				fscanf(file, "%d", &v);
				triangles[Tnumtriangles].vindices[1] = v;
				fscanf(file, "%d", &v);
				triangles[Tnumtriangles].vindices[2] = v;
				Tgroup->triangles[Tgroup->numtriangles++] = Tnumtriangles;
				Tnumtriangles++;
				while(fscanf(file, "%d", &v) > 0) 
				{
					triangles[Tnumtriangles].vindices[0] = triangles[Tnumtriangles-1].vindices[0];
					triangles[Tnumtriangles].vindices[1] = triangles[Tnumtriangles-1].vindices[2];
					triangles[Tnumtriangles].vindices[2] = v;
					Tgroup->triangles[Tgroup->numtriangles++] = Tnumtriangles;
					Tnumtriangles++;
				}
			}
			break;

		default:
			/* eat up rest of line */
			fgets(buf, sizeof(buf), file);
			break;
		}
	}

#if 0
  /* announce the memory requirements */
	printf(" Memory: %d bytes\n",
		Tnumvertices  * 3*sizeof(GLfloat) +
		Tnumnormals   * 3*sizeof(GLfloat) * (Tnumnormals ? 1 : 0) +
		Tnumtexcoords * 3*sizeof(GLfloat) * (Tnumtexcoords ? 1 : 0) +
		Tnumtriangles * sizeof(GLMtriangle));
#endif

}
