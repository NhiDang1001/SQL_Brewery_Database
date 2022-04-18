

#1. Get a list of the top three most popular styles of beers. Popularity is based on the number of unique beers of each style. 
#Your result table needs to present the three styles with the number of unique beers of each style.
SELECT style, count(*)
FROM beer
GROUP BY style
ORDER BY count(*) desc
limit 3;


#2.Get a list of brewery ID and names that produce more than 30 different beers. 
#Your result table needs to show brewery ID, brewery names along with the number of different beers it produces. 
#Name the column showing “the number of different beers it produces” as “BeerCount” (without quotation mark).
SELECT brewery.brewery_id,breweryname, Beercount
FROM brewery, (SELECT brewery_id, count(*) as Beercount
FROM beer
GROUP BY brewery_id
HAVING count(*) > 30) as sub1
WHERE brewery.brewery_id = sub1.brewery_id;

SELECT brewery_id, count(*) as Beercount
FROM beer
GROUP BY brewery_id
HAVING count(*) > 30;

#Other way - Join
SELECT brewery.brewery_id,breweryname, Beercount
FROM brewery
INNER JOIN (SELECT brewery_id, count(*) as Beercount
FROM beer
GROUP BY brewery_id
HAVING count(*) > 30) as sub1
ON brewery.brewery_id = sub1.brewery_id;

#3. Which city in Washington state has the greatest number of breweries? 
#Show only one city and how many breweries are in the city in your result table.
SELECT city, state, count(*)
FROM brewery
WHERE state = "WA"
GROUP BY city
ORDER BY count(*) desc
limit 1;

#4. What is the maximum, minimum, and average abv of beers that contain the word “wine” in their style information?
SELECT max(abv), min(abv), avg(abv)
FROM beer
WHERE style REGEXP 'wine';

#5. Get a list of the three least popular IPA beer styles. 
#The popularity of a style is based on the number of beers of each style. 
#Your result table needs to show style and the number of beers of each IPA beer style. 
#(Hint: Use wildcard "IPA" in Style column to find IPA beers.)
SELECT style, count(*)
FROM beer
WHERE style REGEXP 'IPA'
GROUP BY style 
ORDER BY count(*) asc
limit 3;


#6.Which brewery produces the greatest number of fruity beers? 
#Get the ID, name of the brewery, and the number of fruity beers it produces.
# (Hint: Use wildcard "fruit" to find Style containing the word "fruit" to identify fruity beers.) 
SELECT brewery.brewery_id, breweryname,Fruity_count
FROM brewery, (SELECT brewery_id, count(*) as Fruity_count
FROM beer
WHERE style REGEXP 'fruit' 
GROUP BY brewery_id
ORDER BY count(*) desc
limit 1) as sub1
WHERE brewery.brewery_id = sub1.brewery_id;


SELECT brewery_id, count(*) as Fruity_count
FROM beer
WHERE style REGEXP 'fruit' 
GROUP BY brewery_id
ORDER BY count(*) desc
limit 1;

#Other
SELECT sub1.brewery_id, breweryname, count(*)
FROM beer as sub1
INNER JOIN brewery as sub2
ON sub1.brewery_id = sub2.brewery_id
WHERE style REGEXP 'fruit'
GROUP BY sub1.brewery_id, breweryname
ORDER BY count(*) desc
limit 1;

#7.What is the average ibu of IPA beers that are produced by breweries located in the city named “Portland” (in any state)?
# To find IPA beers, use wildcard of IPA for beer “Style” information.

SELECT avg(ibu)
FROM beer
WHERE style REGEXP 'IPA';

SELECT avg(ibu)
FROM beer as sub1
INNER JOIN brewery as sub2
ON sub1.brewery_id = sub2.brewery_id
WHERE style REGEXP 'IPA' and city = "Portland";

#8.Get the top 3 most popular beer styles that are produced in the city of “Seattle.” 
#The popularity of styles is based on the number of beers that belong to each style. 
#Your result table needs to show the style name and number of beers that belong to each style. 
SELECT style, count(*)
FROM beer as sub1
INNER JOIN brewery as sub2
ON sub1.brewery_id = sub2.brewery_id
WHERE city = "Seattle"
GROUP BY style
ORDER BY count(*) desc
limit 3;


#9. Which state produces the greatest number of beers that contain the word “high” in its name?
# Get the name of the state and the number of beers that contain “high” in their names. 
SELECT brewery_id, count(*) as high_beercount
FROM beer
WHERE beername REGEXP 'high'
GROUP BY brewery_id;

SELECT state, high_beercount
FROM brewery, (SELECT brewery_id, count(*) as high_beercount
FROM beer
WHERE beername REGEXP 'high'
GROUP BY brewery_id
ORDER BY count(*) desc
limit 1) as sub1
WHERE brewery.brewery_id = sub1.brewery_id;

#shorter
SELECT state, count(*)
FROM beer as sub1
INNER JOIN brewery as sub2
ON sub1.brewery_id = sub2.brewery_id
WHERE beername REGEXP 'high'
GROUP BY state
ORDER BY count(*) desc
limit 1;

#10. What are the brewery name and beer name of the Seattle beer with the highest abv?
# Seattle beers are beers produced in the city of “Seattle.” 
#Your result table needs to show only one brewery name, beer name, and abv.
SELECT breweryname, beername, city, abv
FROM beer as sub1
INNER JOIN brewery as sub2
ON sub1.brewery_id = sub2.brewery_id
WHERE city = "Seattle" 
ORDER BY abv desc
limit 1;
