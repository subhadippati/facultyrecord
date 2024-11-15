Create VIEW recent_discussions AS
select COUNT(*), dg.dtype,dg.group_title, dt.last_updated_date    #, COUNT(*) HAVING COUNT(*) = 10
from discussion_group as dg, discussion_thread as dt 	
where dg.group_id=dt.group_id  group by dt.last_updated_date;
#dg.dtype='GROUP' or  dg.dtype='CLUB'or dg.dtype='COURSE'and 

select * from recent_discussions;



create view recent_discussion_created as
select COUNT(*), dg.dtype,dg.group_title, dt.creation_date    
from discussion_group as dg, discussion_thread as dt 	
where dg.group_id=dt.group_id  group by dt.creation_date;
#HAVING COUNT(*)<=10

select * from recent_discussion_created;



select * from moderator;
create view moderator_set_1 as
select m.udid, m.first_name, dg.group_title 
from `moderator` as m
right join `discussion_group` as dg
on dg.moderator_user_id1=m.udid
where m.user_id IN (select m.user_id
					from `moderator` as m, `mainuser` as mu
                    where m.user_id=mu.user_name) order by m.udid;
                    
#2nd set of Moderatorsand the groups the are member of.
create view moderator_set_2 as
select m.udid, m.first_name, dg.group_title 
from `moderator` as m
right join `discussion_group` as dg
on dg.moderator_user_id2=m.udid
where m.user_id IN (select m.user_id
					from `moderator` as m, `mainuser` as mu
                    where m.user_id=mu.user_name) order by m.udid;
				
select * from moderator_set_1;
select * from moderator_set_2;



create view most_comments as
select COUNT(*),  dg.dtype ,c.title,dt.discussion_title
from comments as c, discussion_group as dg, discussion_thread as dt
where c.discussion_id=dt.discussion_id 
and dt.discussion_title IN (select dt.discussion_title
							  from discussion_thread as dt
							  where dt.group_id=dg.group_id) group by dt.discussion_title;

select * from most_comments;



create view books_interested as
select COUNT(*), s.first_name, br.title
from `student` as s, `student_books_and_ref_map` as sbrm
left join `books_and_references` as br
on br.id=sbrm.books_and_references_id 
where sbrm.student_id=s.udid group by br.title;

select * from books_interested;



create view gpa_faculty as
select fcp.faculty_id, fcp.course_id, c.course_name, f.first_name,
c.cdescription, avg(fcp.gpa)
from faculty_course_map as fcp, course as c, faculty as f
where fcp.course_id = c.udid and fcp.faculty_id = f.udid 
and fcp.faculty_id = 1 group by fcp.course_id ;

select * from gpa_faculty;


create view gpa_student as
select scp.student_id, scp.course_id, c.course_name, s.first_name, 
c.cdescription, avg(scp.gpa)
from student_course_map as scp, course as c, student as s
where scp.course_id = c.udid and scp.student_id = s.udid 
and scp.student_id = 1 group by scp.course_id ;

select * from gpa_student;

