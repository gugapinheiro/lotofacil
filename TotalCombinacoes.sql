CREATE TEMPORARY TABLE A (number int);
CREATE TEMPORARY TABLE B (number int);
CREATE TEMPORARY TABLE C (number int);
CREATE TEMPORARY TABLE D (number int);
CREATE TEMPORARY TABLE E (number int);

CREATE TEMPORARY TABLE schemes (number1 int, number2 int, number3 int, number4 int, number5 int);

CREATE TEMPORARY TABLE template1 (scheme varchar(9), number int);
CREATE TEMPORARY TABLE template2 (scheme varchar(9), number int);
CREATE TEMPORARY TABLE template3 (scheme varchar(9), number int);
CREATE TEMPORARY TABLE template4 (scheme varchar(9), number int);
CREATE TEMPORARY TABLE template5 (scheme varchar(9), number int);

CREATE TEMPORARY TABLE Table1 (value varchar(1));
CREATE TEMPORARY TABLE Table2 (value varchar(1));
CREATE TEMPORARY TABLE Table3 (value varchar(1));
CREATE TEMPORARY TABLE Table4 (value varchar(1));
CREATE TEMPORARY TABLE Table5 (value varchar(1));
CREATE TEMPORARY TABLE Table6 (value varchar(1));
CREATE TEMPORARY TABLE Table7 (value varchar(1));
CREATE TEMPORARY TABLE Table8 (value varchar(1));
CREATE TEMPORARY TABLE Table9 (value varchar(1));
CREATE TEMPORARY TABLE Table10 (value varchar(1));
CREATE TEMPORARY TABLE Table11 (value varchar(1));
CREATE TEMPORARY TABLE Table12 (value varchar(1));
CREATE TEMPORARY TABLE Table13 (value varchar(1));
CREATE TEMPORARY TABLE Table14 (value varchar(1));
CREATE TEMPORARY TABLE Table15 (value varchar(1));

INSERT INTO Table1 (value) VALUES ('A'), ('B'), ('C'), ('D'), ('E');
INSERT INTO Table2 SELECT * FROM Table1;
INSERT INTO Table3 SELECT * FROM Table1;
INSERT INTO Table4 SELECT * FROM Table1;
INSERT INTO Table5 SELECT * FROM Table1;
INSERT INTO Table6 SELECT * FROM Table1;
INSERT INTO Table7 SELECT * FROM Table1;
INSERT INTO Table8 SELECT * FROM Table1;
INSERT INTO Table9 SELECT * FROM Table1;
INSERT INTO Table10 SELECT * FROM Table1;
INSERT INTO Table11 SELECT * FROM Table1;
INSERT INTO Table12 SELECT * FROM Table1;
INSERT INTO Table13 SELECT * FROM Table1;
INSERT INTO Table14 SELECT * FROM Table1;
INSERT INTO Table15 SELECT * FROM Table1;

INSERT INTO template1
  SELECT '' AS value, 0 AS scheme
  
  UNION ALL
  
  SELECT value, 1
  FROM Table1

  UNION ALL

  SELECT CONCAT(Table2.value, '-', Table3.value), 2
  FROM Table2
  CROSS JOIN Table3
  WHERE Table2.value < Table3.value

  UNION ALL

  SELECT CONCAT(Table4.value, '-', Table5.value, '-', Table6.value), 3
  FROM Table4
  CROSS JOIN Table5
  CROSS JOIN Table6
  WHERE Table4.value < Table5.value
  AND Table5.value < Table6.value

  UNION ALL

  SELECT CONCAT(Table7.value, '-', Table8.value, '-', Table9.value, '-', Table10.value), 4
  FROM Table7
  CROSS JOIN Table8
  CROSS JOIN Table9
  CROSS JOIN Table10
  WHERE Table7.value < Table8.value
  AND Table8.value < Table9.value
  AND Table9.value < Table10.value

  UNION ALL

  SELECT CONCAT(Table11.value, '-', Table12.value, '-', Table13.value, '-', Table14.value, '-', Table15.value), 5
  FROM Table11
  CROSS JOIN Table12
  CROSS JOIN Table13
  CROSS JOIN Table14
  CROSS JOIN Table15
  WHERE Table11.value < Table12.value
  AND Table12.value < Table13.value
  AND Table13.value < Table14.value
  AND Table14.value < Table15.value;

INSERT INTO template2 SELECT * FROM template1;
INSERT INTO template3 SELECT * FROM template1;
INSERT INTO template4 SELECT * FROM template1;
INSERT INTO template5 SELECT * FROM template1;

INSERT INTO A (number) VALUES (5), (4), (3), (2), (1), (0);
INSERT INTO B SELECT * FROM A;
INSERT INTO C SELECT * FROM A;
INSERT INTO D SELECT * FROM A;
INSERT INTO E SELECT * FROM A;

INSERT INTO schemes
  SELECT DISTINCT *
  FROM A, B, C, D, E
  WHERE (A.number + B.number + C.number + D.number + E.number) = 15
  ORDER BY A.number, B.number, C.number, D.number, E.number;

SELECT COUNT(scheme1) AS total FROM (
  SELECT scheme1, scheme2, scheme3, template4.scheme AS scheme4, number5 FROM (
    SELECT scheme1, scheme2, template3.scheme AS scheme3, number4, number5 FROM (
      SELECT scheme1, template2.scheme AS scheme2, number3, number4, number5 FROM (
        SELECT template1.scheme AS scheme1, number2, number3, number4, number5
        FROM schemes
        INNER JOIN template1 ON template1.number = schemes.number1
      ) AS Temp2
      INNER JOIN template2 ON template2.number = Temp2.number2
    ) AS Temp3
    INNER JOIN template3 ON template3.number = Temp3.number3
  ) AS Temp4
  INNER JOIN template4 ON template4.number = Temp4.number4
) AS Temp5
INNER JOIN template5 ON template5.number = Temp5.number5
