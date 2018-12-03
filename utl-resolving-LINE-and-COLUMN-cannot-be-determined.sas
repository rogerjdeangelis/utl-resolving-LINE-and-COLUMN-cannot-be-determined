Resolving LINE and COLUMN cannot be determined

Problem: This is the non descript error

   159: LINE and COLUMN cannot be determined.
   NOTE: NOSPOOL is on. Rerunning with OPTION SPOOL might allow
         recovery of the LINE and COLUMN where the error has occurred.

github
https://tinyurl.com/y8ot2ofl
https://github.com/rogerjdeangelis/utl-resolving-LINE-and-COLUMN-cannot-be-determined

macros
https://tinyurl.com/y9nfugth
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories

Stackoverflow
https://tinyurl.com/y9qb3yjm
https://stackoverflow.com/questions/53554608/line-and-column-cannot-be-determined-in-macro-sas

Better example on youtube?

INPUT
=====

  %macro pesee(nom, imprec, poids, nb_simul);
   data &nom.;
     do i=1 to &nb_simul.;
        PoidsR= RAND('UNIForm', &poids.*(1- &imprec.), &poids.*(1+ &imprec.),);
        output;
     end;
   run;
  %mend peesee;

  %pesee(Sucre, 0.1,200,3);


EXAMPLE OUTPUT
--------------

  345  +;
  346  +data Sucre;
  347  +do i=1 to 3;
  348  +PoidsR= RAND('UNIForm', 200*(1- 0.1), 200*(1+ 0.1),);
                                                           -
                                                           159
  ERROR 159-185: Null parameters for RAND are invalid.

  349  +output;
  350  +end;
  351  +run;


PROCESS
=======

  Using the 1980s SAS classic editor. Put the two macros below into
  member debug.sas in your autocall library.

  Hilite the macro with invocation and type debug on
  the clean command line (does not work any other SAS editor ie EE, UE, EG, SAS Studion, On Demand)

OUTPUT
======

see above

MAke Data

no data jus the probematic macro

*
 _ __ ___   __ _  ___ _ __ ___
| '_ ` _ \ / _` |/ __| '__/ _ \
| | | | | | (_| | (__| | | (_) |
|_| |_| |_|\__,_|\___|_|  \___/

;

%macro debug/cmd;
   store;note;notesubmit '%debuga;';
   run;
%mend debug;

%macro debuga;
   %let rc=%sysfunc(filename(myRef,%sysfunc(pathname(work))/mactxt.sas));
   %let sysrc=%sysfunc(fdelete(&myRef));
   %let rc=%sysfunc(filename(&myref));
   filename clp clipbrd ;
   data _null_;
     infile clp;
     file "%sysfunc(pathname(work))/macraw.sas";
     input;
     put _infile_;
   run;
   filename mprint  "%sysfunc(pathname(work))/mactxt.sas";
   options mfile mprint source2;
   %inc "%sysfunc(pathname(work))/macraw.sas";
   run;quit;
   options nomfile nomprint;
   filename mprint clear;
   %inc "%sysfunc(pathname(work))/mactxt.sas";
   run;quit;
%mend debuga;


