
/******************************************************************************** 
	file-centric-snapshot-attribute-value-unique-id

	Assertion:
	ID is unique in the ATTRIBUTE VALUE snapshot.

********************************************************************************/
	
/* 	view of current snapshot made by finding duplicate ids */
	create or replace view v_curr_snapshot as
	select a.id
	from curr_attributevaluerefset_s a	
	group by a.id
	having  count(a.id) > 1;
	

	
/* 	inserting exceptions in the result table */
	insert into qa_result (runid, assertionuuid, assertiontext, details)
	select 
		<RUNID>,
		'<ASSERTIONUUID>',
		'<ASSERTIONTEXT>',
		concat('ATT RS: id=',a.id, ':Non unique id in ATTRIBUTE VALUE snapshot file.') 	
	from v_curr_snapshot a;


	drop view v_curr_snapshot;
