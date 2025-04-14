﻿# LawLink Advanced Programming
1	Initial ERD
 
Figure 1 Initial ERD
2	Normalization 

Database management world employs Normalization as an elementary database practice. system (DBMS). A method of data organization builds the foundation of a systematic database approach.The system implements organization structures systematically to reduce dependency and excess data storage. Normalization is Data splitting through Normalization produces one or multiple database tables with related descriptions. relationship between tables. The data storage process becomes possible through this approach. The database system achieves effective organization with no data conflicts occurring in its structure. The main purpose of Normalization is to destruct duplicate database entries and build logical data dependencies. dependency are logical. The databased efficiency increases because it maintains and updates more easily over time. expand overtime. Data manipulation processes experience minimal risk of producing anomalies due to this technique. The procedures for inserting, deleting and updating involve data from these anomalies. Such inconsistencies within the data system can harm database integrity as well as generate inaccuracies. exactness of the database.  

A standardized method for Normalization exists under the name Normal One normal form leads to another through the application of standardized procedures that enhance relational database structure. Each stage of normalization improves the structure of the database. The series of normal forms improves database structure through a systematic process. of steps called normalization. This process aims to eliminate particular dependencies of information within the database structure. Second Normal Form (2NF) starts the process of removing different types of redundant and dependency issues in the data. The method progresses through 1NF, 2NF, 3NF, and following normal forms. If we stick to these normal A database design derived from normal forms leads to storage efficiency in addition to data access performance improvements. The database structure becomes more efficient alongside lower performance costs and easier administration capabilities and scalable database possibilities. scalable foundation for database growth. Defining types of normalization: 
Normalization form

2.1	UNormalization  Form (UNF) :

The Normalization process initiates using the unnormalized form (UNF). No data redundancy or dependency exists when information does not relate to anything that requires whole or partial data. The existence of multi valued attributes alongside repeating groups in data causes difficulties when querying and maintaining such databases. The normalization procedure begins after collecting UNF data through its raw data extraction. As a primary stage of systematic data organization, the data must be transformed from UNF into the first normal form (1NF). The Unormalization forms lack clear guidelines whereas 1NF represents the roughest normalization stage having duplicate data in its table structure.  

Admins (admin_id, username, password, email, full_name, phone, last_login, is_active, profile_image {lawyer_id, username, password, email, full_name, phone, address, registration_date, last_login, is_active, profile_Image, specialization, practice_areas, experience_years, education, license_number, about_me, consultation_fee, is_verified, is_available, rating, {area_id, area_name, description}, {day_of_week, is_available}, {appointment_id, appointment_date, appointment_time, duration, status, notes, created_at, updated_at, client_id, username, password, email, full_name, phone, address, registration_date, last_login, is_active, profile_image, date_of_birth, gender, {review_id, rating, comment, review_date}}})


Here the Admin is assumed as the non-repetitive entities, so it is stored as primary key, other are the attributes contained in the admin table, where none of the rules of normalization are applied properly, and all the attributes are associated with a single key primary value that is admin. This is the raw set of data before applying any rules and regulations.
 
2.2	First Normal Form(1NF):
Tables following the First Normal Form(1NF) must contain single values in each column without attempted subdivision. be further divided. A table must adhere to the First Normal Form by getting rid of all repeating groups. Every table requires only one distinct value which serves as its primary key according to 1NF. Every field in the database must have a single value to achieve proper data organization. Further Normalization becomes possible while removal of redundant data occurs at this stage.  The single entity in the UNF remains non-recurring inside small brackets. bracket and 2 groups of repetitive entity group’s attributes in 1NF the one table from the three group of entity emerge from a single UNF. The rules followed by the first Normal forms are:

1.	Atomic Values: Each attribute consists of atomic/individual values like in Admin-1 admin_id only contains single student admin ID and username consist of only one username, address soon. a single data, single number or a single word is only included once.

