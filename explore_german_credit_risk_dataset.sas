/* Drop column of dataset */
proc sql;
	title "Drop VAR1 Column";
	alter table mydata.german_credit_risk
	drop VAR1;
quit;

proc print data=mydata.german_credit_risk(obs=5);
run;
	
/* Descriptive Statistics */
proc means data=mydata.german_credit_risk mean median mode std var min max;
	title "Descriptive Statistics";
run;

/* Check missing values */
proc means data=mydata.german_credit_risk nmiss;
 	title "Missing Values";
run;

/* Visualize correlation of credit amount with age */
proc sgplot data=mydata.german_credit_risk;
 	title "Credit Amount vs Age by Gender";
 	scatter x='Credit amount'n y=Age / group=Sex;
run;

/* Visualize correlation of credit amount with duration */
proc sgplot data=mydata.german_credit_risk;
 	title "Credit Amount vs Duration by Gender";
 	scatter x='Credit amount'n y=Duration / group=Sex;
run;

/* Visualize distribution of age */
proc sgplot data=mydata.german_credit_risk;
 	title "Distribution of Age";
 	histogram Age;
run;

/* Visualize distribution of duration */
proc sgplot data=mydata.german_credit_risk;
 	title "Distribution of Duration";
 	histogram Duration;
run;

/* Visualize distribution of credit amount */
proc sgplot data=mydata.german_credit_risk;
 	title "Distribution of Credit Amount";
 	histogram 'Credit amount'n;
run;

/* Check gender by total credit amount */
proc sql;
 	title "Gender by Total Credit Amount";
 	select Sex, sum('Credit amount'n) as 'Total Credit Amount'n
 	from mydata.german_credit_risk
 	group by Sex
 	order by 'Total Credit Amount'n desc;
quit;

/* Visualize gender by credit amount */
proc gchart data=mydata.german_credit_risk;
 	title "Gender by Total Credit Amount";
 	pie Sex / type=sum sumvar='Credit amount'n detail_percent=best detail_value=none detail_slice=best;
run;
quit;

/* Check housing by credit amount */
proc sql;
 	title "Housing by Total Credit Amount";
 	select Housing, sum('Credit amount'n) as 'Total Credit Amount'n
 	from mydata.german_credit_risk
 	group by Housing
 	order by 'Total Credit Amount'n desc;
quit;

/* Visualize housing by total credit amount */
proc gchart data=mydata.german_credit_risk;
 	title "Housing by Total Credit Amount";
 	pie Housing / type=sum sumvar='Credit amount'n detail_percent=best detail_value=none detail_slice=best;
run;

/* Replace missing values */
data german_credit;
 	set mydata.german_credit_risk;
 	if 'Saving accounts'n='NA' then 'Saving accounts'n='Unknown';
 	if 'Checking account'n='NA' then 'Checking account'n='Unknown';
run;

/* Check saving accounts by total credit amount */
proc sql;
 	title "Saving Accounts by Total Credit Amount";
 	select 'Saving accounts'n, sum('Credit amount'n) as 'Total Credit Amount'n
 	from german_credit
 	group by 'Saving accounts'n
 	order by 'Total Credit Amount'n desc;
quit;

/* Visualize saving accounts by total credit amount */
proc gchart data=german_credit;
 	title "Saving Accounts by Total Credit Amount";
 	vbar 'Saving accounts'n / type=sum sumvar='Credit amount'n descending outside=sum width=13;
run;
quit;

/* Check checking account by total credit amount */
proc sql;
 	title "Checking Account by Total Credit Amount";
 	select 'Checking account'n, sum('Credit amount'n) as 'Total Credit Amount'n
 	from german_credit
 	group by 'Checking account'n
 	order by 'Total Credit Amount'n desc;
quit;

/* Visualize checking account by total credit amount */
proc gchart data=german_credit;
 	title "Checking Account by Total Credit Amount";
 	hbar 'Checking account'n / type=sum sumvar='Credit amount'n descending outside=sum;
run;
quit;

/* Check purpose by total credit amount */
proc sql;
 	title "Purpose by Total Credit Amount";
 	select Purpose, sum('Credit amount'n) as 'Total Credit Amount'n
 	from german_credit
 	group by Purpose
 	order by 'Total Credit Amount'n desc;
quit;

/* Visualize purpose by total credit amount */
proc gchart data=german_credit;
 	title "Purpose by Total Credit Amount";
 	hbar Purpose / type=sum sumvar='Credit amount'n descending outside=sum;
run;
quit;

/* Visualize number of job by gender */
proc sgplot data=german_credit;
 	title "Number of Job by Gender";
 	vbar Job / group=Sex groupdisplay=cluster;
run;

/* Visualize number of housing by gender */
proc sgplot data=german_credit;
 	title "Number of Housing by Gender";
 	vbar Housing / group=Sex groupdisplay=cluster;
run;

/* Visualize number of saving accounts by gender */
proc sgplot data=german_credit;
 	title "Number of Saving Accounts by Gender";
 	vbar 'Saving accounts'n / group=Sex groupdisplay=cluster;
run;

/* Visualize number of checking account by gender */
proc sgplot data=german_credit;
 	title "Number of Checking Account by Gender";
 	vbar 'Checking account'n / group=Sex groupdisplay=cluster;
run;

/* Visualize number of purpose by gender */
proc sgplot data=german_credit;
 	title "Number of Purpose by Gender";
 	hbar Purpose / group=Sex groupdisplay=cluster;
run;