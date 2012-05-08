/******************************************************************************** 
	component-centric-snapshot-description-unique-terms

	Assertion:
	Active terms associated with active concepts are unique within hierarchy.

********************************************************************************/
	
/* 	a list of concepts and their semantic tags, for active concepts edited this release */
	drop temporary table if exists tmp_hierarchy;
	create temporary table if not exists tmp_hierarchy as
	select a.conceptid, concat('(',substring_index(a.term, '(', -1)) as semantictag
	from curr_description_s a
		join res_concepts_edited b
			on a.conceptid = b.conceptid
		join curr_concept_s c
			on 	c.id = b.conceptid
			and c.active = 1
	where a.typeid = '900000000000003001' /* fully specified name */
	and a.active = 1;
	commit;	 

/* 	a list of descriptions and their hierarchies */
	drop temporary table if exists tmp_description; 
	create temporary table if not exists tmp_description 
	select a.id, a.term, b.semantictag as semantictag
	from curr_description_s a
		join tmp_hierarchy b
			on a.conceptid = b.conceptid
	where a.active = 1;
	commit;

/* 	violators to the results table */	
	insert into qa_result (runid, assertionuuid, assertiontext, details)
	select 
		<RUNID>,
		'<ASSERTIONUUID>',
		'<ASSERTIONTEXT>',
		concat('DESC: id=',a.id, ':Term is not unique within hierarchy.') 
	from tmp_description a
	group by binary a.term, a.semantictag
	having count(a.term) > 1
	and count(a.semantictag) > 1;
	commit;
	
	drop temporary table if exists tmp_hierarchy;
	drop temporary table if exists tmp_description;
	
