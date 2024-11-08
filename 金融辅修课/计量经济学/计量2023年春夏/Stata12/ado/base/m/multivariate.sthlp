{smcl}
{* *! version 1.1.5  20jun2011}{...}
{vieweralsosee "[MV] multivariate" "mansection MV multivariate"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MV] Glossary" "help mv_glossary"}{...}
{title:Title}

{pstd}
{manlink MV multivariate} {hline 2} Introduction to multivariate commands


{title:Description}

{pstd}
This overview organizes and presents the multivariate commands conceptually,
that is, according to the similarities in the functions that they perform.

{pstd}
{bf:Cluster analysis}.{break}
These commands perform cluster
analysis on variables or the similarity or dissimilarity values within a
matrix.  An introduction to cluster analysis and a description of the
{cmd:cluster} and {cmd:clustermat} subcommands is provided in 
{manhelp cluster MV} and {manhelp clustermat MV}.

{pstd}
{bf:Discriminant analysis}.{break}
These commands provide both
descriptive and predictive linear discriminant analysis (LDA), as well
as predictive quadratic discriminant analysis (QDA), logistic
discriminant analysis, and {it:k}th-nearest-neighbor (KNN)
discriminant analysis.  An introduction to discriminant analysis and the
{cmd:discrim} command is provided in {manhelp discrim MV}.

{pstd}
{bf:Factor analysis and principal component analysis}.{break}
These commands provide factor analysis of a correlation matrix and
principal component analysis (PCA) of a correlation or covariance
matrix.  The correlation or covariance matrix can be provided directly or
computed from variables.

{pstd}
{bf:Rotation}.{break}
These commands provide methods for
rotating a factor or PCA solution or for rotating a matrix.  Also
provided is Procrustean rotation analysis for rotating a set of variables to
best match another set of variables.

{pstd}
{bf:Multivariate analysis of variance and related techniques}.{break}
These commands provide canonical correlation analysis, multivariate regression,
multivariate analysis of variance (MANOVA), and comparison of
multivariate means.  Also provided are multivariate tests on means,
covariances, and correlations, and tests for multivariate normality.

{pstd}
{bf:Structural equation modeling}.{break}
These commands provide multivariate linear models that can
include observed and latent variables.  These models include confirmatory
factor analysis, multivariate regression, path analysis, mediator analysis, and
more; see {helpb sem:[SEM] sem}.

{pstd}
{bf:Multidimensional scaling and biplots}.{break}
These commands provide classic and modern (metric
and nonmetric) MDS and two-dimensional biplots.  MDS can be performed on the
variables or on proximity data in a matrix or as proximity data in long format.

{pstd}
{bf:Correspondence analysis}.{break}
These commands provide
simple correspondence analysis (CA) on the cross-tabulation of two categorical
variables or on a matrix and multiple correspondence analysis (MCA) and joint
correspondence analysis (JCA) on two or more categorical variables.


{pstd}
{bf: Cluster analysis}

{p2colset 5 37 39 2}{...}
{p2col :{helpb cluster}}Introduction to cluster analysis
commands{p_end}
{p2col :{helpb clustermat}}Introduction to clustermat
commands{p_end}
{p2col :{helpb matrix dissimilarity}}Compute similarity or dissimilarity
measures; may be used by clustermat{p_end}

{pstd}
{bf: Discriminant analysis}

{p2col :{helpb discrim}}Introduction to discriminant-analysis commands{p_end}
{p2col :{helpb discrim lda}}Linear discriminant analysis (LDA){p_end}
{p2col :{help discrim lda postestimation}}Postestimation tools for discrim lda{p_end}
{p2col :{helpb candisc}}Canonical (descriptive) linear discriminant analysis{p_end}
{p2col :{helpb discrim qda}}Quadratic discriminant analysis (QDA){p_end}
{p2col :{help discrim qda postestimation}}Postestimation tools for discrim qda{p_end}
{p2col :{helpb discrim logistic}}Logistic discriminant analysis{p_end}
{p2col :{help discrim logistic postestimation}}Postestimation tools for discrim logistic{p_end}
{p2col :{helpb discrim knn}}{it:k}th-nearest-neighbor (KNN) discriminant analysis{p_end}
{p2col :{help discrim knn postestimation}}Postestimation tools for discrim knn{p_end}
{p2col :{helpb discrim estat}}Common postestimation tools for discrim{p_end}

{pstd}
{bf: Factor analysis and principal component analysis}

{p2col :{helpb factor}}Factor analysis{p_end}
{p2col :{help factor postestimation}}Postestimation tools for factor and
factormat{p_end}
{p2col :{helpb pca}}Principal component analysis{p_end}
{p2col :{help pca postestimation}}Postestimation tools for pca and
pcamat{p_end}
{p2col :{helpb rotate}}Orthogonal and oblique rotations after factor
and pca{p_end}
{p2col :{helpb screeplot}}Scree plot{p_end}
{p2col :{helpb scoreplot}}Score and loading plots{p_end}

{pstd}
{bf: Rotation}

{p2col :{helpb rotate}}Orthogonal and oblique rotations after factor and pca
{p_end}
{p2col :{helpb rotatemat}}Orthogonal and oblique rotation of a Stata
matrix{p_end}
{p2col :{helpb procrustes}}Procrustes transformation{p_end}
{p2col :{help procrustes postestimation}}Postestimation tools for
procrustes {p_end}

{pstd}
{bf: Multivariate analysis of variance and related techniques}

{p2col :{helpb canon}}Canonical correlations{p_end}
{p2col :{help canon postestimation}}Postestimation tools for
canon{p_end}
{p2col :{helpb mvreg}}Multivariate regression{p_end}
{p2col :{help mvreg postestimation}}Postestimation tools for mvreg{p_end}
{p2col :{helpb manova}}Multivariate analysis of variance and covariance{p_end}
{p2col :{help manova postestimation}}Postestimation tools for manova{p_end}
{p2col :{helpb hotelling}}Hotelling's T-squared generalized means test{p_end}
{p2col :{helpb mvtest}}Multivariate tests on means, covariances, correlations,
                and of normality{p_end}


{pstd}
{bf: Structural equation modeling}

{p2col :{helpb sem}}Structural equation modeling{p_end}

{pstd}
{bf:Multidimensional scaling and biplots}

{p2col :{helpb mds}}Multidimensional scaling for twoway data{p_end}
{p2col :{help mds postestimation}}Postestimation tools for mds,
mdsmat, and mdslong{p_end}
{p2col :{helpb mdslong}}Multidimensional scaling of proximity data in long format{p_end}
{p2col :{helpb mdsmat}}Multidimensional scaling of proximity data in a matrix{p_end}
{p2col :{helpb biplot}}Biplots{p_end}

{pstd}
{bf:Correspondence analysis}

{p2col :{helpb ca}}Simple correspondence analysis{p_end}
{p2col :{help ca postestimation}}Postestimation tools for ca and camat{p_end}
{p2col :{helpb mca}}Multiple and joint correspondence analysis{p_end}
{p2col :{help mca postestimation}}Postestimation tools for mca{p_end}
{p2colreset}{...}
