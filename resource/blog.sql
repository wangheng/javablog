/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     11/2/2011 7:21:23 PM                         */
/*==============================================================*/


drop table if exists blog;

drop table if exists comment;

drop table if exists users;

/*==============================================================*/
/* Table: blog                                                  */
/*==============================================================*/
create table blog
(
   id                   int not null,
   category_id               int,
   title                varchar(400),
   content              varchar(4000),
   created_time         datetime,
   primary key (id)
);

/*==============================================================*/
/* Table: comment                                               */
/*==============================================================*/
create table comment
(
   id                   int not null,
   blog_id               int,
   username             varchar(200),
   content              varchar(100),
   primary key (id)
);

/*==============================================================*/
/* Table: users                                                 */
/*==============================================================*/
create table users
(
   id                   int not null,
   usename              varchar(200),
   password             varchar(200),
   primary key (id)
);

alter table comment add constraint FK_Relationship_2 foreign key (blog_id)
      references blog (id) on delete restrict on update restrict;

