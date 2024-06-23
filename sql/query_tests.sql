-- Queries used with db with two records per transaction

Select *
FROM records
WHERE owee_id = 2 and primary_ind=True;

Select *
FROM users;

-- original table - no credited entries
SELECT *
FROM records r1
WHERE r1.primaryInd = True;


SELECT SUM(amount) AS Balance
FROM records r1
WHERE r1.payee_id = 2;


SELECT owee_id, u.fullname, sum(amount)
FROM records r1
INNER JOIN users u
	ON r1.owee_id = u.user_id
WHERE r1.payee_id = 2
GROUP BY owee_id, u.fullname;


