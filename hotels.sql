CREATE TABLE client(
  first_name CHAR(40),
  last_name CHAR(40),
  client_ID INT,
  phone_number INT,
  email VARCHAR(255),
  password VARCHAR(255),
  PRIMARY KEY(client_ID)
);

CREATE TABLE accomodation(
  name VARCHAR(255),
  ac_ID INT,
  stars INT,
  description text,
  PRIMARY KEY(ac_ID)
);

CREATE TABLE location(
  zip_code INT,
  ac_ID INT,
  street VARCHAR(255),
  city CHAR(40),
  state CHAR(40),
  country VARCHAR(255),
  PRIMARY KEY(ac_ID),
  FOREIGN KEY(ac_ID) REFERENCES accomodation(ac_ID)
);

CREATE TABLE hotel(
  ac_ID INT,
  room_service BOOLEAN,
  parking BOOLEAN,
  PRIMARY KEY(ac_ID),
  FOREIGN KEY(ac_ID) REFERENCES accomodation(ac_ID)
);

CREATE TABLE hostel(
  ac_ID INT,
  kitchen BOOLEAN,
  common_room BOOLEAN,
  PRIMARY KEY(ac_ID),
  FOREIGN KEY(ac_ID) REFERENCES accomodation(ac_ID)
);

CREATE TABLE motel(
  ac_ID INT,
  num_parking INT,
  PRIMARY KEY(ac_ID),
  FOREIGN KEY(ac_ID) REFERENCES accomodation(ac_ID)
);

CREATE TABLE resort(
  ac_ID INT,
  theme VARCHAR(255),
  num_parking INT,
  room_service BOOLEAN,
  PRIMARY KEY(ac_ID),
  FOREIGN KEY(ac_ID) REFERENCES accomodation(ac_ID)
);

CREATE TABLE rooms(
  ac_ID INT,
  Room_ID INT,
  cost FLOAT,
  num_rooms INT,
  bed_type VARCHAR(100),
  PRIMARY KEY(room_ID),
  FOREIGN KEY(ac_ID) REFERENCES accomodation(ac_ID)
);

CREATE TABLE single(
  room_ID INT,
  PRIMARY KEY(room_ID),
  FOREIGN KEY(room_ID) REFERENCES rooms(room_ID)
);

CREATE TABLE double_r(
  room_ID INT,
  PRIMARY KEY(room_ID),
  FOREIGN KEY(room_ID) REFERENCES rooms(room_ID)
);

CREATE TABLE studio(
  room_ID INT,
  kitchen BOOLEAN,
  PRIMARY KEY(room_ID),
  FOREIGN KEY(room_ID) REFERENCES rooms(room_ID)
);

CREATE TABLE dormitory(
  room_ID INT,
  num_beds INT,
  unisex BOOLEAN,
  PRIMARY KEY(room_ID),
  FOREIGN KEY(room_ID) REFERENCES rooms(room_ID)
);

CREATE TABLE suites(
  room_ID INT,
  types VARCHAR(255),
  PRIMARY KEY(room_ID),
  FOREIGN KEY(room_ID) REFERENCES rooms(room_ID)
);

CREATE TABLE facilities(
  wifi BOOLEAN,
  ac_ID INT,
  name CHAR(40),
  opening_times TIME,
  closing_times TIME,
  PRIMARY KEY(name),
  FOREIGN KEY(ac_ID) REFERENCES accomodation(ac_ID)
);

CREATE TABLE restaurant(
  name CHAR(40),
  cuisine VARCHAR(255),
  PRIMARY KEY(name),
  FOREIGN KEY(name) REFERENCES facilities(name)
);

CREATE TABLE pool(
  name CHAR(40),
  type CHAR(40),
  PRIMARY KEY(name),
  FOREIGN KEY(name) REFERENCES facilities(name)
);

CREATE TABLE spa(
  name CHAR(40),
  massage BOOLEAN,
  sauna BOOLEAN,
  thermal_baths BOOLEAN,
  PRIMARY KEY(name),
  FOREIGN KEY(name) REFERENCES facilities(name)
);

CREATE TABLE gym(
  name CHAR(40),
  classes TEXT,
  PRIMARY KEY(name),
  FOREIGN KEY(name) REFERENCES facilities(name)
);

