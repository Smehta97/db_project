/*1. select all accomodations with rating > 3 and location is London*/
SELECT *
FROM accomodation A
WHERE A.stars > 3 AND (SELECT *
                       FROM accomodation A, location L
                       WHERE A.ac_ID = L.ac_ID AND L.city LIKE 'London');

/*2. select all accomodations in London with a rating greater than the average
rating in London*/
SELECT *
FROM accomodation A
WHERE A.stars > (SELECT AVG(A.stars)
                 FROM accomodation A, location L
                 WHERE A.ac_ID = L.ac_ID and L.city LIKE 'London')

/*3. select all hostels*/
SELECT accomodation.ac_ID, accomodation.name, accomodation.stars, accomodation.description, hostel.kitchen, hostel.common_room
FROM accomodation
JOIN hostel
ON accomodation.ac_ID = hostel.ac_ID;

/*4. select all motels*/
SELECT accomodation.ac_ID, accomodation.name, accomodation.stars, accomodation.description, motel.parking
FROM accomodation
JOIN motel
ON accomodation.ac_ID = hostel.ac_ID;

/*5. select all hotels*/
SELECT accomodation.ac_ID, accomodation.name, accomodation.stars, accomodation.description, hotel.room_service ,hotel.parking
FROM accomodation
JOIN hotel
ON accomodation.ac_ID = hostel.ac_ID;

/*6. select all resorts*/
SELECT accomodation.ac_ID, accomodation.name, accomodation.stars, accomodation.description, resort.theme, resort.num_parking
FROM accomodation
JOIN resort
ON accomodation.ac_ID = hostel.ac_ID;

/*7. select all bookings for a client*/
SELECT a.name,b.num_people,b.arrival_date,b.departure_date
FROM client c, booking b, accomodation a, reserves r 
WHERE c.client_ID = r.client_ID AND b.booking_ID = r.booking_ID AND a.ac_ID =r.ac_ID 

/*8. select all accomodations which have a sauna*/
SELECT a.name, a.stars, a.description
FROM accomodation a,facilities f, spa s
WHERE f.ac_ID=a.ac_ID AND f.f_ID=s.f_ID AND s.sauna IS true

/*9. select all accomodations which have a gym with classes*/
SELECT a.name, a.stars, a.description
FROM accomodation a,facilities f, gym g
WHERE f.ac_ID=a.ac_ID AND f.f_ID=g.f_ID AND g.classes IS NOT NULL

/*10. select cancelation period for a certain hotel that client has a booking with*/
SELECT p.cancellation_period
FROM policy p, client c, reserves r
WHERE r.client_ID=c.client_ID AND p.ac_ID=r.ac_ID

/*11. select all active bookings for a client returning the name of the accomodation, the number of people and the stay period */
SELECT a.name, b.arrival_date, b.departure_date, b.num_people
FROM accomodation a, booking b, reserves r, client c
WHERE c.client_ID=r.client_ID AND b.booking_ID=r.booking_ID AND a.ac_ID=r.ac_ID AND b.status IS true

/*12. Select all accomodations with free wifi*/
SELECT *
FROM accomodations a, facilities f
WHERE a.ac_ID = f.ac_ID AND f.wifi IS true

/*13. Select all accomodations with indian restaurants*/
SELECT *
FROM accomodations a, facilities f
WHERE a.ac_ID = f.ac_ID AND cuisine LIKE 'Indian'

/*14. Select all from accomodations with suites*/
SELECT *
FROM accomodations a, rooms r,contains c
WHERE a.ac_ID=c.ac_ID and r.room_ID=c.room_ID and c.room_ID in (SELECT s.room_ID
																										FROM suites s)
																										
/*15. Select all accomodations with single rooms cheaper than 100*/
SELECT *
FROM accomodation a, rooms r, contains c
WHERE a.ac_ID=c.ac_ID and r.room_ID=c.room_ID and c.cost<100

/**/
