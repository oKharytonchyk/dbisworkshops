/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     04.11.2018 13:54:32                          */
/*==============================================================*/


alter table UserInQueueForEvent
   drop constraint FK_NOTIFICATION_EVENT;

alter table UserInQueueForEvent
   drop constraint FK_PLACE_EVENT;

alter table UserInQueueForEvent
   drop constraint FK_QUEUE_EVENT;

alter table UserInQueueForEvent
   drop constraint FK_USER_EVENT;

drop table Notification cascade constraints;

drop table Place cascade constraints;

drop table Queue cascade constraints;

drop table "User" cascade constraints;

drop index PlaceForEvent_FK;

drop index NotificationForEvent_FK;

drop index QueueForEvent_FK;

drop index UserForEvent_FK;

drop table UserInQueueForEvent cascade constraints;

/*==============================================================*/
/* Table: Notification                                          */
/*==============================================================*/
create table Notification 
(
   notification_status  VARCHAR2(20)         not null,
   constraint PK_NOTIFICATION primary key (notification_status)
);

/*==============================================================*/
/* Table: Place                                                 */
/*==============================================================*/
create table Place 
(
   address              VARCHAR2(60)         not null,
   schedule             VARCHAR2(11)         not null,
   constraint PK_PLACE primary key (address)
);

/*==============================================================*/
/* Table: Queue                                                 */
/*==============================================================*/
create table Queue 
(
   room_number          INTEGER              not null,
   constraint PK_QUEUE primary key (room_number)
);

/*==============================================================*/
/* Table: "User"                                                */
/*==============================================================*/
create table "User" 
(
   user_login           VARCHAR2(20)         not null,
   user_password        VARCHAR2(20)         not null,
   user_email           VARCHAR2(40),
   constraint PK_USER primary key (user_login)
);

/*==============================================================*/
/* Table: UserInQueueForEvent                                   */
/*==============================================================*/
create table UserInQueueForEvent 
(
   address              VARCHAR2(60)         not null,
   notification_status  VARCHAR2(20)         not null,
   room_number          INTEGER              not null,
   user_login           VARCHAR2(20)         not null,
   create_request_date  DATE                 not null,
   wishlist_status      VARCHAR2(10)         not null,
   constraint PK_USERINQUEUEFOREVENT primary key (address, notification_status, room_number, user_login, create_request_date, wishlist_status)
);

/*==============================================================*/
/* Index: UserForEvent_FK                                       */
/*==============================================================*/
create index UserForEvent_FK on UserInQueueForEvent (
   user_login ASC
);

/*==============================================================*/
/* Index: QueueForEvent_FK                                      */
/*==============================================================*/
create index QueueForEvent_FK on UserInQueueForEvent (
   room_number ASC
);

/*==============================================================*/
/* Index: NotificationForEvent_FK                               */
/*==============================================================*/
create index NotificationForEvent_FK on UserInQueueForEvent (
   notification_status ASC
);

/*==============================================================*/
/* Index: PlaceForEvent_FK                                      */
/*==============================================================*/
create index PlaceForEvent_FK on UserInQueueForEvent (
   address ASC
);

alter table UserInQueueForEvent
   add constraint FK_NOTIFICATION_EVENT foreign key (notification_status)
      references Notification (notification_status)
      on delete cascade;

alter table UserInQueueForEvent
   add constraint FK_PLACE_EVENT foreign key (address)
      references Place (address)
      on delete cascade;

alter table UserInQueueForEvent
   add constraint FK_QUEUE_EVENT foreign key (room_number)
      references Queue (room_number)
      on delete cascade;

alter table "User"
   add constraint User_unique UNIQUE (user_email);

alter table "User"
   add constraint check_login
      CHECK ( REGEXP_LIKE (user_login, '[^";]{4,40}$'));

alter table "User"
   add constraint check_password
      CHECK ( REGEXP_LIKE (user_password, '[^";]{4,40}$'));

alter table "User"
   add constraint check_email
      CHECK ( REGEXP_LIKE (user_email, '[A-Za-z0-9._]+@[A-Za-z0-9._]+\.[A-Za-z]{2,4}$'));

alter table Queue
   add constraint check_room_number
      CHECK (room_number BETWEEN 1 and 10000);

alter table Place
   add constraint check_address
      CHECK ( REGEXP_LIKE (address, '[^";]{4,60}$'));

alter table Place
   add constraint check_schedule
      CHECK ( REGEXP_LIKE (schedule, '\d{2}:\d{2} \d{2}:\d{2}$'));

alter table Notification
   add constraint check_notification_status
      CHECK ( REGEXP_LIKE (notification_status, '[^";]{1,20}$'));