 

/* Create Users */
 
INSERT INTO "User" (user_login, user_password, user_email) 
  VALUES ('ledoff.sky', 'qwerty123456', 'ledoff.sky@ukr.net');
 
INSERT INTO "User" (user_login, user_password, user_email) 
  VALUES ('Adamobskiy', 'lubliuPITON', 'Adamobskiy@gmail.com');
 
INSERT INTO "User" (user_login, user_password, user_email) 
  VALUES ('kotick', 'cockpit', 'hybris@gmail.com');
 
INSERT INTO "User" (user_login, user_password, user_email) 
  VALUES ('Slidan', 'youtube', 'slidan1@ukr.net');

 
/* Create Queues  */

INSERT INTO Queue (room_number) VALUES (101);
INSERT INTO Queue (room_number) VALUES (102);
INSERT INTO Queue (room_number) VALUES (103);
INSERT INTO Queue (room_number) VALUES (104);
INSERT INTO Queue (room_number) VALUES (201);
INSERT INTO Queue (room_number) VALUES (202);
 
 
/* Create Notifications */

INSERT INTO Notification (notification_status) VALUES ('You are 10th');
INSERT INTO Notification (notification_status) VALUES ('You are 5th');
INSERT INTO Notification (notification_status) VALUES ('You are 3rd');
INSERT INTO Notification (notification_status) VALUES ('You are next');
 
 
/* Create Places */

INSERT INTO Place (address, schedule) VALUES ('Bykova 11', '10:00 19:00');
INSERT INTO Place (address, schedule) VALUES ('Bykova 73', '10:00 19:00');
INSERT INTO Place (address, schedule) VALUES ('Virmenska 1', '10:00 19:00');
INSERT INTO Place (address, schedule) VALUES ('Frunze 103', '09:00 18:00');
INSERT INTO Place (address, schedule) VALUES ('Bazhana 7', '09:00 18:00');
 
 
/* Create Users in queues for events */

INSERT INTO UserInQueueForEvent(address, notification_status, room_number, user_login, create_request_date, wishlist_status)
   VALUES ('Bykova 11', 'You are 10th', 102, 'ledoff.sky', TO_DATE('1976-10-09 07:59:33', 'YYYY-MM-DD HH24:MI:SS'), 'approved');

INSERT INTO UserInQueueForEvent(address, notification_status, room_number, user_login, create_request_date, wishlist_status)
   VALUES ('Bykova 11', 'You are 10th', 102, 'ledoff.sky', TO_DATE('1976-10-10 08:59:33', 'YYYY-MM-DD HH24:MI:SS'), 'rejected');

INSERT INTO UserInQueueForEvent(address, notification_status, room_number, user_login, create_request_date, wishlist_status)
   VALUES ('Bykova 11', 'You are 5th', 102, 'ledoff.sky', TO_DATE('1976-10-11 09:59:33', 'YYYY-MM-DD HH24:MI:SS'), 'approved');

INSERT INTO UserInQueueForEvent(address, notification_status, room_number, user_login, create_request_date, wishlist_status)
   VALUES ('Bykova 73', 'You are next', 101, 'Slidan', TO_DATE('1976-10-12 17:25:11', 'YYYY-MM-DD HH24:MI:SS'), 'approved');
