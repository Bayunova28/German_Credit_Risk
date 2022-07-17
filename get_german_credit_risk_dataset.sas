/* Read folder file */
libname mydata base "/home/u60033390/Bank";

/* Load & import dataset */
filename refile "/home/u60033390/Bank/german_credit_data.csv";

proc import datafile=refile
	dbms=csv
 	out=mydata.german_credit_risk;
 	getnames=yes;
run;

/* Show 5 rows of dataset */
proc print data=mydata.german_credit_risk(obs=5);
run;

/* Describe of dataset */
proc contents data=mydata.german_credit_risk;
	title "Dataset Description";
run;

/* Set dataset name original to new dataset storage */
data work.credit_test;
 set mydata.german_credit_risk;
run;

data credit_test;
 set mydata.german_credit_risk;
run;