2.	No repeating groups: Multiple columns containing identical data types should be replaced with multiple rows. Dual-row structures have higher effectiveness than multi-column structures. Commit to maintaining single-value records in every field.

3.	Contains unique identifiers: Each table consists of different unique identifiers which are known as primary key, and it uniquely identifies each row of the tables so there will be no data collision or any mistakes.

Notation in 1NF:
o	Each entity name receives the hyphen symbol “-1” as an indicator for First Normal Form (1NF).
o	Each row in the table gets its uniqueness from the primary key attribute which is marked with (PK) and underlined.
o	The asterisk (*) notation marks down key foreign attributes because they link to principal key elements of linked tables.

Final first normalization form:
Admins-1 (admin_id, username, password, email, full_name, phone, last_login, is_active, profile_image)
Lawyers_1 (lawyer_id, username, password, email, full_name, phone, address, registration_date, last_login, is_active, profile_Image, specialization, practice_areas, experience_years, education, license_number, about_me, consultation_fee, is_verified, is_available, rating, admin_id*)
LawyerPractiseAreas_1 {area_id, area_name, description, lawyer_id*}
Lawyer_Availability_1 (day_of_week, is_available, lawyer_id*)
Appointments_1 (appointment_id, appointment_date, appointment_time, duration, status, notes, created_at, updated_at, client_id, username, password, email, full_name, phone, address, registration_date, last_login, is_active, profile_image, date_of_birth, gender, lawyer_id*)
Reviews_1 (review_id, rating, comment, review_date, appointment_id*)


 
2.3	Second normal form (2NF):

Second Normal Form or 2NF constitutes a vital stage of data normalization which aims to remove redundancy while fixing distinct forms of database anomalies. A partial dependency in data occurs when a non-key database attribute requires all or part of a composite primary key for dependency. The table shows such dependency when it uses composite keys that hold multiple primary key attributes although some non-key attributes depend only on selected elements of the composite key. A table with multiple attributes forming the key contains some non-key fields which depend solely on specific key attributes instead of stringing together with all key attributes. Second normal form (2NF) ensures that non-prime attributes depend on the full primary key and not just a partial key through its set of requirements which are described below.
1.	Must be in 1NF: A first normal form database implementation is essential since all attributes   need to represent indivisible entities and rows should not include repeating value groups.

2.	No Partial Dependencies: The database design violates the rule when any attribute relies on a portion of the composite key instead of depending on the whole key structure. 

Notation in 1NF:
1. The table requires first meeting the requirement of 1NF which means every attribute should    only have minimal atomic values without any repeated column groupings. 
2. A primary key composed of multiple attributes forms the basis of such a key structure. 
3. A non-key attribute becomes partially dependent on one or multiple segments(s) of the composite primary key when it meets this requirement. 
4. The table contains features which do not function as primary key components.

 
In Admin-2,
There is only one single key attribute which uniquely identify All the non key attributes are fully functionally dependent on the primary key which is admin_id. Hence,
FFD: 
admin_id → username, password, email, full_name, phone, last_login, is_active, profile_image
Therefore,
Admins-2 (admin_id, username, password, email, full_name, phone, last_login, is_active, profile_image)

In the Lawayers-2 
There is also only one single key attribute which uniquely identify all the non key attributes and from the above table we have also imported admin_id as foreign key attributes.
FFD:
lawyer_id → username, password, email, full_name, phone, address, registration_date, last_login, is_active, profile_image, specialization, practice_areas, experience_years, education, license_number, about_me, consultation_fee, is_verified, is_available, rating, admin_id*
Therefore:
Lawyers_2 (lawyer_id, username, password, email, full_name, phone, address, registration_date, last_login, is_active, profile_Image, specialization, practice_areas, experience_years, education, license_number, about_me, consultation_fee, is_verified, is_available, rating, admin_id*)


