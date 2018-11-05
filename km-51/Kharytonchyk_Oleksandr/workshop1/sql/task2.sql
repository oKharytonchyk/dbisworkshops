/*==============================================================*/
/* Task 2                       	                        */
/*==============================================================*/

DELETE FROM Place
WHERE EXISTS
  ( SELECT UserInQueueForEvent.address
    FROM UserInQueueForEvent
    WHERE UserInQueueForEvent.address = Place.address
    AND UserInQueueForEvent.user_login IS NOT NULL
    AND UserInQueueForEvent.notification_status IS NULL);

