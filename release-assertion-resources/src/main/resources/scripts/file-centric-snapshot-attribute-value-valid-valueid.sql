
/******************************************************************************** 
	file-centric-snapshot-attribute-value-valid-valueid

	Assertion:
	ValueId refers to valid concepts in the ATTRIBUTE VALUE snapshot.

********************************************************************************/
	
/* 	view of current snapshot made by finding duplicate identifiers */
	create or replace view v_curr_snapshot as
	select a.valueid
	from curr_attributevaluerefset_s a
	left join curr_concept_s b
	on a.valueid = b.id
	where b.id is null;
	

	
/* 	inserting exceptions in the result table */
	insert into qa_result (runid, assertionuuid, assertiontext, details)
	select 
		<RUNID>,
		'<ASSERTIONUUID>',
		'<ASSERTIONTEXT>',
		concat('CONCEPT: id=',a.valueid, ':'Invalid ValueId in the ATTRIBUTE VALUE REFSET snapshot file.')
	from v_curr_snapshot a;


	drop view v_curr_snapshot;