/*==============================================================*/
/* Task 3                                                       */
/*==============================================================*/

UPDATE UserInQueueForEvent

SET room_number = 201

WHERE EXISTS (SELECT UserInQueueForEvent.room_number

              FROM Queue
            
	      WHERE UserInQueueForEvent.address = 'Bykova 73'
            
	      AND Queue.room_number = 201);

