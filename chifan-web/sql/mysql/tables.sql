CREATE TABLE FOOD_SHOP (
   id                   int(11) not null auto_increment,
   name                 national varchar(64) not null,
   phone              national varchar(64) not null,
   address              national varchar(64) not null,
   deleted              int(2) default 0,
   PRIMARY KEY (id)
) ENGINE=MyISAM;

create table FOOD_USER
(
   id                   int(11) not null auto_increment,
   userName             national varchar(128) not null,
   password             national varchar(128) not null,
   email                national varchar(75),
   mobile               national varchar(16),
   status               int(11) not null,
   createTime           datetime,
   modifiedTime         datetime,
   primary key (id)
);