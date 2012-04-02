
/******************************************************************************** 
	file-centric-snapshot-definition-trim

	Assertion:
	No active Terms contain leading or trailing spaces.

********************************************************************************/
	
/* 	view of current snapshot made by finding FSN's with leading and training spaces */
	create or replace view v_curr_snapshot as
	select a.term from curr_textdefinition_s a 
	where a.active = 1
	and a.term != LTRIM(term)
	and a.term != RTRIM(term); 
	


	
/* 	inserting exceptions in the result table */
	insert into qa_result (runid, assertionuuid, assertiontext, details)
	select 
		<RUNID>,
		'<ASSERTIONUUID>',
		'<ASSERTIONTEXT>',
		concat('CONCEPT: id=',a.term, ':Active Terms with leading and trailing spaces.') 	
	from v_curr_snapshot a;


	drop view v_curr_snapshot;
	