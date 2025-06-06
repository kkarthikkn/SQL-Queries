# Theory Concepts

*Primary Key (student_id):

Definition: The chosen candidate key that uniquely identifies each row and does not allow NULLs.
Here, student_id is minimal and uniquely identifies each row.

-- ===============================================

*Candidate Key (email or phone):

Definition: A minimal set of column(s) that uniquely identifies a row.
In this table, both email and phone are candidate keys because each one, on its own, is unique and minimal.

-- ===============================================

*Super Key (student_id, phone):

Definition: Any set of one or more columns that uniquely identifies a row.
Although student_id alone is enough, the combination (student_id, phone) is also a super key because it still uniquely identifies a row.
Note: This combination is not minimal (because phone is extra), so it is not a candidate key.

-- ===============================================

*Composite Key:

Definition: A key that consists of two or more columns.
The combination (student_id, phone) is a composite key because it involves more than one column. However, in this case, it’s only an example of a composite super key, not a 
composite candidate key, since student_id alone is sufficient.

