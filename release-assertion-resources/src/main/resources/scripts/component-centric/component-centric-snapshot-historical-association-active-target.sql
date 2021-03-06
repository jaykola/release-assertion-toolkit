
/******************************************************************************** 
	component-centric-snapshot-historical-association-active-target

	Assertion:
	Active historical association refset members have active or limited status
	concepts as targets.

********************************************************************************/
	
	/* create view of limited status concepts */
	create or replace view v_limcons as
	   select referencedcomponentid from curr_attributevaluerefset_s 
	   where active = '1'
	   and valueid = '900000000000486000';



	select 
		<RUNID>,
		'<ASSERTIONUUID>',
		'<ASSERTIONTEXT>',
		concat('MEMBER: id=',a.id, ': Active Historical refset member is active, but maps to Target Component that is inactive concept.') 	
	
	from curr_associationrefset_s a
	inner join curr_concept_s b on a.targetcomponentid = b.id
	left join v_limcons c on c.referencedcomponentid = a.referencedcomponentid 
	where a.active = '1'
	and b.active = '0' 
	and c.referencedcomponentid is null;
	
	drop view v_limcons;
		