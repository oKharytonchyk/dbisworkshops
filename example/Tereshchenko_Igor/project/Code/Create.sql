/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     11.11.2018 19:40:02                          */
/*==============================================================*/


alter table CreatedEvent
   drop constraint FK_EVENT_CREATED_EVENT;

alter table CreatedEvent
   drop constraint FK_PLACE_CREATED_EVENT;

alter table Queue
   drop constraint FK_CREATED_EVENT_QUEUE;

alter table Queue
   drop constraint FK_NOTIFICATION_QUEUE;

alter table Queue
   drop constraint FK_USER_QUEUE;

drop index PlaceForCreatedEvent_FK;

drop index EventForCreatedEvent_FK;

drop table CreatedEvent cascade constraints;

drop table Event cascade constraints;

drop table Notification cascade constraints;

drop table Place cascade constraints;

drop index NotificationForQueue_FK;

drop index UserForQueue_FK;

drop index CreatedEventForQueue_FK;

drop table Queue cascade constraints;

drop table "User" cascade constraints;

/*==============================================================*/
/* Table: CreatedEvent                                          */
/*==============================================================*/
create table CreatedEvent 
(
   place_id             INTEGER              not null,
   event_name           VARCHAR2(50)         not null,
   date_creation_event  DATE                 not null,
   constraint PK_CREATEDEVENT primary key (place_id, event_name, date_creation_event)
);

/*==============================================================*/
/* Index: EventForCreatedEvent_FK                               */
/*==============================================================*/
create index EventForCreatedEvent_FK on CreatedEvent (
   event_name ASC
);

/*==============================================================*/
/* Index: PlaceForCreatedEvent_FK                               */
/*==============================================================*/
create index PlaceForCreatedEvent_FK on CreatedEvent (
   place_id ASC
);

/*==============================================================*/
/* Table: Event                                                 */
/*==============================================================*/
create table Event 
(
   event_name           VARCHAR2(50)         not null,
   constraint PK_EVENT primary key (event_name)
);

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
   place_id             INTEGER              not null,
   address              VARCHAR2(60)         not null,
   room_number          INTEGER              not null,
   schedule             VARCHAR2(11)         not null,
   constraint PK_PLACE primary key (place_id)
);

/*==============================================================*/
/* Table: Queue                                                 */
/*==============================================================*/
create table Queue 
(
   notification_status  VARCHAR2(20)         not null,
   user_login           VARCHAR2(20)         not null,
   place_id             INTEGER              not null,
   event_name           VARCHAR2(50)         not null,
   date_creation_event  DATE                 not null,
   date_request_creation DATE                 not null,
   wishlist_status      VARCHAR2(10)         not null,
   constraint PK_QUEUE primary key (notification_status, user_login, place_id, event_name, date_creation_event, wishlist_status, date_request_creation)
);

/*==============================================================*/
/* Index: CreatedEventForQueue_FK                               */
/*==============================================================*/
create index CreatedEventForQueue_FK on Queue (
   place_id ASC,
   event_name ASC,
   date_creation_event ASC
);

/*==============================================================*/
/* Index: UserForQueue_FK                                       */
/*==============================================================*/
create index UserForQueue_FK on Queue (
   user_login ASC
);

/*==============================================================*/
/* Index: NotificationForQueue_FK                               */
/*==============================================================*/
create index NotificationForQueue_FK on Queue (
   notification_status ASC
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

alter table CreatedEvent
   add constraint FK_EVENT_CREATED_EVENT foreign key (event_name)
      references Event (event_name)
      on delete cascade;

alter table CreatedEvent
   add constraint FK_PLACE_CREATED_EVENT foreign key (place_id)
      references Place (place_id)
      on delete cascade;

alter table Queue
   add constraint FK_CREATED_EVENT_QUEUE foreign key (place_id, event_name, date_creation_event)
      references CreatedEvent (place_id, event_name, date_creation_event)
      on delete cascade;

alter table Queue
   add constraint FK_NOTIFICATION_QUEUE foreign key (notification_status)
      references Notification (notification_status)
      on delete cascade;

alter table Queue
   add constraint FK_USER_QUEUE foreign key (user_login)
      references "User" (user_login)
      on delete cascade;

alter table "User"
   add constraint user_unique UNIQUE (user_email);

alter table "User"
   add constraint check_login
      CHECK ( REGEXP_LIKE (user_login, '[^";]{4,20}$'));

alter table "User"
   add constraint check_password
      CHECK ( REGEXP_LIKE (user_password, '[^";]{4,20}$'));

alter table "User"
   add constraint check_email
      CHECK ( REGEXP_LIKE (user_email, '[A-Za-z0-9._]+@[A-Za-z0-9._]+\.[A-Za-z]{2,4}$'));

alter table Place
   add constraint check_address
      CHECK ( REGEXP_LIKE (address, '[^";]{4,60}$'));

alter table Place
   add constraint check_schedule
      CHECK ( REGEXP_LIKE (schedule, '\d{2}:\d{2} \d{2}:\d{2}$'));

alter table Place
   add constraint check_room_number
      CHECK ( REGEXP_LIKE (room_number, '\d{3,5}$'));

alter table Notification
   add constraint check_notification_status
      CHECK ( REGEXP_LIKE (notification_status, '[^";]{1,20}$'));

alter table Event
   add constraint check_event_name
      CHECK ( REGEXP_LIKE (event_name, '[^";]{4,50}$'));

alter table CreatedEvent
   add constraint place_id_unique UNIQUE (place_id);

alter table CreatedEvent
   add constraint check_place_id
      CHECK ( REGEXP_LIKE (place_id, '\d{1,9}$'));

alter table Queue
   add constraint check_wishlist_status
      CHECK ( REGEXP_LIKE (wishlist_status, '[^";]{1,10}$'));
