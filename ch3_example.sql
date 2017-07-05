SELECT * FROM Book WHERE price < 20000;
SELECT * FROM Book WHERE price BETWEEN 10000 AND 20000;
SELECT * FROM book WHERE publisher IN ('�½�����', '���ѹ̵��');
SELECT publisher FROM book WHERE bookname LIKE '�౸�� ����';
SELECT publisher FROM book WHERE bookname LIKE '%�౸%';
SELECT * FROM book WHERE bookname LIKE '_��%';
SELECT * FROM book WHERE bookname LIKE '%�౸%' AND price >=20000;
SELECT * FROM book WHERE publisher='�½�����' OR publisher = '���ѹ̵��';

/*12*/
SELECT * FROM book ORDER BY bookname;
/*13*/
SELECT * FROM Book ORDER BY price, bookname;
/*14*/
SELECT * FROM book ORDER BY price DESC, publisher ;
/*15~18*/
SELECT SUM(saleprice) AS "�� ����" FROM orders;
SELECT SUM(saleprice) AS "�Ѹ���" FROM orders WHERE custid=2;
SELECT SUM(saleprice) AS Total,
        AVG(saleprice) AS Average,
        MIN(saleprice) AS Minimum,
        MAX(saleprice) AS Maximum FROM orders;

SELECT COUNT(*)
FROM orders;

/*19~20*/
SELECT custid, COUNT(*) AS ��������, SUM(saleprice) AS "�Ѿ�" FROM Orders
GROUP BY custid;
SELECT custid FROM orders WHERE saleprice >=8000
GROUP BY custid ;





















SELECT * FROM book WHERE price >=10000 AND price <=20000;
SELECT * FROM book WHERE publisher IN ('���ѹ̵��','�½�����');
SELECT * FROM book WHERE bookname LIKE '%�౸%' AND price >=20000;
SELECT name FROM customer WHERE custid IN (SELECT custid FROM orders WHERE saleprice <15000 OR saleprice >=20000);
SELECT publisher FROM book WHERE bookname LIKE '%�౸%' OR bookname LIKE '%�߱�%' AND price >=20000;
SELECT name, address, phone FROM customer WHERE address LIKE '%���ѹα�%';
SELECT price FROM book WHERE bookname LIKE '%����%' AND publisher = '�½�����';
SELECT * FROM book WHERE price <=10000 OR price >=20000;
SELECT * FROM book WHERE bookname LIKE '%�߱�%' AND price>=15000;
SELECT bookname FROM book WHERE publisher = '�̻�̵��' AND price >=20000;
SELECT * FROM book WHERE publisher LIKE '%�̵��%';
SELECT * FROM book WHERE publisher ='���ѹ̵��' AND price >=20000;
SELECT bookname FROM book WHERE publisher LIKE '_��%' AND price BETWEEN 10000 AND 15000;
SELECT * FROM book WHERE bookname LIKE '%��%' AND price >=8000;

SELECT SUM(saleprice) AS "�� ���� �Ǹž�" FROM orders WHERE saleprice >=10000
;
SELECT custid, SUM(saleprice) AS "�� �Ǹž�" FROM orders WHERE saleprice >= 10000 GROUP BY custid HAVING custid >= 2;

SELECT SUM(saleprice) AS "�հ�ݾ�", custid FROM orders WHERE orderdate >= '14/07/04'
GROUP BY custid HAVING SUM(saleprice) >=15000 ORDER BY "�հ�ݾ�" DESC;

SELECT publisher, COUNT(*) AS "�� ����", SUM(price) AS "�� �Ǹž�" FROM book GROUP BY PUBLISHER;

SELECT bookid, COUNT(*) FROM orders GROUP BY bookid;

/*�������� 1. (1) (2)*/
SELECT bookname FROM book WHERE bookid = 1;
SELECT bookname FROM book WHERE price>= 20000;

/*�������� 2. (1) ~ (7) */
SELECT COUNT(*) AS "������ �� ����" FROM book;
SELECT COUNT(DISTINCT publisher) AS "���ǻ��� �� ����" FROM book;
SELECT DISTINCT name,address FROM customer;
SELECT orderid FROM orders WHERE orderdate BETWEEN '14/07/04' AND '14/07/07';
SELECT orderid FROM orders WHERE orderdate NOT BETWEEN '14/07/04' AND '14/07/07';
SELECT name, address FROM customer WHERE name LIKE '��%';
SELECT name, address FROM customer WHERE name LIKE '��%��';