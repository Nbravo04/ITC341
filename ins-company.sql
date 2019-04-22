-- Nicholas Bravata, Brava1nj
-- inserts tuples into the COMPANY DB
-- partial

-- keep these two commands at the top of every sql file
set echo on
set linesize 120

delete from Employee;
commit;

-- insert only managers first with their dno is null
INSERT INTO employee VALUES 
  ('James','E','Borg','888665555','10-NOV-27','450 Stone, Houston, TX','M',55000,null,null);
INSERT INTO employee VALUES 
  ('Franklin','T','Wong','333445555','08-DEC-45','638 Voss, Houston, TX','M',40000,'888665555',null);
INSERT INTO employee VALUES 
  ('Jennifer','S','Wallace','987654321','20-JUN-41','291 Berry, Bellaire, TX','F',43000,'888665555',null);


delete from Department;
commit;
insert into Department values ('Research',5,'333445555','22-MAY-88');
insert into Department values ('Headquarters',1,'888665555','19-JUN-81');
insert into Department values ('Administration',4,'987654321','01-JAN-95');

-- now, update employee.dno for managers
UPDATE employee SET dno = 1 WHERE ssn = '888665555';
UPDATE employee SET dno = 5 WHERE ssn = '333445555';
UPDATE employee SET dno = 4 WHERE ssn = '987654321';

-- insert the rest of non-manager employees, supervisors first
insert into Employee values ('John','B','Smith','123456789','09-JAN-65','731 Fondren, Houston, TX','M',30000,'333445555',5);
insert into Employee values ('Alica','J','Zelaya','999887777','19-JAN-68','3321 Castle, Spring, TX','F',25000,'987654321',4);
insert into Employee values ('Ramesh','K','Narayan','666884444','15-SEP-62','975 Fire Oak, Humble, TX','M',38000,'333445555',5);
insert into Employee values ('Joyce','A','English','453453453','31-JUL-72','5631 Rice, Houston, TX','F',25000,'333445555',5);
insert into Employee values ('Ahmad','V','Jabbar','987987987','29-MAR-69','980 Dallas, Houston, TX','M',25000,'987654321',4);

-- ADD the rest
commit;

insert into Dept_Locations values(1,'Houston');
insert into Dept_Locations values(4,'Stafford');
insert into Dept_Locations values(5,'Bellaire');
insert into Dept_Locations values(5,'Sugarland');
insert into Dept_Locations values(5,'Houston');

insert into Project values('ProjectX', 1, 'Bellaire', 5);
insert into Project values('ProjectY', 2, 'Sugarland', 5);
insert into Project values('ProjectZ', 3, 'Houston', 5);
insert into Project values('Computerization', 10, 'Stafford', 4);
insert into Project values('Reorganization', 20, 'Houston', 1);
insert into Project values('Newbenefits', 30, 'Stafford', 4);

insert into Works_On values(123456789, 1, 32.5);
insert into Works_On values(123456789, 2, 7.5);
insert into Works_On values(666884444, 3, 40.0);
insert into Works_On values(453453453, 1, 20.0);
insert into Works_On values(453453453, 2, 20.0);
insert into Works_On values(333445555, 2, 10.0);
insert into Works_On values(333445555, 3, 10.0);
insert into Works_On values(333445555, 10, 10.0);
insert into Works_On values(333445555, 20, 10.0);
insert into Works_On values(999887777, 30, 30.0);
insert into Works_On values(999887777, 10, 10.0);
insert into Works_On values(987987987, 10, 35.0);
insert into Works_On values(987987987, 30, 5.0);
insert into Works_On values(987654321, 30, 20.0);
insert into Works_On values(987654321, 20, 15.0);
insert into Works_On values(888665555, 20, null);

insert into Dependent values('333445555', 'Alice', 'F', '05-APR-86', 'Daughter');
insert into Dependent values('333445555', 'Theodore', 'M', '25-OCT-83', 'Son');
insert into Dependent values('333445555', 'Joy', 'F', '03-MAY-58', 'Spouse');
insert into Dependent values('987654321', 'Abner', 'M', '28-FEB-42', 'Spouse');
insert into Dependent values('123456789', 'Michael', 'M', '04-JAN-88', 'Son');
insert into Dependent values('123456789', 'Alice', 'F', '30-DEC-88', 'Daughter');
insert into Dependent values('123456789', 'Elizabeth', 'F', '05-MAY-67', 'Spouse');