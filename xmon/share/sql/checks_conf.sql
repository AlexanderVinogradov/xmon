CREATE TABLE `check_conf` (
  `id` int(11) NOT NULL auto_increment,
  `check_name` varchar(100) NOT NULL,
  `check_type` varchar(50) NOT NULL,
  `check_script_name` varchar(100) NOT NULL,
  `check_interval` int(11) NOT NULL,
  `check_script_timeout` int(11) NOT NULL,
  `action_script_name` varchar(100) NOT NULL,
  `action_script_timeout` varchar(100) NOT NULL,
  `check_managed` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `check_name` (`check_name`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8
