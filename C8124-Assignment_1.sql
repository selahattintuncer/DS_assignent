CREATE TABLE transactions(
Sender VARCHAR(5),
Receiver VARCHAR(5),
Amount INT,
Transaction_date DATE
);
INSERT INTO  dbo.transactions(Sender, Receiver, Amount,Transaction_date) VALUES (5,2,10, '2-12-20')
INSERT INTO  dbo.transactions(Sender, Receiver, Amount,Transaction_date) VALUES (1,3,15, '2-13-20')
INSERT INTO  dbo.transactions(Sender, Receiver, Amount,Transaction_date) VALUES (2,1,20, '2-13-20')
INSERT INTO  dbo.transactions(Sender, Receiver, Amount,Transaction_date) VALUES (2,3,25, '2-14-20')
INSERT INTO  dbo.transactions(Sender, Receiver, Amount,Transaction_date) VALUES (3,1,20, '2-15-20')
INSERT INTO  dbo.transactions(Sender, Receiver, Amount,Transaction_date) VALUES (3,2,15, '2-15-20')
INSERT INTO  dbo.transactions(Sender, Receiver, Amount,Transaction_date) VALUES (1,4,5, '2-16-20')

SELECT *
FROM dbo.transactions


SELECT Sender, SUM(Amount) debited
INTO Debits
FROM dbo.transactions
GROUP BY Sender

SELECT *
FROM dbo.Debits


SELECT Receiver, SUM(Amount) credited
INTO Credits
FROM dbo.transactions
GROUP BY Receiver

SELECT *
FROM dbo.Credits

SELECT coalesce(Sender, Receiver) "User", 
coalesce(credited, 0) - coalesce(debited, 0) net_change 
FROM Debits D
FULL JOIN Credits C
ON C.Receiver = D.Sender
ORDER BY 2 DESC
