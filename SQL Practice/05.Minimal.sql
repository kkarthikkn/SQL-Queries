# MINIMAL KEY (Theory Concept)

Minimal means that the set of columns (attributes) chosen to uniquely identify a row contains no unnecessary parts—if you remove any column from that set, 
it would no longer uniquely identify the row.

Example: Imagine a table with columns f_name, l_name, and course where:

	The combination (f_name, l_name, course) uniquely identifies each row.
	However, if it turns out that (f_name, l_name) alone is enough to uniquely identify each row, then (f_name, l_name, course) is not minimal because course is extra.
	Thus, the minimal key here is (f_name, l_name) since you cannot remove f_name or l_name without losing the ability to uniquely identify the row. This minimal set is what we call a candidate key.


Minimal: A set of columns that is just sufficient to uniquely identify a row—removing any column would break this uniqueness.
