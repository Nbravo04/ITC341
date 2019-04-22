-- Nicholas Bravata, Brava1nj
-- creates the COMPANY DB-schema
-- partial

-- ALSO SEE figures 4.1 and 4.2 of Text (Elmasri 6th Ed.)

-- keep these two commands at the top of every sql file
set echo on
set linesize 120

drop table Employee cascade constraints;
commit;

create table Employee 
(
	fname varchar(15),
	minit varchar(1),
	lname varchar (15),
	ssn char(9),
	bdate date,
	address varchar(50),
	sex varchar(1) 	CHECK(Sex = 'M' or Sex = 'F'),
	salary number, CHECK(20000 <= salary and salary <= 100000), 
	superssn char(9),
	dno number	DEFAULT 0,
	constraint EMPPK
	    primary key(ssn),
	constraint EMPSUPERVRFK
	    foreign key(superssn) references Employee(ssn)
	    	ON DELETE SET NULL
--
--   Note:
--	ON DELETE SET DEFAULT, ON UPDATE CASCADE
-- Oracle does not support cascading updates, and does not allow you to set the value to the default 
-- when the parent row is deleted. Your two options for an on delete behavior are cascade or set null. 
-- Tested: February 05, 2018
--	, constraint EMPDEPTFK 
--		foreign key(dno) references Department(dnumber) 
--			ON DELETE SET NULL
-- ERROR - Department table has not been created yet
-- need to postpone this constraint
-- use alter table command to add this constraint
-- alter table Employee add constraint EMPDEPTFK 
--     foreign key(dno) references Department(dnumber) 
--     ON DELETE SET NULL
--
);

drop table Department cascade constraints;
commit;
create table Department 
(
	dname varchar(15) 	NOT NULL,
	dnumber number,
	mgrssn char(9)		DEFAULT '000000000',
	mgrstartdate date,
	constraint DEPTPK
	    primary key(dnumber),
	constraint DEPTMGRFK
	    foreign key(mgrssn) references Employee(ssn)
			ON DELETE SET NULL 
--
--		ON DELETE SET DEFAULT, ON UPDATE CASCADE  
--
-- The above actions for DELETE SET DEFAULT and for UPDATE CASCADE does not work
-- with  the current SQL-plus version we have at this time. 
-- Just use SET NULL for delete and disable the update action part of the constraint.
--
);

alter table Employee add 
	constraint EMPDEPTFK foreign key(dno) references Department(dnumber) 
	ON DELETE SET NULL;

-- ADD the rest

drop table Dept_Locations cascade constraints;
commit;
create table Dept_Locations 
(
	dnumber number,
	dlocation char(15),
	constraint DEPT_LOCPK
	    primary key(dnumber, dlocation),
	constraint DEPT_LOCFK
		foreign key(dnumber) references Department(dnumber)
);

drop table Project cascade constraints;
commit;
create table Project
(
	pname char(20),
	pnumber number,
	plocation char(15),
	dnum number,
	constraint PROJECTPK
	    primary key(pnumber),
	constraint PROJECTFK
		foreign key(dnum) references Department(dnumber)
);

drop table Works_On cascade constraints;
commit;
create table Works_On
(
	essn char(9),
	pno number,
	hours number,
	constraint WORKS_ONPK
	    primary key(essn, pno),
	constraint WORKS_ONFK
		foreign key(essn) references Employee(ssn),
		foreign key(pno) references Project(pnumber)
);

drop table Dependent cascade constraints;
commit;
create table Dependent
(
	essn char(9),
	dependent_name char(15),
	sex varchar(1) 	CHECK(Sex = 'M' or Sex = 'F'),
	bdate date,
	relationship char(10),
	constraint DEPENDENTPK
	    primary key(essn, dependent_name),
	constraint DEPENDENTFK
		foreign key(essn) references Employee(ssn)
);




