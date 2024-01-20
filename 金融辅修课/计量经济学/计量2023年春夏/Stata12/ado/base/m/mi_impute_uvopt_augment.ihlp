{* *! version 1.0.1  07jun2011}{...}
{opt augment} specifies that augmented regression be performed if perfect
prediction is detected.  By default, an error is issued when perfect
prediction is detected.  The idea behind the augmented-regression approach is
to add a few observations with small weights to the data during estimation to
avoid perfect prediction.  See
{mansection MI miimputeRemarksTheissueofperfectpredictionduringimputationofcategoricaldata:{it:The issue of perfect prediction during imputation of categorical data}} 
under {it:Remarks} in {bf:[MI] mi impute} for more information.  {cmd:augment}
is not allowed with importance weights.
