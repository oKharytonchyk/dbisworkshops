/*==============================================================*/
/* Task 1                      		                        */
/*==============================================================*/

INSERT INTO Place (address, schedule) VALUES ('Peremohy 7', '12:00 18:00');

INSERT INTO UserInQueueForEvent(address, notification_status, room_number, user_login, create_request_date, wishlist_status)
   VALUES ('Peremohy 7', 'You are next', 101, 'ledoff.sky', TO_DATE('1976-11-05 12:34:33', 'YYYY-MM-DD HH24:MI:SS'), 'approved');
   
  