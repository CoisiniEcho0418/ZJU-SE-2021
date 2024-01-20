{smcl}
{* *! version 1.0.1  29jun2011}{...}
{vieweralsosee "[SEM] Glossary" "mansection SEM Glossary"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SEM] sem" "help sem"}{...}
{viewerjumpto "Description" "sem_glossary##description"}{...}
{viewerjumpto "Glossary" "sem_glossary##glossary"}{...}
{title:Title}

{p2colset 5 19 21 2}{...}
{p2col :{manlink SEM Glossary}}{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{p 4 4 2}
Please read.  The terms defined below are used throughout the documentation,
sometimes without explanation.


{marker glossary}{...}
{title:Glossary}

{phang}
{marker ADF}{...}
{bf:ADF}, {bf:method(adf)}.
        ADF stands for asymptotic distribution free and is a method
        used to obtain fitted parameters.  ADF is used by {cmd:sem}
        when the {cmd:method(adf)} option is specified.  Other available methods
        are {help sem_glossary##ML:ML}, {help sem_glossary##QML:QML}, and
	{help sem_glossary##MLMV:MLMV}.

{phang}
{marker anchoring}{...}
{bf:anchoring}, {bf:anchor variable}.
        A variable is said to be the anchor of a latent variable if the
        path coefficient between the latent variable and the anchor variable
        is constrained to be 1.  The {cmd:sem} software uses anchoring as a
        way of normalizing latent variables and thus identifying the model.

{phang}
{marker baseline_model}{...}
{bf:baseline model}.
        A baseline model is a covariance model -- a model of fitted means 
        and covariances of observed variables without any other paths -- with
        most of the covariances constrained to 0.  That is, a baseline
        model is a model of fitted means and variances but typically not all
        the covariances.  Also see {help sem_glossary##saturated_model:saturated model}.

{phang}
{bf:Bentler-Weeks formulation}.
     The Bentler and Weeks {help sem references##Bentler1980:(1980)}
     formulation of SEM places the results in a series of matrices
     organized around how results are calculated.  See 
     {helpb sem estat framework:[SEM] estat framework}.

{marker bootstrap}{...}
{phang}
{bf:bootstrap}, {bf:vce(bootstrap)}.
The bootstrap is a replication method for obtaining variance estimates.
Consider an estimation method E for estimating theta.  Let theta-hat be
the result of applying E to dataset D containing N observations.  The
bootstrap is a way of obtaining variance estimates for theta-hat from
repeated estimates theta_1-hat, theta_2-hat, ..., where each
theta_i-hat is the result of applying E to a dataset of size N drawn
with replacement from D.  See
{helpb sem option method:[SEM] sem option method()} and
{helpb bootstrap:[R] bootstrap}.

{phang}
{bf:CI}.  CI is an abbreviation for confidence interval.

{phang}
{marker clustered}{...}
{bf:clustered}, {bf:vce(cluster clustvar)}.
        Clustered is the name we use for the generalized
        Huber/White/sandwich estimator of the VCE, 
        which is the {cmd:robust} technique generalized to relax 
        the assumption that errors are independent across observations 
        to be that they are independent across clusters of observations.
        Within cluster, errors may be correlated.
        
{pmore}
        Clustered standard errors are reported when {cmd:sem}
        option {cmd:vce(cluster} {it:clustvar}{cmd:)} is specified.  The
        other available techniques are
	{help sem_glossary##OIM:OIM},
        {help sem_glossary##EIM:EIM},
	{help sem_glossary##OPG:OPG},
	{help sem_glossary##robust:robust},
	{help sem_glossary##bootstrap:bootstrap}, and
	{help sem_glossary##jackknife:jackknife}.

{phang}
{bf:CFA}, {bf:CFA models}.
        CFA stands for confirmatory factor analysis.  It is 
        a way of analyzing measurement models. 
        CFA models is a synonym for
        {help sem_glossary##measurement_models:measurement models}.

{phang}
{bf:coefficient of determination}.
        The coefficient of determination is the fraction (or percentage) 
        of variation (variance) explained by an equation of a model.  The
        coefficient of determination is thus like R^2 in
        linear regression.

{phang}
{bf:command language}.
        Stata's {cmd:sem} command provides a way to specify structural
        equation models.  The alternative is to use {cmd:sem}'s GUI to
        draw path diagrams; see {manlink SEM intro 2} and
        {helpb sem gui:[SEM] GUI}.

{phang}
{bf:constraints}.
	See {help sem glossary##parameter_constraints:parameter constraints}.

{phang}
{bf:correlated uniqueness model}.
        A correlated uniqueness model is a kind of measurement model in
        which the errors of the measurements has a structured
        correlation.  See {manlink SEM intro 4}.

{phang}
{bf:curved path}.
	See {help sem glossary##path:path}.

{phang}
{bf:degree-of-freedom adjustment}.
        In estimates of variances and covariances, a finite-population
        degree-of-freedom adjustment is sometimes applied to make the
        estimates unbiased.

{pmore}
        Let's write an estimated variance as sigma_ii hat and write the
        "standard" formula for the variance as
        sigma_ii hat = S_ii/N.  If sigma_ii hat is the variance of
        observable variable x_i, it can be readily proven that S_ii/N
        is a biased estimate of the variances in samples of size N and that
        S_ii/(N-1) is an unbiased estimate.  It is usual to
        calculate variances using S_ii/(N-1), which is to say, the
        "standard" formula has a multiplicative degree-of-freedom adjustment
        of N/(N-1) applied to it.

{pmore}
        If Sigma_ii hat is the variances of estimated parameter beta_i, a
        similar finite-population degree-of-freedom adjustment can
        sometimes be derived that will make the estimate unbiased.  For
        instance, if beta_i is a coefficient from a linear regression,
        an unbiased estimate of the variance of regression coefficient
        beta_i is S/(N-p-1), where p is the total number of regression
        coefficients estimated excluding the intercept.  In other cases,
        no such adjustment can be derived.  Such estimators have no
        derivable finite-sample properties and one is left only with the
        assurances provided by its provable asymptotic properties.  In
        such cases, the variance of coefficient beta_i is calculated as
        S/N, which can be derived on theoretical grounds.  SEM is an
        example of such an estimator.

{pmore}
        SEM is a remarkably flexible estimator and can reproduce results
        that can sometimes be estimated by other estimators.  SEM might
        produce asymptotically equivalent results, or it might produce
        identical results depending on the estimator.  Linear regression
        is an example in which {cmd:sem} produces identical results.
        The reported standard errors, however, will not look identical
        because the linear regression estimates have the
        finite-population degree-of-freedom adjustment applied to them,
        and the SEM estimates do not.  To see the equivalence, you must
        undo the adjustment on the reported linear regression standard
        errors by multiplying them by sqrt{(N-p-1)/N}.

{phang}
{marker direct}{...}
{bf:direct}, {bf:indirect}, and {bf:total effects}.
         Consider the following system of equations:

            y_1 = b_10 + b_11 y_2 + b_12 x_1 + b_13 x_3 + e_1
            y_2 = b_20 + b_21 y_3 + b_22 x_1 + b_23 x_4 + e_2
            y_3 = b_30 + b_32 x_1 + b_33 x_5 + e_3

{pmore}
         The total effect of x_1 on y_1 is 
         b_12 + b_11 b_22 + b_11 b_21 b_32.  
         It measures the full change in y_1 based on allowing x_1 to vary
         throughout the system.

{pmore}
         The direct effect of x_1 on y_1 is b_12.  It measures
         the change in y_1 caused by a change in x_1 holding other
         endogenous variables -- namely, y_2 and y_3 -- constant.

{pmore}
         The indirect effect of x_1 on y_1 is obtained by subtracting
         the total and direct effects and is thus b_11 b_22 + b_11 b_21
         b_32.

{phang}
{marker EIM}{...}
{bf:EIM}, {bf:vce(eim)}.
        EIM stands for expected information matrix, defined 
        as the inverse of the negative of the expected value of the matrix of
        second derivatives, usually of the log-likelihood function.  The
        EIM is an estimate of the VCE.  EIM standard 
        errors are reported when {cmd:sem} option {cmd:vce(eim)} is specified. 
        The other available techniques are
	{help sem_glossary##OIM:OIM},
	{help sem_glossary##OPG:OPG},
        {help sem_glossary##robust:robust},
        {help sem_glossary##clustered:clustered},
        {help sem_glossary##bootstrap:bootstrap}, and
        {help sem_glossary##jackknife:jackknife}.

{phang}
{bf:estimation method}.
        There are a variety of ways that one can solve for the
        parameters of a structural equation model.  Different methods
        make different assumptions about the data-generation process,
        and so it is important that you choose a method appropriate for
        your model and data; see {manlink SEM intro 3}.

{phang}
{marker error}{...}
{bf:error}, {bf:error variable}.
        The error is random disturbance e in a linear equation: 

		y = b_0 + b_1 x_1 + b_2 x_2 + ... + e

{pmore}
        An error variable is an unobserved endogenous variable in path
        diagrams corresponding to e.  Mathematically, error variables
        are just another example of latent endogenous variables, but in
        {cmd:sem}, error variables are considered to be in a class by
        themselves.  All endogenous variables -- observed and latent --
        have a corresponding error variable.  Error variables
        automatically and inalterably have their path coefficients fixed
        to be 1.  Error variables have a fixed naming convention in the
        software.  If a variable is the error for (observed or latent)
        endogenous variable {cmd:y}, then the residual variable's name
        is {cmd:e.y}.

{pmore}
        In {cmd:sem}, error variables are uncorrelated with each other 
        unless explicitly indicated otherwise.  That indication is made 
        in path diagrams by drawing a curved path between the error 
        variables and is made in command notation by including 
        {cmd:cov(e.}{it:name1}{cmd:*e.}{it:name2}{cmd:)} 
        among the options specified on the {cmd:sem} command.

{phang}
{marker endogenous_variable}{...}
{bf:endogenous variable}.
        A variable, observed or latent, is endogenous (determined by the
        system) if any path points to it.  Also see
        {help sem glossary##exogenous_variable:exogenous variable}.

{phang}
{marker exogenous_variable}{...}
{bf:exogenous variable}.
        A variable, observed or latent, is exogenous (determined outside
        the system) if paths only originate from it, or equivalently, no path
        points to it.  Also see
        {help sem glossary##endogenous_variable:endogenous variable}.

{phang}
{bf:fictional data}.
        Fictional data are data that have no basis in reality even though they
        might look real; they are data that are made up for use in examples.

{phang}
{marker first_order_variables}{...}
{bf:first- and second-order latent variables}.
        If a latent variable is measured by other latent variables only, 
        the latent variable that does the measuring are called 
        first-order latent variable, and the latent variable being 
        measured is called the second-order latent variable. 

{phang}
{bf:GMM}, {bf:generalized method of moments}.
        GMM is a method used to obtain fitted parameters.  In this
        documentation, GMM is referred to as {help sem_glossary##ADF:ADF},
        which stands
        for asymptotic distribution free.  Other available methods are
	{help sem_glossary##ML:ML},
        {help sem_glossary##QML:QML},
        {help sem_glossary##ADF:ADF}, and
	{help sem_glossary##MLMV:MLMV}.

{pmore}
        The SEM moment conditions are cast in terms of second moments,
        not the first moments used in many other applications associated with
        GMM.

{phang}
{bf:goodness-of-fit statistic}.
        A goodness-of-fit statistic is a value designed to measure 
        how well the model reproduces some aspect of the data the model 
        is intended to fit.  SEM reproduces the 
        first- and second-order moments of the data, with an emphasis 
        on the second-order moments, and thus goodness-of-fit statistics 
        appropriate for use after {cmd:sem} compare the predicted 
        covariance matrix (and mean vector) with the matrix (and vector) 
        observed in the data.

{phang}
{bf:GUI}.
        GUI stands for graphical user interface and in this manual 
        stands for the component of the software that allows you to 
        specify models by entering path diagrams.  
        The alternative way to enter your model is by using {cmd:sem}'s 
        command language.  See {manlink SEM intro 2} and {helpb sem gui:[SEM] GUI}.

{phang}
{marker identification}{...}
{bf:identification}.
        Identification refers to the conceptual constraints on
        parameters of a model that are required for the model's remaining
        parameters to have a unique solution.  A model is said to be
        unidentified if these constraints are not supplied. 
        These constraints are of two types:  substantive constraints
        and normalization constraints.

{pmore}
        Normalization constraints have to do with the fact that one scale
        works as well as another for each latent variable in the model.  One
        can think, for instance, of propensity to write software as being
        measured on a scale of 0 to 1, 1 to 100, or any other scale.
        The normalization constraints are the constraints necessary to 
        choose one particular scale.  The normalization constraints are 
        provided automatically by the {cmd:sem} software by 
        {help sem glossary##anchoring:anchoring} using 
        unit loadings. 

{pmore}
        Substantive constraints are the constraints you specify about your 
        model so that it has substantive content.  Usually, these constraints
        are zero constraints implied by the paths omitted, 
        but they can include explicit parameter constraints as well.  It is
        easy to write a model that is not identified for substantive reasons;
        see {manlink SEM intro 3}.

{phang}
{marker indicator_variables}{...}
{bf:indicator variables}, {bf:indicators}.
        Synonym for {help sem glossary##measurement_variables:measurement variables}.

{phang}
{bf:indirect effects}.
        See {help sem glossary##direct:direct, indirect, and total effects}.

{phang}
{bf:initial values}.
	See {help sem glossary##starting_values:starting values}.

{phang}
{marker intercept}{...}
{bf:intercept}.
        An intercept for the equation of endogenous variable y,
        observed or latent, is the path coefficient from {cmd:_cons} to y.
        {cmd:_cons} is Stata-speak for the built-in variable containing 
        1 in all observations.  In SEM-speak, {cmd:_cons} is an 
        observed exogenous variable.

{marker jackknife}{...}
{phang}
{bf:jackknife}, {bf:vce(jackknife)}.
The jackknife is a replication method for obtaining variance estimates.
Consider an estimation method E for estimating theta.  Let theta-hat be
the result of applying E to dataset D containing N observations.  The
jackknife is a way of obtaining variance estimates for theta-hat from
repeated estimates theta_1-hat, theta_2-hat, ..., theta_N-hat, where
each theta_i-hat is the result of applying E to D with observation i
removed.  See {helpb sem option method:[SEM] sem option method()} and
{helpb jackknife:[R] jackknife}.

{phang}
{bf:Lagrange multiplier tests}.
        Synonym for {help sem glossary##score_tests:score tests}.

{phang}
{bf:linear regression}.
        Linear regression is a kind of structural equation model
        in which there is a single equation and all values are observed. 
        See {manlink SEM intro 4}.

{phang}
{bf:latent growth model}.
        A latent growth model is a kind of measurement model in which 
        the observed values are collected over time and are allowed to follow a 
        trend.  See {manlink SEM intro 4}.
        
{phang}
{marker latent_variable}{...}
{bf:latent variable}.
        A variable is latent if it is not observed.  A variable is
        latent if it is not in your dataset but you wish it were.  You wish
        you had a variable recording the propensity to commit violent crime,
        or socioeconomic status, or happiness, or true ability, or even
        income accurately recorded.  Latent variables are sometimes described
        as imagined variables.

{pmore}
        In the software, latent variables are usually indicated by having 
        at least their first letter capitalized.

{pmore}
        Also see {help sem glossary##observed_variables:observed variables} and see 
       {help sem glossary##first_order_variables:first- and second-order latent variables}.

{phang}
{bf:manifest variables}.
        Synonym for {help sem glossary##observed_variables:observed variables}.

{phang}
{bf:measure}, {bf:measurement}, {bf:x a measurement of X}, {bf:x measures X}.
        See {help sem glossary##measurement_variables:measurement variables}.

{phang}
{marker measurement_models}{...}
{bf:measurement models}, {bf:measurement component}.
        A measurement model is a particular kind of model that deals
        with the problem of translating observed values to values suitable for
        modeling.  Measurement models are often combined with structural
        models and then the measurement model part is referred to as the
        measurement component.
        See {manlink SEM intro 4}.

{phang}
{marker measurement_variables}{...}
{bf:measurement variables}, {bf:measure}, {bf:measurement}, {bf:x a measurement of X}, {bf:x measures X}.
        Observed variable x is a measurement of latent variable X
        if there is a path connecting x-> X.  Measurement variables
        are modeled by measurement models.  Measurement variables are
        also called {help sem glossary##indicator_variables:indicator variables}.

{phang}
{bf:method}.
        Method is just an English word and should be read in context. 
        Nonetheless, method is used here usually to refer to the 
        method used to solve for the fitted parameters of a structural 
        equation model.  Those methods are
	{help sem_glossary##ML:ML},
        {help sem_glossary##QML:QML}, 
	{help sem_glossary##MLMV:MLMV}, and
	{help sem_glossary##ADF:ADF}.  Also see
        {help sem_glossary##technique:technique}.

{phang}
{bf:MIMIC}.
	MIMIC stands for multiple indicators and multiple causes.  It
        is a kind of structural model in which observed causes determine a
        latent variable, which in turn determines multiple indicators.  See
        {manlink SEM intro 4}.

{phang}
{marker ML}{...}
{bf:ML}, {bf:method(ml)}.
        ML stands for maximum likelihood.  It is a method used to 
        obtain fitted parameters.  ML is the default method used by 
        {cmd:sem}.  Other available methods are
	{help sem_glossary##QML:QML}, 
	{help sem_glossary##MLMV:MLMV}, and
	{help sem_glossary##ADF:ADF}.

{phang}
{marker MLMV}{...}
{bf:MLMV}, {bf:method(mlmv)}.
	MLMV stands for maximum likelihood with missing values.  It is
        an ML method to obtain fitted parameters in the presence of
	missing values.  ML is the method used by {cmd:sem} when the 
	{cmd:method(mlmv)} option is specified.  Other available methods are
	{help sem_glossary##ML:ML}, 
	{help sem_glossary##QML:QML}, and {help sem_glossary##ADF:ADF}.
	Those methods omit from the
        calculation observations that contain missing values.

{phang}
{bf:modification indices}.
	Modification indices are score tests for adding 
        paths where none appear.  The paths can be for either coefficients or 
        covariances.

{phang}
{bf:moments (of a distribution)}.
        The moments of a distribution are the expected values of
        powers of a random variable or centralized (demeaned) powers of a
        random variable.  As used here, the first moments are the expected or
        observed means, and the second moments are the expected or observed
        variances and covariances.

{phang}
{bf:multiple correlation}.
	The multiple correlation is the correlation between endogenous variable
        y and its linear prediction.

{phang}
{marker multivariate_regression}{...}
{bf:multivariate regression}.
        Multivariate regression is a kind of structural model in which
        each member of a set of observed endogenous variables is a function
        of the same set of observed exogenous variables and a unique random
        disturbance term.  The disturbances are correlated.  Multivariate
        regression is a special case of
        {help sem glossary##SUREG:seemingly unrelated regression}.

{phang}
{marker nonrecursive_models}{...}
{bf:nonrecursive (structural) model (system)}, 
{bf:recursive (structural) model (system)}.
        A structural model (system) is said to be nonrecursive if there
        are paths in both directions between one or more pairs of endogenous
        variables.  A system is recursive if it is a system -- it has
        endogenous variables that appear with paths from them -- and it is
        not nonrecursive.

{pmore}
        A nonrecursive model may be unstable.  Consider, for instance, 

            y_1 = 2 y_2 + 1 x_1 + e_1
            y_2 = 3 y_1 - 2 x_2 + e_2

{pmore}
        This model is unstable.  To see this, without loss of generality,
        treat x_1 + e_1 and  2x_2 + e_2 as if they were both 0.  Consider
	y_1 = 1 and y_2 = 1.  Those values result in new values
	y_1 = 2 and y_2 = 3, and those result in new values
	y_1 = 6 and y_2 = 6, and those result in new values, ....
	Continue in this manner, and you reach infinity for both endogenous
	variables.  In the jargon of the mathematics used to check for this
	property, the eigenvalues of the coefficient matrix lie outside the
        unit circle.

{pmore}
        On the other hand, consider these values:

            y_1 = 0.5 y_2 + 1 x_1 + e_1
            y_2 = 1.0 y_1 - 2 x_2 + e_2

{pmore}
        These results are stable in that the resulting values converge
        to y_1 = 0 and y_2 = 0.  In the jargon of the mathematics used to
        check for this property, the eigenvalues of the coefficients
        matrix lie inside the unit circle.

{pmore}
        Finally, consider the values 

            y_1 = 0.5 y_2 + 1 x_1 + e_1
            y_2 = 2.0 y_1 - 2 x_2 + e_2

{pmore}
        Start with y_1 = 1 and y_2 = 1 and that yields new values
        y_1 = 0.5 and y_2 = 2 and that yields new values y_1 = 1
        and y_2 = 1, and that yields y_1 = 0.5 and y_2 = 2, and
        it will oscillate forever.  In the
        jargon of the mathematics used to check for this property, the
        eigenvalues of the coefficients matrix lie on the unit circle.  These
        coefficients are also considered to be unstable.
 
{phang}
{bf:normalization constraints}.
         See {help sem glossary##identification:identification}.

{phang}
{bf:normalized residuals}.
         See {help sem glossary##standardized_residuals:standardized residuals}.

{phang}
{marker observed_variables}{...}
{bf:observed variables}.
         A variable is observed if it is a variable in your dataset.  In
         this documentation, we often refer to observed variables using
         {cmd:x1}, {cmd:x2}, ..., {cmd:y1}, {cmd:y2}, and so on, but in
         reality observed variables have names such as {cmd:mpg},
         {cmd:weight}, {cmd:testscore}, and so on.

{pmore}
         In the software, observed variables are usually indicated by 
         having names that are all lowercase.

{pmore}
         Also see {help sem glossary##latent_variable:latent variable}.

{phang}
{marker OIM}{...}
{bf:OIM}, {bf:vce(oim)}.
        OIM stands for observed information matrix, defined 
        as the inverse of the negative of the matrix of second derivatives, 
        usually of the log-likelihood function.  The OIM is an
        estimate of the VCE.  OIM is the default VCE
        that {cmd:sem} reports.  The other available techniques are
	{help sem_glossary##EIM:EIM},
	{help sem_glossary##OPG:OPG},
	{help sem_glossary##robust:robust},
	{help sem_glossary##clustered:clustered},
	{help sem_glossary##bootstrap:bootstrap}, and
	{help sem_glossary##jackknife:jackknife}.

{phang}
{marker OPG}{...}
{bf:OPG}, {bf:vce(opg)}.
        OPG stands for outer product of the gradients, defined as the
        cross product of the observation-level first derivatives, usually of
        the log-likelihood function.  The OPG is an estimate of the
        VCE.  The other available techniques are 
	{help sem_glossary##OIM:OIM},
	{help sem_glossary##EIM:EIM},
        {help sem_glossary##robust:robust},
	{help sem_glossary##clustered:clustered}.
	{help sem_glossary##bootstrap:bootstrap}, and
	{help sem_glossary##jackknife:jackknife}.

{phang}
{bf:p-value}.
        P-value is another term for the reported significance
        level associated with a test.  Small p-values indicate
        rejection of the null hypothesis.

{phang}
{marker parameter_constraints}{...}
{bf:parameter constraints}.
         Parameter constraints are restrictions placed on the parameters
         of the model.  These constraints are typically in the form of zero
         constraints and equality constraints.  A zero constraint is implied,
         for instance, when no path is drawn connecting x with y.  An
         equality constraint is specified when one forces one path coefficient
         to be equal to another, or one covariance to be equal to another.

{pmore}
         Also see {help sem glossary##identification:identification}.
       
{phang}
{bf:parameters}.
        The parameters are the to-be-estimated coefficients of 
        a model.  These include all path coefficients, means, variances, and 
        covariances.  In mathematical notation, the theoretical parameters are
        often written as theta = (alpha, beta, mu,
        Sigma), where alpha is the vector of intercepts, 
        beta is the vector of path coefficients, mu is the vector
        of means, and Sigma is the matrix of variances and covariances.
        The resulting parameter estimates are written as theta hat.

{phang}
{marker path}{...}
{bf:path}.
        A path, typically shown as an arrow drawn from one variable to
        another, states that the first variable is determined by the second
        variable, at least partially.  If x -> y, or equivalently
        y <- x, then
        y_j = alpha + ... + beta x_j + ... + e.y_j,
        where beta is said to be the x -> y path coefficient.  The
        ellipses are included to account for paths to y from other variables.
        alpha is said to be the intercept and is automatically added when
        the first path to y is specified.

{pmore}
        A curved path is a curved line connecting two variables, and it
        specifies that the two variables are allowed to be correlated.  If
        there is no curved path between variables, the variables are usually
        assumed to be uncorrelated.  We say usually because correlation is
        assumed among all observed exogenous variables and, in the command
        language, assumed among all latent variables, and if some of the
        correlations are not desired, they must be suppressed.  Many authors
        refer to covariances rather than correlations.  Strictly speaking, the
        curved path denotes a nonzero covariance.  A correlation is often
        called a {help sem glossary##standardized_covariance:standardized covariance}.

{pmore}
        A curved path can connect a variable to itself and in that case,
        indicates a variance.  In path diagrams in this manual, we typically 
        do not show such variance paths even though variances are assumed.

{phang}
{bf:path coefficient}.
        The path coefficient is specified by a path; see 
       {help sem glossary##path:path}.
        Also see {help sem glossary##intercept:intercept}.

{phang}
{bf:path diagram}.
        A path diagram is a graphical representation that shows the
        relationships among a set of variables using
       {help sem glossary##path:paths}.
        See {manlink SEM intro 2} for a description of path diagrams.

{phang}
{bf:path notation}.
        Path notation is a syntax defined by the authors of Stata's
        {cmd:sem} command for entering path diagrams in a command
        language.  Models to be fit may be specified in path notation
        or they may be drawn using path diagrams into {cmd:sem}'s GUI.

{phang}
{marker QML}{...}
{bf:QML}, {bf:method(ml) vce(robust)}.
        QML stands for quasimaximum likelihood.  It is a method used to 
        obtain fitted parameters, and a technique used to obtain the
        corresponding VCE.  QML is used by {cmd:sem} when
        options {cmd:method(ml)} and {cmd:vce(robust)} are specified.
        Other available methods are
	{help sem_glossary##ML:ML},
        {help sem glossary##MLMV:MLMV}, and
	{help sem_glossary##ADF:ADF}.
        Other available techniques are
	{help sem_glossary##OIM:OIM}, {help sem_glossary##EIM:EIM},
	{help sem_glossary##OPG:OPG},
	{help sem_glossary##clustered:clustered},
	{help sem_glossary##bootstrap:bootstrap}, and
	{help sem_glossary##jackknife:jackknife}.

{phang}
{bf:regression}.
         A regression is a model in which an endogenous variable is 
         written as a function of other variables, parameters to be 
         estimated, and a random disturbance.

{phang}
{bf:reliability}.
         Reliability is the proportion of the variance of a variable not
         due to measurement error.  A variable without measure error has
         reliability 1.

{phang}
{bf:residual}.
         In this manual,  we reserve the word residual for the difference
         between the observed and fitted moments of an SEM model.
         We use the word error for the disturbance 
         associated with a linear equation; see
         {help sem glossary##error:error}.
         Also see
         {help sem glossary##standardized_residuals:standardized residual}.

{phang}
{marker robust}{...}
{bf:robust}, {bf:vce(robust)}.
	Robust is the name we use here for the Huber/White/sandwich 
        estimator (technique) of the VCE. 
        This technique requires fewer assumptions than most other techniques.
        In particular, it merely assumes that the errors are independently 
        distributed across observations and thus allows the errors 
        to be heteroskedastic.  Robust standard errors are reported when 
        the {cmd:sem} option {cmd:vce(robust)} is specified.
        The other available techniques are
	{help sem_glossary##OIM:OIM}, {help sem_glossary##EIM:EIM},
	{help sem_glossary##OPG:OPG},
	{help sem_glossary##clustered:clustered},
	{help sem_glossary##bootstrap:bootstrap}, and
	{help sem_glossary##jackknife:jackknife}.

{phang}
{marker saturated_model}{...}
{bf:saturated model}.
	A saturated model is a full covariance model -- a model of 
        fitted means and covariances of observed variables with any 
        restrictions on the values.  Also see
        {help sem glossary##baseline_model:baseline model}.

{phang}
{marker score_tests}{...}
{bf:score tests}, {bf:Lagrange multiplier tests}.
        A score test is a test based on first derivatives of a
        likelihood function.  Score tests are especially convenient for
        testing whether constraints on parameters should be relaxed or
        parameters should be added to a model.  Also see
        {help sem glossary##Wald_tests:Wald tests}.

{phang}
{bf:scores}.
	Scores has two unrelated meanings.  First, scores
        is the observation-by-observation first-derivatives of the 
        (quasi) log-likelihood function.  When we use the word scores, 
        this is what we mean.  Second, in the factor-analysis literature, 
        scores (usually in the context of factor scores) refers to 
        the expected value of a latent variable conditional on 
        all the observed variables.  We refer to this simply as the predicted 
        value of the latent variable.

{phang}
{bf:second-order latent variable}.
	See {help sem glossary##first_order_variables:first- and second-order latent variables}.

{phang}
{marker SUREG}{...}
{bf:seemingly unrelated regression}.
        Seemingly unrelated regression is a kind of structural model in
        which each member of a set of observed endogenous variables is a
        function of a set of observed exogenous variables and a unique random
        disturbance term.  The disturbances are correlated and the sets of
        exogenous variables may overlap.  If the sets of exogenous variables
        are identical, this is referred to as
       {help sem glossary##multivariate_regression:multivariate regression}.

{phang}
{bf:SEM}.
        SEM stands for structural equation modeling and for 
        structural equation model.  We use SEM in capital 
        letters when writing about theoretical or conceptual 
        issues as opposed to issues of the particular implementation 
        of SEM in Stata with the {cmd:sem} command.

{phang}
{bf:sem}.
        {cmd:sem} is the Stata command that fits structural equation models.

{phang}
{marker SSD}{...}
{bf:SSD}, {bf:ssd}.
        SSD stands for summary statistics data.  Data are sometimes 
        available only in summary statistics form, as 
        (1) means and covariances, (2) means, standard deviations or 
        variances, and correlations, (3) covariances, (4) standard deviations
        or variances and correlations, or (5) correlations.
        SEM can be used to fit models using such data in 
        place of the underlying raw data.  The {cmd:ssd} command 
        creates datasets containing summary statistics.

{phang}
{marker standardized_coefficient}{...}
{bf:standardized coefficient}.
        In a linear equation y = ... bx + ..., the standardized
        coefficient beta^* is (sigma_y hat/sigma_x hat)b.  Standardized
        coefficients are scaled to units of standard-deviation change in y
        for a standard-deviation change in x.

{phang}
{marker standardized_covariance}{...}
{bf:standardized covariance}.
        A standardized covariance between y and x is equal to the
        correlation of y and x, which is to say, it is equal to
        sigma_(xy) / sigma_x sigma_y.  The covariance is equal to the
        correlation when variables are standardized to have variance 1.

{phang}
{marker standardized_residuals}{...}
{bf:standardized residuals}, {bf:normalized residuals}.
         Standardized residuals are residuals adjusted so that they 
         follow a standard normal distribution.  The difficulty is that 
         the adjustment is not always possible.  Normalized residuals
         are residuals adjusted according to a different formula that 
         roughly follow a standard normal distribution.  Normalized residuals
         can always be calculated.

{phang}
{marker starting_values}{...}
{bf:starting values}.
        The estimation methods provided by {cmd:sem} are iterative. 
        The starting values are values for each of the parameters 
        to be estimated that are used to initialize the estimation process.
        The {cmd:sem} software provides starting values automatically, 
        but in some cases, these are not good enough and you must 
        1) diagnose the problem and 2) provide better starting values.
        See {manlink SEM intro 3}.

{phang}
{marker structural}{...}
{bf:structural equation model}.
        Different authors use the term structural equation model in different
        ways, but all would agree that a structural equation
        model sometimes carries the connotation of being a 
        {help sem glossary##structural_model:structural model}
        with a measurement component, which is to say, combined with a
        {help sem glossary##measurement_models:measurement model}.

{phang}
{marker structural_model}{...}
{bf:structural model}.
        A structural model is a model in which the parameters are not
        merely a description but believed to be of a causal nature.
        Obviously, SEM can fit structural models and thus so can
        {cmd:sem}.  Neither SEM nor {cmd:sem} are limited to fitting
        structural models, however.

{pmore}
        Structural models often have multiple equations and dependencies
        between endogenous variables, although that is not a
        requirement.

{pmore}
        See {manlink SEM intro 4}.
        Also see {help sem glossary##structural:structural equation model}.

{phang}
{bf:structured (correlation or covariance)}.
         See {help sem glossary##unstructured:unstructured and structured (correlation or covariance)}.

{phang}
{bf:substantive constraints}.
        See {help sem glossary##identification:identification}.

{phang}
{bf:summary statistics data}.
	See {help sem glossary##SSD:SSD}.

{marker technique}{...}
{phang}
{bf:technique}.
        Technique is just an English word and should be read in context.
        Nonetheless, technique is usually used here to refer to the technique 
        used to calculate the estimated VCE.  Those techniques are 
	{help sem_glossary##OIM:OIM}, {help sem_glossary##EIM:EIM},
	{help sem_glossary##OPG:OPG},
        {help sem glossary##robust:robust},
	{help sem_glossary##clustered:clustered},
	{help sem_glossary##bootstrap:bootstrap}, and
	{help sem_glossary##jackknife:jackknife}.

{pmore}
        Technique is also used to refer to the available techniques used
        by {cmd:ml}, Stata's optimizer and likelihood maximizer, to
        find the solution.

{phang}
{bf:total effects}.
        See {help sem glossary##direct:direct, indirect, and total effects}.

{phang}
{bf:unstandardized coefficient}.
	A coefficient that is not standardized.  If
        {cmd:mpg} = -0.006 x {cmd:weight} + 39.44028,
        then -0.006 is an
	unstandardized coefficient and, as a matter of fact, is measured in
        mpg-per-pound units.

{phang}
{marker unstructured}{...}
{bf:unstructured and structured (correlation or covariance)}.
        A set of variables, typically error variables, is said to have an
        unstructured correlation or covariance if the covariance matrix has
        no particular pattern imposed by theory.  If a pattern is imposed, 
        the correlation or covariance is said to be structured.

{phang}
{bf:VCE}, {bf:variance-covariance matrix (of the estimator)}.
        The estimator is the formula used to solve for the fitted
        parameters, sometimes called the fitted coefficients.  The VCE
        is the estimated variance-covariance matrix of the parameters.
        The diagonal elements of the VCE are the variances of the
        parameters, which is to say, the square root of those elements
        are the reported standard errors of the parameters.

{phang}
{marker Wald_tests}{...}
{bf:Wald tests}.  A Wald test is a statistical test based on the
estimated variance-covariance matrix of the parameters.  Wald tests are
especially convenient for testing possible constraints to be placed on
the estimated parameters of a model.  Also see 
{help sem glossary##score_tests:score tests}.

{phang}
{bf:WLS}, {bf:weighted least squares}.
        Weighted least squares is a method used to obtain fitted
        parameters.  In this documentation, WLS is referred to as
        ADF which stands for asymptotic distribution free.  Other
        available methods are 
	{help sem_glossary##ML:ML}, {help sem_glossary##QML:QML}, and
	{help sem_glossary##MLMV:MLMV}.
        ADF is, in fact, a specific kind of the more generic 
        WLS.

