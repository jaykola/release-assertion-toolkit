
/******************************************************************************** 
	component-centric-snapshot-description-active-inactive-term-match

	Assertion:
	No active term associated with active concept matches that of an inactive 
	description.

	Note: 	many violations of this assertion were created in prior SNOMED CT 
			releases. Consequently this implementation focuses on highlighting 
			new violations created in the currently prospective release.

	no term of an active description of a concept of which a description was edited 
	matches that of an inactive description within the same concept

	Note: NOT case sensitive	

********************************************************************************/

/* 	limit to a list of active concepts of which descriptions have been edited 
	this release 
*/
	drop temporary table if exists tmp_edited_con;
	create temporary table if not exists tmp_edited_con as
	select distinct a.*
	from curr_concept_s a
		join curr_description_d b
			on a.id = b.conceptid
			and a.active = 1;
	commit;

/* list of active description of active concepts edited for this release */
	drop temporary table if exists tmp_active_desc;
	create temporary table if not exists tmp_active_desc as	
	select a.*
	from curr_description_s a
		join tmp_edited_con b
			on a.conceptid = b.id
			and a.active = 1;
	commit;

/* list of inactive description of active concepts edited for this release */
	drop temporary table if exists tmp_inactive_desc;
	create temporary table if not exists tmp_inactive_desc as	
	select a.*
	from curr_description_s a
		join tmp_edited_con b
			on a.conceptid = b.id
			and a.active = 0;
	commit;

/* 	violators are active descriptions of which the terms are the same as 
	inactive descriptions for a given concept 
*/ 
	insert into qa_result (runid, assertionuuid, assertiontext, details)
	select 
		<RUNID>,
		'<ASSERTIONUUID>',
		'<ASSERTIONTEXT>',
		concat('DESC: Id=',a.id, ':active term matches inactive term of same concept.') 	
	from tmp_active_desc a
		join tmp_inactive_desc b
			on a.conceptid = b.conceptid
			and a.term = b.term
			and a.active != b.active;
	commit;

	drop temporary table if exists tmp_edited_con;
	drop temporary table if exists tmp_active_desc;
	drop temporary table if exists tmp_inactive_desc;
