/* 49: Assessment Test 2. */ 

--1) How can you retrieve all the information from the cd.facilities table?
-- Seperate schema, so will need to prefix with schema name. 
SELECT * FROM cd.facilities;

------------------------------------------------------------------------------------------------------------------------
--2) Print out a list of all of the facilities and their cost to members. How would you retrieve a list of only facility names and costs?
SELECT name, membercost 
  FROM cd.facilities;

------------------------------------------------------------------------------------------------------------------------
--3) How can you produce a list of facilities that charge a fee to members?
SELECT name, membercost  
  FROM cd.facilities
 WHERE membercost > 0;

------------------------------------------------------------------------------------------------------------------------
--4) How can you produce a list of facilities that charge a fee to members, and that fee is less than 1/50th of the monthly maintenance cost? Return the facid, facility name, member cost, and monthly maintenance of the facilities in question.
SELECT facid, name, membercost, monthlymaintenance 
  FROM cd.facilities
 WHERE membercost > 0 
   AND (membercost > (monthlymaintenance / 50.0));

------------------------------------------------------------------------------------------------------------------------
--5) How can you produce a list of all facilities with the word 'Tennis' in their name?
SELECT facid, name
  FROM cd.facilities
 WHERE UPPER(name) like '%TENNIS%'

------------------------------------------------------------------------------------------------------------------------
--6) How can you retrieve the details of facilities with ID 1 and 5? Try to do it without using the OR operator.
SELECT facid, name
  FROM cd.facilities
 WHERE facid IN (1, 5);

------------------------------------------------------------------------------------------------------------------------
--7) How can you produce a list of members who joined after the start of September 2012? Return the memid, surname, firstname, and joindate of the members in question.
SELECT memid, surname, firstname, joindate
  FROM cd.members
 where joindate >= '2012-09-01'

------------------------------------------------------------------------------------------------------------------------
--8) How can you produce an ordered list of the first 10 surnames in the members table? The list must not contain duplicates.
SELECT surname
  FROM cd.members
 GROUP BY surname
 ORDER BY surname
 LIMIT 10;

 SELECT DISTINCT surname 
   FROM cd.members 
  ORDER BY surname
  LIMIT 10
------------------------------------------------------------------------------------------------------------------------
--9) You'd like to get the signup date of your last member. How can you retrieve this information?
SELECT surname, firstname
  FROM cd.members
  where joindate = ( SELECT max(joindate) FROM cd.members);

------------------------------------------------------------------------------------------------------------------------
--10) Produce a count of the number of facilities that have a cost to guests of 10 or more.
SELECT COUNT(*)
  FROM cd.facilities
 WHERE membercost >= 10;

------------------------------------------------------------------------------------------------------------------------
--11) Skip this one, no question for #11.

------------------------------------------------------------------------------------------------------------------------
--12) Produce a list of the total number of slots booked per facility in the month of September 2012. Produce an output table consisting of facility id and slots, sorted by the number of slots.
SELECT facid, sum(slots) AS "Slots" 
  FROM cd.bookings 
 WHERE starttime BETWEEN '2012-09-01' AND '2012-10-01' 
 GROUP BY facid 
 ORDER BY sum(slots);

------------------------------------------------------------------------------------------------------------------------
--13) Produce a list of facilities with more than 1000 slots booked. Produce an output table consisting of facility id and total slots, sorted by facility id.
-- (Added further info in to test join knowledge)  
SELECT cd.bookings.facid, cd.facilities.name, sum(slots) as "Slots"
  FROM cd.bookings
  JOIN cd.facilities on cd.bookings.facid = cd.facilities.facid
 GROUP BY cd.bookings.facid, cd.facilities.name
 HAVING sum(slots)> 1000
 ORDER BY cd.bookings.facid ASC;
  

------------------------------------------------------------------------------------------------------------------------
--14) How can you produce a list of the start times for bookings for tennis courts, for the date '2012-09-21'? Return a list of start time and facility name pairings, ordered by the time.
SELECT cd.bookings.starttime, cd.bookings.facid, cd.facilities.name
  FROM cd.bookings
  JOIN cd.facilities on cd.bookings.facid = cd.facilities.facid
 WHERE UPPER(cd.facilities.name) like '%TENNIS COURT%'
   AND starttime BETWEEN '2012-09-21' AND '2012-09-22'
 ORDER BY cd.bookings.starttime ASC;
 

------------------------------------------------------------------------------------------------------------------------
--15) How can you produce a list of the start times for bookings by members named 'David Farrell'?
SELECT cd.members.firstname || ' ' || cd.members.surname, 
		cd.facilities.name,
		cd.bookings.starttime 
  FROM cd.bookings
  JOIN cd.members on cd.bookings.memid = cd.members.memid
  JOIN cd.facilities on cd.bookings.facid = cd.facilities.facid
 WHERE bookings.memid = (SELECT memid FROM cd.members WHERE surname = 'Farrell' and firstname = 'David');