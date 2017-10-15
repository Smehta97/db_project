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

SELECT *
FROM client c, booking b
WHERE c.client_ID = b.booking_ID