In LawyerPractiseAreas-2 
The table establishes an extensive connection between Lawyers and PractiseAreas because one lawyer can handle multiple practice areas, and one area belongs to multiple lawyers. It consist of:
	Composite key: area_id, lawyer_id

	Partial functional dependency (PFD):
 	 area_id → area_name, description

	Full functional dependency(FFD):
 lawyer_id, area_id → X
Therefore,

LawyerPractiseAreas-2(area_id*,lawyer_id*)
PractiseAreas-2 (area_id, area_name, description)

In the Lawyer_Availability-2
The table contains the days during which lawyers make themselves available. The table operates with a composite key structure because lawyers participate in multiple availability days while each day may belong to multiple lawyers. It consists of:
	Composite key: lawyer_id, day_of_week
	Fully functional dependency (FFD): lawyer_id, day_of_week → is_available

Therefore,
Lawyer_Availability_2 (day_of_week, is_available, lawyer_id*)


In the Appointment-2
The table contains the days during which lawyers make themselves available. The table operates with a composite key structure because lawyers participate in multiple availability days while each day may belong to multiple lawyers.
	Partial functional dependency(PFD): 
client_id → username, password, email, full_name, phone, address, registration_date, last_login, is_active, profile_image, date_of_birth, gender
	Full functional dependency(FFD): 
appointment_id → appointment_date, appointment_time, duration, status, notes, created_at, updated_at, client_id, lawyer_id*
Every appointment needs to be associated with a lawyer thus the table contains a lawyer_id field to identify the responsible lawyer for each appointment so the lawyer_id is foreign key in this table.

Therefore:
Appointments-2 (appointment_id, appointment_date, appointment_time, duration, status, notes, created_at, updated_at, client_id, username, password, email, full_name, phone, address, registration_date, last_login, is_active, profile_image, date_of_birth, gender, lawyer_id*)

In Reviews_2,
The Reviews-2 table serves as a repository for client evaluations following their lawyer appointment meetings. A single appointment links each review entry through the appointment_id foreign key. The table contains no reviews not attached to an appointment. It ensures referential integrity.
	Full functional dependency(FFD):
 	 review_id → rating, comment, review_date, appointment_id*
During a one-to-one relationship an appointment includes zero or one review entry. A review needs to be connected to a single appointment based on the appointment_id* constraint which maintains one-to-one relations.
Therefore:
(review_id, rating, comment, review_date, appointment_id*)

Final 2NF:
Admins_2 (admin_id, username, password, email, full_name, phone, last_login, is_active, profile_image)
Lawyers_2 (lawyer_id, username, password, email, full_name, phone, address, registration_date, last_login, is_active, profile_Image, specialization, practice_areas, experience_years, education, license_number, about_me, consultation_fee, is_verified, is_available, rating, admin_id*)
LawyerPractiseAreas_2 (area_id*, lawyer_id*)
PractiseAreas_2 (area_id, area_name, description)

Lawyer_Availability_2 (day_of_week, is_available, lawyer_id*)
Appointments_2 (appointment_id, appointment_date, appointment_time, duration, status, notes, created_at, updated_at, client_id, username, password, email, full_name, phone, address, registration_date, last_login, is_active, profile_image, date_of_birth, gender, lawyer_id*)
Reviews_2 (review_id, rating, comment, review_date, appointment_id*)


2.4	Third normal form 3NF:
3NF prevents referenced data from including any columns that are not reliant on the primary key because the solution requires foreign keys as references instead of using data from either table. The relationship link between the three tables serves as the best model to demonstrate transitive functional dependency. A functional dependency between tables A and B will make C transitively dependent on the combination of A and B when B depends functionally on C. The removal of transitive functional dependencies of non-prime attributes with respect to every super key serve as another way to describe the transformation. Any RDBMS utilizes super keys as combined column systems that function to identify rows uniquely. Each row requires the minimum number of columns for identification which makes up a super key. (Thakur, 2016) The rules followed by 3NF are:
1.	ACID Properties: follows Atomicity, Consistency, Isolation, Durability 

