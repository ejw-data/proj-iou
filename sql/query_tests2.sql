-- Starter queries if the data only includes a single db record per transaction

SELECT u2.fullname AS Payee, u.fullname AS Ower, SUM(amount) AS Owed
FROM records r
INNER JOIN users u
	ON r.owee_id = u.user_id
INNER JOIN users u2
	ON r.payee_id = u2.user_id
WHERE r.payee_id = 2
GROUP BY u2.fullname, u.fullname;

SELECT u2.fullname AS Payee, u.fullname AS Ower, SUM(amount) AS Owed
FROM records r
INNER JOIN users u
	ON r.owee_id = u.user_id
INNER JOIN users u2
	ON r.payee_id = u2.user_id
WHERE r.payee_id = 1
GROUP BY u2.fullname, u.fullname;

SELECT r1.payee_id, r1.owee_id, 
	CASE WHEN (r1.amount IS NOT NULL) AND (r2.amount IS NOT NULL) THEN (r1.amount-r2.amount) 
		 WHEN (r1.amount IS NOT NULL) THEN r1.amount
		 ELSE (r2.amount * -1) 
	END AS Owe
FROM records r1
LEFT JOIN records r2
  ON r1.payee_id = r2.owee_id
  	AND r1.owee_id  = r2.payee_id
WHERE r1.primaryInd = True;



DROP TABLE IF EXISTS transactions; 

SELECT r1.payee_id, r1.owee_id, r1.amount AS pAmount, r2.amount AS oAmount
INTO TEMP transactions
FROM records r1
LEFT JOIN records r2
  ON r1.payee_id = r2.owee_id
  	AND r1.owee_id  = r2.payee_id;
	
SELECT * FROM transactions;