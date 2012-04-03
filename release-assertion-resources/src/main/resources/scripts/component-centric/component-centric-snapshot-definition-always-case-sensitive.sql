
/******************************************************************************** 
	component-centric-snapshot-definition-always-case-sensitive.sql

	Assertion:
	All definitions are case sensitive.

********************************************************************************/
	
/* 	view of current snapshot made by finding FSN's with leading and training spaces */
	create or replace view v_curr_snapshot as
	select a.id 
	from curr_textdefinition_s a 
	where a.casesignificanceid != '900000000000017005';
	
	
/* 	inserting exceptions in the result table */
	insert into qa_result (runid, assertionuuid, assertiontext, details)
	select 
		<RUNID>,
		'<ASSERTIONUUID>',
		'<ASSERTIONTEXT>',
		concat('CONCEPT: id=',a.id, ':Definitions are not case sensitive.') 	
	from v_curr_snapshot a;


	drop view v_curr_snapshot;
	