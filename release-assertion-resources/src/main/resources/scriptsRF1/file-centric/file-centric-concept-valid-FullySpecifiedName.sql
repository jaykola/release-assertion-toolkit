
/******************************************************************************** 
	file-centric-snapshot-concept-unique-id

	Assertion:
	The current Concept snapshot file has unique identifiers.

********************************************************************************/
	
/* 	view of current snapshot made by finding duplicate identifiers */
	create or replace view v_curr_snapshot as
	select a.id
	from curr_concept_s a
	group by a.id
	having  count(a.id) > 1;
	

	
/* 	inserting exceptions in the result table */
	insert into qa_result (runid, assertionuuid, assertiontext, details)
	select 
		<RUNID>,
		'<ASSERTIONUUID>',
		'<ASSERTIONTEXT>',
		concat('CONCEPT: id=',a.id, ':Non unique id in current release file.') 	
	from v_curr_snapshot a;


	drop view v_curr_snapshot;
