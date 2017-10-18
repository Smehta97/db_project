/*select all accomodations with rating > 3 and location is London*/
SELECT *
FROM accomodation A
WHERE A.stars > 3 AND (SELECT *
                       FROM accomodation A, location L
                       WHERE A.ac_ID = L.ac_ID AND L.city LIKE 'London');

/*select all accomodations in London with a rating greater than the average
rating in London*/
SELECT *
FROM accomodation A
WHERE A.stars > (SELECT AVG(A.stars)
                 FROM accomodation A, location L
                 WHERE A.ac_ID = L.ac_ID and L.city LIKE 'London')

/*select all hostels*/
SELECT accomodation.ac_ID, accomodation.name, accomodation.stars, accomodation.description, hostel.kitchen, hostel.common_room
FROM accomodation
JOIN hostel
ON accomodation.ac_ID = hostel.ac_ID;

/*select all motels*/
SELECT accomodation.ac_ID, accomodation.name, accomodation.stars, accomodation.description, motel.parking
FROM accomodation
JOIN motel
ON accomodation.ac_ID = hostel.ac_ID;

/*select all hotels*/
SELECT accomodation.ac_ID, accomodation.name, accomodation.stars, accomodation.description, hotel.room_service ,hotel.parking
FROM accomodation
JOIN hotel
ON accomodation.ac_ID = hostel.ac_ID;

/*select all resorts*/
SELECT accomodation.ac_ID, accomodation.name, accomodation.stars, accomodation.description, resort.theme, resort.num_parking
FROM accomodation
JOIN resort
ON accomodation.ac_ID = hostel.ac_ID;

/*select all bookings for a client*/
SELECT a.name,b.num_people,b.arrival_date,b.departure_date
FROM client c, booking b, accomodation a, reserves r 
WHERE c.client_ID = r.client_ID and b.booking_ID = r.booking_ID and a.ac_ID =r.ac_ID 

/*select all accomodations which have a sauna*/
SELECT a.name, a.stars, a.description
FROM accomodation a,facilities f, spa s
WHERE f.ac_ID=a.ac_ID and f.f_ID=s.f_ID and s.sauna is true

/*select cancelation period for a certain hotel that client has a booking with*/
SELECT p.cancellation_period
FROM policy p, client c, reserves r
WHERE r.client_ID=c.client_ID and p.ac_ID=r.ac_ID

/*select all active bookings for a client returning the name of the accomodation, the number of people and the stay period */
SELECT a.name, b.arrival_date, b.departure_date, b.num_people
FROM accomodation a, booking b, reserves r, client c
WHERE c.client_ID=r.client_ID and b.booking_ID=r.booking_ID and a.ac_ID=r.ac_ID and b.status is true
