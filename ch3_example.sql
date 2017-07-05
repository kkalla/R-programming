SELECT * FROM Book WHERE price < 20000;
SELECT * FROM Book WHERE price BETWEEN 10000 AND 20000;
SELECT * FROM book WHERE publisher IN ('굿스포츠', '대한미디어');
SELECT publisher FROM book WHERE bookname LIKE '축구의 역사';
SELECT publisher FROM book WHERE bookname LIKE '%축구%';
SELECT * FROM book WHERE bookname LIKE '_구%';
SELECT * FROM book WHERE bookname LIKE '%축구%' AND price >=20000;
SELECT * FROM book WHERE publisher='굿스포츠' OR publisher = '대한미디어';

/*12*/
SELECT * FROM book ORDER BY bookname;
/*13*/
SELECT * FROM Book ORDER BY price, bookname;
/*14*/
SELECT * FROM book ORDER BY price DESC, publisher ;
/*15~18*/
SELECT SUM(saleprice) AS "총 매출" FROM orders;
SELECT SUM(saleprice) AS "총매출" FROM orders WHERE custid=2;
SELECT SUM(saleprice) AS Total,
        AVG(saleprice) AS Average,
        MIN(saleprice) AS Minimum,
        MAX(saleprice) AS Maximum FROM orders;

SELECT COUNT(*)
FROM orders;

/*19~20*/
SELECT custid, COUNT(*) AS 도서수량, SUM(saleprice) AS "총액" FROM Orders
GROUP BY custid;
SELECT custid FROM orders WHERE saleprice >=8000
GROUP BY custid ;





















SELECT * FROM book WHERE price >=10000 AND price <=20000;
SELECT * FROM book WHERE publisher IN ('대한미디어','굿스포츠');
SELECT * FROM book WHERE bookname LIKE '%축구%' AND price >=20000;
SELECT name FROM customer WHERE custid IN (SELECT custid FROM orders WHERE saleprice <15000 OR saleprice >=20000);
SELECT publisher FROM book WHERE bookname LIKE '%축구%' OR bookname LIKE '%야구%' AND price >=20000;
SELECT name, address, phone FROM customer WHERE address LIKE '%대한민국%';
SELECT price FROM book WHERE bookname LIKE '%역도%' AND publisher = '굿스포츠';
SELECT * FROM book WHERE price <=10000 OR price >=20000;
SELECT * FROM book WHERE bookname LIKE '%야구%' AND price>=15000;
SELECT bookname FROM book WHERE publisher = '이상미디어' AND price >=20000;
SELECT * FROM book WHERE publisher LIKE '%미디어%';
SELECT * FROM book WHERE publisher ='대한미디어' AND price >=20000;
SELECT bookname FROM book WHERE publisher LIKE '_상%' AND price BETWEEN 10000 AND 15000;
SELECT * FROM book WHERE bookname LIKE '%구%' AND price >=8000;

SELECT SUM(saleprice) AS "총 도서 판매액" FROM orders WHERE saleprice >=10000
;
SELECT custid, SUM(saleprice) AS "총 판매액" FROM orders WHERE saleprice >= 10000 GROUP BY custid HAVING custid >= 2;

SELECT SUM(saleprice) AS "합계금액", custid FROM orders WHERE orderdate >= '14/07/04'
GROUP BY custid HAVING SUM(saleprice) >=15000 ORDER BY "합계금액" DESC;

SELECT publisher, COUNT(*) AS "총 수량", SUM(price) AS "총 판매액" FROM book GROUP BY PUBLISHER;

SELECT bookid, COUNT(*) FROM orders GROUP BY bookid;

/*연습문제 1. (1) (2)*/
SELECT bookname FROM book WHERE bookid = 1;
SELECT bookname FROM book WHERE price>= 20000;

/*연습문제 2. (1) ~ (7) */
SELECT COUNT(*) AS "도서의 총 개수" FROM book;
SELECT COUNT(DISTINCT publisher) AS "출판사의 총 개수" FROM book;
SELECT DISTINCT name,address FROM customer;
SELECT orderid FROM orders WHERE orderdate BETWEEN '14/07/04' AND '14/07/07';
SELECT orderid FROM orders WHERE orderdate NOT BETWEEN '14/07/04' AND '14/07/07';
SELECT name, address FROM customer WHERE name LIKE '김%';
SELECT name, address FROM customer WHERE name LIKE '김%아';