CREATE TABLE casino(
  name CHAR(40),
  slot_machines BOOLEAN,
  table_games BOOLEAN,
  PRIMARY KEY(name),
  FOREIGN KEY(name) REFERENCES facilities(name)
);

CREATE TABLE rating(
  ac_ID INT,
  client_ID INT,
  stars INT,
  review TEXT,
  PRIMARY KEY (ac_ID,client_ID),
  FOREIGN KEY (ac_ID) REFERENCES accomodation(ac_ID),
  FOREIGN KEY (client_ID) REFERENCES client(client_ID)
);

CREATE TABLE payment(
  payment_ID INT,
  price INT,
  IBAN CHAR(22),
  creditcard_owner CHAR(80),
  expiration_date DATE,
  client_ID INT,
  PRIMARY KEY(payment_ID, client_ID),
  FOREIGN KEY(client_ID) REFERENCES client(client_ID)
);

CREATE TABLE booking(
  booking_ID INT,
  client_ID INT,
  payment_ID INT,
  num_people INT,
  arrival_date DATE,
  departure_date DATE,
  status BOOLEAN,
  PRIMARY KEY(booking_ID),
  FOREIGN KEY(client_ID) REFERENCES client(client_ID),
  FOREIGN KEY(payment_ID) REFERENCES payment(payment_ID)
);

CREATE TABLE policy(
  other_policies TEXT,
  ac_ID INT,
  checkin_date TIME,
  checkout_date TIME,
  cancellation_period INT,
  PRIMARY KEY(ac_ID),
  FOREIGN KEY(ac_ID) REFERENCES accomodation(ac_ID)
);

/*RELATIONS START HERE*/

CREATE TABLE contains(
  ac_ID INT,
  room_ID INT,
  PRIMARY KEY(ac_ID,room_ID),
  FOREIGN KEY(ac_ID) REFERENCES accomodation(ac_ID),
  FOREIGN KEY(room_ID) REFERENCES rooms(room_ID)
);

CREATE TABLE submits(
  client_ID INT,
  ac_ID INT,
  PRIMARY KEY(ac_ID,client_ID),
  FOREIGN KEY(ac_ID) REFERENCES accomodation(ac_ID),
  FOREIGN KEY(client_ID) REFERENCES client(client_ID)
);

CREATE TABLE reserves(
  booking_ID INT,
  client_ID INT,
  ac_ID INT,
  PRIMARY KEY(ac_ID,booking_ID,client_ID),
  FOREIGN KEY(booking_ID) REFERENCES booking(booking_ID),
  FOREIGN KEY(client_ID) REFERENCES client(client_ID),
  FOREIGN KEY(ac_ID) REFERENCES accomodation(ac_ID)
);

CREATE TABLE pays(
  booking_ID INT,
  client_ID INT,
  payment_ID INT,
  PRIMARY KEY(booking_ID,client_ID,payment_ID),
  FOREIGN KEY(booking_ID) REFERENCES booking(booking_ID),
  FOREIGN KEY(client_ID) REFERENCES client(client_ID),
  FOREIGN KEY(payment_ID) REFERENCES payment(payment_ID)
);

CREATE TABLE cancels(
  booking_ID INT,
  client_ID INT,
  payment_ID INT,
  PRIMARY KEY(booking_ID,client_ID,payment_ID),
  FOREIGN KEY(booking_ID) REFERENCES booking(booking_ID),
  FOREIGN KEY(client_ID) REFERENCES client(client_ID),
  FOREIGN KEY(payment_ID) REFERENCES payment(payment_ID)
);

CREATE TABLE has_policy(
  ac_ID INT,
  PRIMARY KEY(ac_ID),
  FOREIGN KEY (ac_ID) REFERENCES accomodation(ac_ID)
);

CREATE TABLE is_at(
  ac_ID INT,
  PRIMARY KEY(ac_ID),
  FOREIGN KEY (ac_ID) REFERENCES accomodation(ac_ID)
);

CREATE TABLE has(
  ac_ID INT,
  name CHAR(40),
  PRIMARY KEY(ac_ID,name),
  FOREIGN KEY (ac_ID) REFERENCES accomodation(ac_ID),
  FOREIGN KEY (name) REFERENCES facilities(name)
);
