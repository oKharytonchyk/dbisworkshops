/* Create SUPERUSERS */
INSERT INTO SUPERUSER (user_login, user_password, user_email)
VALUES ('ledoff.sky', 'qwerty123456', 'ledoff.sky@ukr.net');
INSERT INTO SUPERUSER (user_login, user_password, user_email)
VALUES ('Adamobskiy', 'lubliuPITON', 'Adamobskiy@gmail.com');
INSERT INTO SUPERUSER (user_login, user_password, user_email)
VALUES ('kotick', 'cockpit', 'hybris@gmail.com');
INSERT INTO SUPERUSER (user_login, user_password, user_email)
VALUES ('Slidan', 'youtube', 'slidan1@ukr.net');

/* Create Statuses */
INSERT INTO Status (status)
VALUES ('approved');
INSERT INTO Status (status)
VALUES ('rejected');

/* Create Places */
INSERT INTO Place (place_id, address, room_number, schedule)
VALUES (1, 'Bykova 11', 101, '10:00 19:00');
INSERT INTO Place (place_id, address, room_number, schedule)
VALUES (2, 'Bykova 73', 101, '10:00 19:00');
INSERT INTO Place (place_id, address, room_number, schedule)
VALUES (3, 'Virmenska 1', 101, '10:00 19:00');
INSERT INTO Place (place_id, address, room_number, schedule)
VALUES (4, 'Frunze 103', 101, '09:00 18:00');
INSERT INTO Place (place_id, address, room_number, schedule)
VALUES (5, 'Bazhana 7', 101, '09:00 18:00');

/* Create Events */
INSERT INTO Event (event_name)
VALUES ('Concert');
INSERT INTO Event (event_name)
VALUES ('Doctor');
INSERT INTO Event (event_name)
VALUES ('Lab work');
INSERT INTO Event (event_name)
VALUES ('Talent show');

/* Create CreatedEvents */
INSERT INTO CreatedEvent (place_id, event_name, date_creation_event)
VALUES (1, 'Concert', '2018-12-12');
INSERT INTO CreatedEvent (place_id, event_name, date_creation_event)
VALUES (2, 'Doctor', '2018-11-11');
INSERT INTO CreatedEvent (place_id, event_name, date_creation_event)
VALUES (3, 'Lab work', '2018-09-15');
INSERT INTO CreatedEvent (place_id, event_name, date_creation_event)
VALUES (4, 'Talent show', '2018-01-27');

/* Create Queues */
INSERT INTO Queue (status, user_login, place_id, event_name, date_creation_event, date_request_creation)
VALUES ('approved', 'ledoff.sky', 2, 'Doctor', '2018-11-11', '2019-01-01');
INSERT INTO Queue (status, user_login, place_id, event_name, date_creation_event, date_request_creation)
VALUES ('rejected', 'ledoff.sky', 2, 'Doctor', '2018-11-11', '2019-01-02');
INSERT INTO Queue (status, user_login, place_id, event_name, date_creation_event, date_request_creation)
VALUES ('approved', 'Adamobskiy', 4, 'Talent show', '2018-01-27', '2019-01-03');
INSERT INTO Queue (status, user_login, place_id, event_name, date_creation_event, date_request_creation)
VALUES ('approved', 'Slidan', 1, 'Concert', '2018-12-12', '2019-01-04');