2.	Data integrity rules: This rule maintains the accuracy and consistency of the data in the database which contains entity integrity, referential integrity, domain integrity and user-defined integrity.

Notation followed by 3NF:

1.	Hyphen symbol “-3”: The table naming convention includes a “-3” suffix which shows that the database follows Third Normal Form (3NF) standards.
2.	Primary Key Notation: All primary keys receive both underline as well as a PK mark. The table contains a built-in mechanism which grants one-of-a-kind identification to all its rows.
3.	Foreign Key Notation: After an attribute becomes a Foreign Key it receives an asterisk (*) as an additional symbol after its name.
4.	Functional Dependencies Notation We use: The partial dependency found in PFD is one of the conditions that lead to removing tables in 2NF.
For Admins-2,
None of the transitive dependency exists all the attributes are depended on the primary key which is admin_id so the Admin-3 is already in 3NF so no changes are needed:
Admins-3 (admin_id, username, password, email, full_name, phone, last_login, is_active, profile_image)

For Lawyers-3,
All the non-key attributes in the table rely wholly on the lawyer_id field without transitive dependency relationships between attributes. The admin_id* column contains a foreign key that points to the Admins-3 table to indicate administrative control. It is already on 3NF so no changes are needed.
Lawyers-3  (lawyer_id, username, password, email, full_name, phone, address, registration_date, last_login, is_active, profile_Image, specialization, practice_areas, experience_years, education, license_number, about_me, consultation_fee, is_verified, is_available, rating, admin_id*)


For LawyerPractiseAreas-3,
This is a junction table for the many-to-many relationship between lawyers and practice areas. In this table there is no transitive dependency so on the 3NF is already applied here so no changes are needed 
LawyerPractiseAreas-3 (area_id*, lawyer_id*)

For PractiseAreas-3,
This table is already in 3NF state as there is no transitive dependency, and all the attributes are depended upon area_id.
(area_id, area_name, description)

For Lawyer_Availability-3,
A specified lawyer's availability appears in every row according to the selected day. There exists no dependency among non-key attributes where one attribute depends upon another attribute. The table currently exists in 3NF. Already in 3NF.
(day_of_week, is_available, lawyer_id*)

For Appointments-3,
The appointment_date and appointment_time together with notes fields depend on the appointment while lawyer_id* and client_id* maintain the relationships in the system but do not form transitive dependencies. Already in 3NF.
(appointment_id, appointment_date, appointment_time, duration, status, notes, created_at, updated_at, lawyer_id*, client_id*)

For Client-3,
All columns such as username, email and phone derive their information from client_id without any indirect dependencies. Already in 3NF no changes are needed.
(client_id, username, password, email, full_name, phone, address, registration_date, last_login, is_active, profile_image, date_of_birth, gender)

For Reviews-3,
The review_id determines the dependencies for rating, comment and review_date. Appointment_id* creates a relation to the appointment table but the review attributes do not rely on appointment attributes. Already in 3NF no need of any changes
(review_id, rating, comment, review_date, appointment_id*)


Final 3NF:
Admins-3 (admin_id, username, password, email, full_name, phone, last_login, is_active, profile_image)
Lawyers-3 (lawyer_id, username, password, email, full_name, phone, address, registration_date, last_login, is_active, profile_Image, specialization, practice_areas, experience_years, education, license_number, about_me, consultation_fee, is_verified, is_available, rating, admin_id*)
LawyerPracticeAreas-3 (area_id*, lawyer_id*)
PractiseAreas-3 (area_id, area_name, description)
LawyerAvailability-3 (day_of_week, is_available, lawyer_id*)
Appointments-3 (appointment_id, appointment_date, appointment_time, duration, status, notes, created_at, updated_at, lawyer_id*, client_id*)
Client-3 (client_id, username, password, email, full_name, phone, address, registration_date, last_login, is_active, profile_image, date_of_birth, gender)
Reviews-3 (review_id, rating, comment, review_date, appointment_id*)


 
3	Final ERD
 
Figure 2 FinalERD
