/*---------------------------------------------------------
  The options statement below should be placed
  before the data step when submitting this code.
---------------------------------------------------------*/
options VALIDMEMNAME=EXTEND VALIDVARNAME=ANY;


/*---------------------------------------------------------
  Before this code can run you need to fill in all the
  macro variables below.
---------------------------------------------------------*/
/*---------------------------------------------------------
  Start Macro Variables
---------------------------------------------------------*/
%let SOURCE_HOST=<Hostname>; /* The host name of the CAS server */
%let SOURCE_PORT=<Port>; /* The port of the CAS server */
%let SOURCE_LIB=<Library>; /* The CAS library where the source data resides */
%let SOURCE_DATA=<Tablename>; /* The CAS table name of the source data */
%let DEST_LIB=<Library>; /* The CAS library where the destination data should go */
%let DEST_DATA=<Tablename>; /* The CAS table name where the destination data should go */

/* Open a CAS session and make the CAS libraries available */
options cashost="&SOURCE_HOST" casport=&SOURCE_PORT;
cas mysess;
caslib _all_ assign;

/* Load ASTOREs into CAS memory */
proc casutil;
  Load casdata="Bayesian_Network.sashdat" incaslib="Models" casout="Bayesian_Network" outcaslib="casuser" replace;
Quit;

/* Apply the model */
proc cas;
  fcmpact.runProgram /
  inputData={caslib="&SOURCE_LIB" name="&SOURCE_DATA"}
  outputData={caslib="&DEST_LIB" name="&DEST_DATA" replace=1}
  routineCode = "

   /*------------------------------------------
   Generated SAS Scoring Code
     Date             : 17Jul2022:18:03:55
     Locale           : en_US
     Model Type       : Bayesian Network
     Interval variable: Age
     Interval variable: Credit amount
     Interval variable: Duration
     Class variable   : Checking account
     Class variable   : Housing
     Class variable   : Purpose
     Class variable   : Saving accounts
     Class variable   : Sex
     Class variable   : Risk
     Response variable: Risk
     ------------------------------------------*/
declare object Bayesian_Network(astore);
call Bayesian_Network.score('CASUSER','Bayesian_Network');
   /*------------------------------------------*/
   /*_VA_DROP*/ drop 'I_Risk'n 'P_Riskbad'n 'P_Riskgood'n;
length 'I_Risk_1706'n $4;
      'I_Risk_1706'n='I_Risk'n;
'P_Riskbad_1706'n='P_Riskbad'n;
'P_Riskgood_1706'n='P_Riskgood'n;
   /*------------------------------------------*/
";

run;
Quit;

/* Persist the output table */
proc casutil;
  Save casdata="&DEST_DATA" incaslib="&DEST_LIB" casout="&DEST_DATA%str(.)sashdat" outcaslib="&DEST_LIB" replace;
Quit;
