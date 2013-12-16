CREATE DATABASE IF NOT EXISTS `chifan`
  DEFAULT CHARACTER SET utf8
  COLLATE utf8_general_ci;

create user 'chifan'@'localhost' identified by 'chifan';

GRANT ALL PRIVILEGES ON chifan.* TO 'chifan'@'localhost'
IDENTIFIED BY 'chifan'
WITH GRANT OPTION;
