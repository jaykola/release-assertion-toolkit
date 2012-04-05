
/******************************************************************************** 
	file-centric-snapshot-ctv3-unique

	Assertion:
	CTV3 simple map refset members are unique.

********************************************************************************/
	
	
	insert into qa_result (runid, assertionuuid, assertiontext, details)
	select 
		<RUNID>,
		'<ASSERTIONUUID>',
		'<ASSERTIONTEXT>',
		concat('Member: id=',a.id, ': CTV3 member is not unique.') 
	
		from curr_simplemaprefset_s a
		inner join curr_concept_s b
		on a.referencedcomponentid = b.id
		where a.refsetid = '900000000000497000'
		and b.active = '1'
		group by a.id
		having count(*) != 1