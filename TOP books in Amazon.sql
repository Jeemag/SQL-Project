 SELECT * FROM [customer reviewscsv]
 SELECT * FROM [Top_100 Trending Bookscsv]

 SELECT book_title,author,year_of_publication 
 FROM [Top_100 Trending Bookscsv]
 WHERE Rank<20 AND rating>=4.8

 SELECT DISTINCT book_name,Rank,reviewer_rating,author,genre
 FROM [customer reviewscsv]
 LEFT OUTER JOIN [Top_100 Trending Bookscsv]
 ON book_name=book_title
 WHERE reviewer_rating=5 AND rating>=4.8 AND RANK <=10

 SELECT book_name,AVG(reviewer_rating) as AVG_REVIEWER_RATING 
 FROM [customer reviewscsv]
 GROUP BY book_name 
 ORDER BY AVG_REVIEWER_RATING DESC

SELECT book_title,author,rank,genre,year_of_publication FROM [Top_100 Trending Bookscsv]
ORDER BY genre ASC ,Rank ASC

SELECT book_title,author,year_of_publication,
 CASE
 WHEN rating>=4.9 AND rating <=5 THEN 'MUST READ'
 WHEN rating>=4.6 AND rating <4.9 THEN 'GOOD TO READ'
 ELSE 'OK TO READ'
 END as BOOK_SUMMARY
 FROM [Top_100 Trending Bookscsv]
 ORDER BY BOOK_SUMMARY ASC


