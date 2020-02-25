1)
SELECT name
FROM `Facilities`
WHERE membercost =0


2)
SELECT COUNT( membercost ) AS free_facilities
FROM `Facilities`
WHERE membercost =0

3)
SELECT facid, name, membercost, monthlymaintenance
FROM `Facilities`
WHERE membercost < 0.2 * monthlymaintenance

4)
SELECT *
FROM `Facilities`
WHERE facid

5)
SELECT monthlymaintenance,
CASE WHEN monthlymaintenance > 100 THEN 'expensive' ELSE 'cheap' END AS price_category
FROM `Facilities`

6)
SELECT MAX( memid ) AS last_member, firstname, surname
FROM `Members` 

7)
SELECT name AS court, 
       firstname 
       FROM country_club.Members members INNER JOIN country_club.Bookings bookings ON members.memid = bookings.memid INNER JOIN country_club.Facilities facilities ON facilities.facid = bookings.facid 
WHERE name LIKE 'Tennis%' 
AND firstname != 'GUEST'
GROUP BY firstname 
ORDER BY firstname 

8)
SELECT name, 
       firstname,
       CASE WHEN firstname = 'GUEST' THEN guestcost ELSE membercost END AS cost
FROM country_club.Members members
INNER JOIN country_club.Facilities facilities ON members.memid = facilities.facid INNER JOIN country_club.Bookings bookings ON bookings.facid = facilities.facid
WHERE starttime LIKE '2012-09-14%'
AND (3*slots) > 30
ORDER BY 3 DESC 

9)
SELECT name, 
       firstname,
       CASE WHEN firstname = 'GUEST' THEN guestcost ELSE membercost END AS cost
FROM country_club.Members members INNER JOIN country_club.Facilities facilities ON members.memid = facilities.facid INNER JOIN country_club.Bookings bookings ON bookings.facid = facilities.facid
WHERE starttime LIKE '2012-09-14%'
AND 3 IN (SELECT 3 
          FROM country_club.Members members INNER JOIN country_club.Facilities facilities ON members.memid = facilities.facid INNER JOIN country_club.Bookings bookings ON bookings.facid = facilities.facid
          WHERE (3*slots > 30))
ORDER BY 3 DESC 

10)
SELECT name, totalrevenue
FROM (
SELECT Facilities.name, SUM(
CASE WHEN memid =0
THEN slots * Facilities.guestcost
ELSE slots * membercost
END ) AS totalrevenue
FROM Bookings
INNER JOIN Facilities ON Bookings.facid = Facilities.facid
GROUP BY Facilities.name
) AS selected_facilities
WHERE totalrevenue <=1000
ORDER BY totalrevenue

