# German Credit Risk
<img src="https://github.com/Bayunova28/German_Credit_Risk/blob/master/cover.png" height="450" width="1100">

## Context
<p align=justify>The original dataset contains 1000 entries with 20 categorial/symbolic attributes prepared by Prof. Hofmann. In this dataset, each entry represents a 
person who takes a credit by a bank. Each person is classified as good or bad credit risks according to the set of attributes. The link to the original dataset can be 
found below.</p>

## Content
<p align=justify>It is almost impossible to understand the original dataset due to its complicated system of categories and symbols. Thus, I wrote a small Python script 
to convert it into a readable CSV file. Several columns are simply ignored, because in my opinion either they are not important or their descriptions are obscure. The 
selected attributes are :</p>

* `Age : (numeric)`
* `Sex : (male, female)`
* `Job : (numeric: 0 - unskilled and non-resident, 1 - unskilled and resident, 2 - skilled, 3 - highly skilled)`
* `Housing : (text: own, rent, or free)`
* `Saving accounts : (text - little, moderate, quite rich, rich)`
* `Checking account : (numeric, in DM - Deutsch Mark)`
* `Credit amount : (numeric, in DM)`
* `Duration : (numeric, in month)`
* `Purpose : (text: car, furniture/equipment, radio/TV, domestic appliances, repairs, education, business, vacation/others)`

## Acknowledgements
Source : [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/Statlog+%28German+Credit+Data%29)
