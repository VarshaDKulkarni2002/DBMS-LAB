drop database university_yourname;


create database university_yourname;

\c university;

create table classroom
(building
 varchar(15),
room_number
 varchar(7),
capacity 
numeric(4,0),
primary key (building, room_number)
);



create table department
(dept_name
 varchar(20),
building
 varchar(15),
budget
 numeric(12,2) check (budget > 0),
primary key (dept_name)
);



create table course
(course_id
 varchar(8),
title
 varchar(50),
dept_name
 varchar(20),
credits
 numeric(2,0) check (credits > 0),
primary key (course_id),
foreign key (dept_name) references department
 on delete set null
);


create table instructor
(ID
 varchar(50),
name
 varchar(20) not null,
dept_name 
varchar(20),
salary
 numeric(8,2) check (salary > 29000),
primary key (ID),
foreign key (dept_name) references department
 on delete set null
);


create table student
(ID
 varchar(5),
name 
varchar(20) not null,
dept_name 
varchar(20),
tot_cred
 numeric(3,0) check (tot_cred >= 0),
primary key (ID),
foreign key (dept_name) references department 
on delete set null
);


create table section
(course_id 
varchar(8),
sec_id
 varchar(8),
semester 
varchar(6) 
check (semester in ('Fall', 'Winter', 'Spring', 'Summer')),
year 
numeric(4,0) check (year > 1701 and year < 2100),
building
 varchar(15),
room_number
 varchar(7),
time_slot_id
 varchar(4),
s_ID 
varchar(50),
primary key (course_id, sec_id, semester, year),foreign key (course_id) references course
 on delete cascade,
foreign key (building, room_number) references classroom
 on delete set null,
 foreign key(s_ID) references student(ID) on delete cascade);


create table teaches
(ID 
varchar(50),
course_id 
varchar(8),
sec_id 
varchar(8),
semester 
varchar(6),
year
 numeric(4,0),
primary key (ID, course_id, sec_id, semester, year),
foreign key (course_id,sec_id, semester, year) references section 
on delete cascade,
foreign key (ID) references instructor 
on delete cascade
);



create table takes
(ID
 varchar(5),
course_id
 varchar(8),
sec_id
 varchar(8),
semester
 varchar(6),
year 
numeric(4,0),
grade
 varchar(2),
primary key (ID, course_id, sec_id, semester, year),
foreign key (course_id,sec_id, semester, year) references section
 on delete cascade,
foreign key (ID) references student
 on delete cascade
);


create table advisor
(s_ID
 varchar(5),
i_ID 
varchar(50),
foreign key (i_ID) references instructor (ID) 
on delete set null,
foreign key (s_ID) references student (ID) 
on delete cascade
);


create table time_slot(time_slot_id 
varchar(4),
day
 varchar(1),
start_hr 
numeric(2) check (start_hr >= 0 and start_hr < 24),
start_min 
numeric(2) check (start_min >= 0 and start_min < 60),
end_hr
 numeric(2) check (end_hr >= 0 and end_hr < 24),
end_min 
numeric(2) check (end_min >= 0 and end_min < 60),
primary key (time_slot_id, day, start_hr, start_min)
);


create table prereq
(course_id
 varchar(8),
prereq_id
 varchar(8),
primary key (course_id, prereq_id),
foreign key (course_id) references course
 on delete cascade,
foreign key (prereq_id) references course
);


insert into classroom values ('Packard', '101', '500');

insert into classroom values ('Painter', '514', 10);



insert into department values ('Biology', 'Watson', 90000);

insert into department values ('Comp. Sci.', 'Taylor', 100000);

insert into department values ('Elec. Eng.', 'Taylor', 85000);



insert into course values ('BIO-101', 'Intro. to Biology', 'Biology', 4);

insert into course values ('BIO-301', 'Genetics', 'Biology', 4);

insert into course values ('BIO-399', 'Computational Biology', 'Biology', 3);

insert into course values ('CS-101', 'Intro. to Computer Science', 'Comp. Sci.', 4);



insert into instructor values ('10101', 'Ramanujan', 'Comp. Sci.', 65000);



insert into instructor values ('83822', 'Srinivas', 'Comp. Sci.', 92000);

insert into instructor values ('98346', 'Ashok', 'Elec. Eng.', 80000);


insert into section values ('BIO-101', '1', 'Summer', 2019, 'Painter', '514', 'B','00128');


insert into teaches values ('10101', 'CS-101', '1', 'Fall', 2019);


insert into takes values ('00128', 'CS-101', '1', 'spring', 2020, 'A');


insert into advisor values ('00128', '45565');

insert into advisor values ('12345', '10101');

insert into advisor values ('23121', '76543');

insert into time_slot values ('A', 'M', 8, 9, 8, 50);

insert into time_slot values ('G', 'F', 16, 9, 16, 50);



insert into prereq values ('BIO-301', 'BIO-101');

