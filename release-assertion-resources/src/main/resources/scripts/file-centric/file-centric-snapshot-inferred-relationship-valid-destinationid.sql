
/******************************************************************************** 
	file-centric-snapshot-inferred-relationship-valid-destinationid

	Assertion:
	All destination ids found in the Inferred Relationship snapshot file exist in the Concept snapshot file

********************************************************************************/
	
	insert into qa_result (runid, assertionuuid, assertiontext, details)
	select 
		<RUNID>,
		'<ASSERTIONUUID>',
		'<ASSERTIONTEXT>',
		concat('RELATIONSHIP: id=',a.id, ': Inferred Relationship contains a destination id that does not exist in the Concept snapshot file.') 	

	from curr_relationship_d a 
	left join curr_concept_s b on a.destinationid = b.id
	where b.id is null;