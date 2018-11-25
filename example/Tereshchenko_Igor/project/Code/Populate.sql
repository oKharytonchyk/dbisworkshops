/* Create SuperUsers */
 
INSERT INTO SuperUser (user_login, user_password, user_email) 
  VALUES ('ledoff.sky', 'qwerty123456', 'ledoff.sky@ukr.net');
INSERT INTO SuperUser (user_login, user_password, user_email) 
  VALUES ('Adamobskiy', 'lubliuPITON', 'Adamobskiy@gmail.com');
INSERT INTO SuperUser (user_login, user_password, user_email) 
  VALUES ('kotick', 'cockpit', 'hybris@gmail.com');
INSERT INTO SuperUser (user_login, user_password, user_email) 
  VALUES ('Slidan', 'youtube', 'slidan1@ukr.net');

 
/* Create Notifications */

INSERT INTO Notification (notification_status) VALUES ('You are 10th');
INSERT INTO Notification (notification_status) VALUES ('You are 5th');
INSERT INTO Notification (notification_status) VALUES ('You are 3rd');
INSERT INTO Notification (notification_status) VALUES ('You are next');
 
 
/* Create Places */

INSERT INTO Place (place_id, address, room_number, schedule) VALUES (1, 'Bykova 11', 101, '10:00 19:00');
INSERT INTO Place (place_id, address, room_number, schedule) VALUES (2, 'Bykova 73', 101, '10:00 19:00');
INSERT INTO Place (place_id, address, room_number, schedule) VALUES (3, 'Virmenska 1', 101, '10:00 19:00');
INSERT INTO Place (place_id, address, room_number, schedule) VALUES (4, 'Frunze 103', 101, '09:00 18:00');
INSERT INTO Place (place_id, address, room_number, schedule) VALUES (5, 'Bazhana 7', 101, '09:00 18:00');


/* Create Events */

INSERT INTO Event (event_name) VALUES ('Concert');
INSERT INTO Event (event_name) VALUES ('Doctor');
INSERT INTO Event (event_name) VALUES ('Lab work');
INSERT INTO Event (event_name) VALUES ('Talent show');
 
 
/* Create CreatedEvents */

INSERT INTO CreatedEvent (place_id, event_name, date_creation_event) VALUES (1, 'Concert', TO_DATE('2018-12-12', 'YYYY-MM-DD'));
INSERT INTO CreatedEvent (place_id, event_name, date_creation_event) VALUES (2, 'Doctor', TO_DATE('2018-11-11', 'YYYY-MM-DD'));
INSERT INTO CreatedEvent (place_id, event_name, date_creation_event) VALUES (3, 'Lab work', TO_DATE('2018-09-15', 'YYYY-MM-DD'));
INSERT INTO CreatedEvent (place_id, event_name, date_creation_event) VALUES (4, 'Talent show', TO_DATE('2018-01-27', 'YYYY-MM-DD'));


/* Create Queues */

INSERT INTO Queue (notification_status, user_login, place_id, event_name, date_creation_event, date_request_creation, wishlist_status)
   VALUES ('You are 10th', 'ledoff.sky', 2, 'Doctor', TO_DATE('2018-11-11', 'YYYY-MM-DD'), TO_DATE('2019-01-01', 'YYYY-MM-DD'), 'approved');
INSERT INTO Queue (notification_status, user_login, place_id, event_name, date_creation_event, date_request_creation, wishlist_status)
   VALUES ('You are 10th', 'ledoff.sky', 2, 'Doctor', TO_DATE('2018-11-11', 'YYYY-MM-DD'), TO_DATE('2019-01-02', 'YYYY-MM-DD'), 'rejected');
INSERT INTO Queue (notification_status, user_login, place_id, event_name, date_creation_event, date_request_creation, wishlist_status)
   VALUES ('You are 3rd', 'Adamobskiy', 4, 'Talent show', TO_DATE('2018-01-27', 'YYYY-MM-DD'), TO_DATE('2019-01-03', 'YYYY-MM-DD'), 'approved');
INSERT INTO Queue (notification_status, user_login, place_id, event_name, date_creation_event, date_request_creation, wishlist_status)
   VALUES ('You are next', 'Slidan', 1, 'Concert', TO_DATE('2018-12-12', 'YYYY-MM-DD'), TO_DATE('2019-01-04', 'YYYY-MM-DD'), 'approved');