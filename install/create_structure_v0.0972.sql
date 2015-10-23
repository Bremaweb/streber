-- phpMyAdmin SQL Dump
-- version 4.2.12deb2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 23, 2015 at 10:37 AM
-- Server version: 5.6.25-0ubuntu0.15.04.1-log
-- PHP Version: 5.6.4-4ubuntu6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `streber-dev`
--

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE IF NOT EXISTS `comment` (
  `id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `occasion` tinyint(4) NOT NULL DEFAULT '1',
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `person` int(11) NOT NULL DEFAULT '0',
  `comment` int(11) NOT NULL DEFAULT '0',
  `effort` int(11) NOT NULL DEFAULT '0',
  `file` int(11) NOT NULL DEFAULT '0',
  `starts_discussion` tinyint(4) NOT NULL DEFAULT '0',
  `description` longtext,
  `task` int(11) NOT NULL DEFAULT '0',
  `view_collapsed` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE IF NOT EXISTS `company` (
  `id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `tagline` varchar(255) NOT NULL DEFAULT '',
  `short` varchar(64) NOT NULL DEFAULT '',
  `phone` varchar(64) NOT NULL DEFAULT '',
  `fax` varchar(64) NOT NULL DEFAULT '',
  `street` varchar(255) NOT NULL DEFAULT '',
  `zipcode` varchar(255) NOT NULL DEFAULT '',
  `homepage` varchar(255) NOT NULL DEFAULT '',
  `intranet` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `comments` longtext,
  `state` tinyint(4) NOT NULL DEFAULT '1',
  `category` tinyint(4) NOT NULL DEFAULT '0',
  `pub_level` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `db`
--

CREATE TABLE IF NOT EXISTS `db` (
  `id` int(11) NOT NULL DEFAULT '0',
  `version` varchar(12) NOT NULL DEFAULT '',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime DEFAULT NULL,
  `version_streber_required` varchar(12) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `effort`
--

CREATE TABLE IF NOT EXISTS `effort` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `time_start` datetime DEFAULT NULL,
  `time_end` datetime DEFAULT NULL,
  `person` int(10) unsigned NOT NULL DEFAULT '0',
  `project` int(11) NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `task` int(11) NOT NULL DEFAULT '0',
  `as_duration` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `billing` int(1) NOT NULL DEFAULT '0',
  `productivity` int(1) NOT NULL DEFAULT '3'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `employment`
--

CREATE TABLE IF NOT EXISTS `employment` (
  `id` int(11) NOT NULL DEFAULT '0',
  `person` int(11) NOT NULL DEFAULT '0',
  `company` int(11) NOT NULL DEFAULT '0',
  `comment` varchar(255) NOT NULL DEFAULT '',
  `pub_level` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `file`
--

CREATE TABLE IF NOT EXISTS `file` (
  `id` int(4) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL DEFAULT '',
  `mimetype` varchar(128) NOT NULL DEFAULT '',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `org_filename` varchar(255) NOT NULL DEFAULT '',
  `tmp_filename` varchar(255) NOT NULL DEFAULT '',
  `tmp_dir` varchar(64) NOT NULL DEFAULT '',
  `filesize` int(11) NOT NULL DEFAULT '0',
  `version` int(11) NOT NULL DEFAULT '0',
  `parent_item` int(11) NOT NULL DEFAULT '0',
  `org_file` int(11) NOT NULL DEFAULT '0',
  `is_image` tinyint(4) NOT NULL DEFAULT '0',
  `is_latest` tinyint(4) NOT NULL DEFAULT '0',
  `thumbnail` varchar(255) NOT NULL DEFAULT '',
  `description` tinytext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `issue`
--

CREATE TABLE IF NOT EXISTS `issue` (
  `id` int(11) NOT NULL DEFAULT '0',
  `task` int(11) NOT NULL DEFAULT '0',
  `reproducibility` tinyint(4) NOT NULL DEFAULT '0',
  `severity` tinyint(4) NOT NULL DEFAULT '0',
  `plattform` varchar(255) NOT NULL DEFAULT '',
  `os` varchar(255) NOT NULL DEFAULT '',
  `version` varchar(32) NOT NULL DEFAULT '',
  `production_build` varchar(32) NOT NULL DEFAULT '',
  `steps_to_reproduce` text,
  `expected_result` text,
  `suggested_solution` text
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE IF NOT EXISTS `item` (
`id` int(11) NOT NULL,
  `pub_level` tinyint(4) NOT NULL DEFAULT '4',
  `type` tinyint(4) NOT NULL DEFAULT '0',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `deleted_by` int(11) NOT NULL DEFAULT '0',
  `project` int(11) NOT NULL DEFAULT '0',
  `state` tinyint(4) NOT NULL DEFAULT '1'
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `itemchange`
--

CREATE TABLE IF NOT EXISTS `itemchange` (
`id` int(11) NOT NULL,
  `item` int(11) NOT NULL DEFAULT '0',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `modified` datetime NOT NULL,
  `field` varchar(32) NOT NULL,
  `value_old` longtext NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `itemperson`
--

CREATE TABLE IF NOT EXISTS `itemperson` (
`id` int(11) NOT NULL,
  `person` int(11) NOT NULL DEFAULT '0',
  `item` int(11) NOT NULL DEFAULT '0',
  `viewed` tinyint(4) NOT NULL DEFAULT '0',
  `viewed_last` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `view_count` int(11) NOT NULL DEFAULT '1',
  `notify_if_unchanged` int(11) NOT NULL DEFAULT '0',
  `is_bookmark` tinyint(4) NOT NULL DEFAULT '0',
  `notify_on_change` tinyint(4) NOT NULL DEFAULT '0',
  `notify_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment` longtext,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `feedback_requested_by` int(4) NOT NULL DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `person`
--

CREATE TABLE IF NOT EXISTS `person` (
  `id` int(11) NOT NULL DEFAULT '0',
  `state` tinyint(4) NOT NULL DEFAULT '1',
  `name` varchar(255) NOT NULL DEFAULT '',
  `nickname` varchar(64) NOT NULL DEFAULT '',
  `tagline` varchar(255) NOT NULL DEFAULT '',
  `mobile_phone` varchar(128) NOT NULL DEFAULT '',
  `personal_phone` varchar(128) NOT NULL DEFAULT '',
  `personal_fax` varchar(128) NOT NULL DEFAULT '',
  `personal_email` varchar(255) NOT NULL DEFAULT '',
  `personal_street` varchar(255) NOT NULL DEFAULT '',
  `personal_zipcode` varchar(255) NOT NULL DEFAULT '',
  `personal_homepage` varchar(255) NOT NULL DEFAULT '',
  `office_phone` varchar(20) NOT NULL DEFAULT '',
  `office_fax` varchar(20) NOT NULL DEFAULT '',
  `office_email` varchar(60) NOT NULL DEFAULT '',
  `office_street` varchar(128) NOT NULL DEFAULT '',
  `office_zipcode` varchar(60) NOT NULL DEFAULT '',
  `office_homepage` varchar(128) NOT NULL DEFAULT '',
  `description` longtext,
  `password` varchar(255) NOT NULL DEFAULT '',
  `security_question` varchar(128) NOT NULL DEFAULT '',
  `security_answer` varchar(20) NOT NULL DEFAULT '',
  `user_rights` int(11) NOT NULL DEFAULT '0',
  `cookie_string` varchar(64) NOT NULL DEFAULT '',
  `ip_address` varchar(15) NOT NULL DEFAULT '',
  `can_login` tinyint(4) NOT NULL DEFAULT '0',
  `last_login` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_logout` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_level_view` tinyint(4) NOT NULL DEFAULT '0',
  `user_level_create` tinyint(4) NOT NULL DEFAULT '0',
  `user_level_edit` tinyint(4) NOT NULL DEFAULT '0',
  `user_level_reduce` tinyint(4) NOT NULL DEFAULT '0',
  `pub_level` tinyint(4) NOT NULL DEFAULT '0',
  `color` varchar(6) NOT NULL DEFAULT '000000',
  `profile` tinyint(4) NOT NULL DEFAULT '0',
  `theme` tinyint(4) NOT NULL DEFAULT '0',
  `identifier` varchar(64) DEFAULT NULL,
  `birthdate` date NOT NULL DEFAULT '0000-00-00',
  `show_tasks_at_home` tinyint(4) NOT NULL DEFAULT '1',
  `date_highlight_changes` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `language` varchar(5) NOT NULL DEFAULT '',
  `settings` int(11) NOT NULL DEFAULT '0',
  `notification_last` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `notification_period` tinyint(4) NOT NULL DEFAULT '7',
  `time_offset` int(11) NOT NULL DEFAULT '0',
  `category` tinyint(4) NOT NULL DEFAULT '0',
  `time_zone` float DEFAULT '25',
  `salary_per_hour` float NOT NULL DEFAULT '0',
  `ldap` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE IF NOT EXISTS `project` (
  `id` int(11) NOT NULL DEFAULT '0',
  `state` int(11) NOT NULL DEFAULT '1',
  `name` varchar(255) NOT NULL DEFAULT '',
  `short` varchar(64) NOT NULL DEFAULT '',
  `wikipage` varchar(128) NOT NULL DEFAULT '',
  `projectpage` varchar(128) NOT NULL DEFAULT '',
  `date_start` date NOT NULL DEFAULT '0000-00-00',
  `date_closed` date NOT NULL DEFAULT '0000-00-00',
  `company` int(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `prio` tinyint(4) NOT NULL DEFAULT '0',
  `description` longtext NOT NULL,
  `labels` varchar(255) NOT NULL DEFAULT 'Bug,Feature,Enhancement,Refacture,Idea,Research,Organize,Wiki,Docu,News',
  `show_in_home` tinyint(4) NOT NULL DEFAULT '1',
  `pub_level` tinyint(4) NOT NULL DEFAULT '0',
  `default_pub_level` tinyint(4) NOT NULL DEFAULT '4',
  `settings` int(4) DEFAULT '65535',
  `color` varchar(6) NOT NULL DEFAULT '000000',
  `status_summary` varchar(128) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `projectperson`
--

CREATE TABLE IF NOT EXISTS `projectperson` (
  `id` int(11) NOT NULL DEFAULT '0',
  `state` tinyint(4) NOT NULL DEFAULT '1',
  `project` int(11) NOT NULL DEFAULT '0',
  `name` varchar(64) NOT NULL DEFAULT '',
  `person` int(11) NOT NULL DEFAULT '0',
  `proj_rights` int(11) NOT NULL DEFAULT '0',
  `level_view` tinyint(4) NOT NULL DEFAULT '0',
  `level_edit` tinyint(4) NOT NULL DEFAULT '0',
  `level_create` tinyint(4) NOT NULL DEFAULT '0',
  `level_reduce` tinyint(4) NOT NULL DEFAULT '0',
  `level_delete` tinyint(4) NOT NULL DEFAULT '4',
  `role` tinyint(4) NOT NULL DEFAULT '0',
  `adjust_effort_style` tinyint(4) NOT NULL DEFAULT '1',
  `salary_per_hour` float NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `task`
--

CREATE TABLE IF NOT EXISTS `task` (
  `id` int(11) NOT NULL DEFAULT '0',
  `order_id` int(11) NOT NULL DEFAULT '0',
  `estimated` int(11) DEFAULT '0',
  `estimated_max` int(11) DEFAULT '0',
  `completion` tinyint(4) NOT NULL DEFAULT '0',
  `parent_task` int(11) NOT NULL DEFAULT '0',
  `is_folder` tinyint(4) NOT NULL DEFAULT '0',
  `category` tinyint(4) NOT NULL DEFAULT '0',
  `is_milestone` tinyint(4) NOT NULL DEFAULT '0',
  `is_released` tinyint(4) NOT NULL DEFAULT '0',
  `time_released` datetime NOT NULL,
  `label` tinyint(4) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `short` varchar(64) NOT NULL DEFAULT '',
  `date_start` date NOT NULL DEFAULT '0000-00-00',
  `for_milestone` int(11) DEFAULT '0',
  `resolved_version` int(11) DEFAULT '0',
  `resolve_reason` tinyint(4) NOT NULL DEFAULT '0',
  `planned_start` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `planned_end` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_closed` date NOT NULL DEFAULT '0000-00-00',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `prio` tinyint(4) NOT NULL DEFAULT '0',
  `description` longtext,
  `issue_report` int(11) NOT NULL DEFAULT '0',
  `view_collapsed` tinyint(4) NOT NULL DEFAULT '0',
  `calculation` float NOT NULL DEFAULT '0',
  `is_news` tinyint(1) NOT NULL DEFAULT '0',
  `show_folder_as_documentation` int(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `taskperson`
--

CREATE TABLE IF NOT EXISTS `taskperson` (
`id` int(11) NOT NULL,
  `person` int(11) NOT NULL DEFAULT '0',
  `task` int(11) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  `assigntype` tinyint(4) NOT NULL DEFAULT '0',
  `forward` tinyint(1) NOT NULL DEFAULT '0',
  `forward_comment` text
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comment`
--
ALTER TABLE `comment`
 ADD PRIMARY KEY (`id`), ADD KEY `comment` (`comment`), ADD KEY `task` (`task`), ADD FULLTEXT KEY `name` (`name`,`description`), ADD FULLTEXT KEY `name_2` (`name`,`description`);

--
-- Indexes for table `company`
--
ALTER TABLE `company`
 ADD PRIMARY KEY (`id`), ADD KEY `id` (`id`), ADD KEY `stated` (`state`), ADD KEY `pub_level` (`pub_level`), ADD FULLTEXT KEY `comments` (`comments`), ADD FULLTEXT KEY `comments_2` (`comments`), ADD FULLTEXT KEY `name` (`name`), ADD FULLTEXT KEY `comments_3` (`comments`);

--
-- Indexes for table `effort`
--
ALTER TABLE `effort`
 ADD PRIMARY KEY (`id`), ADD KEY `project` (`project`), ADD KEY `task` (`task`), ADD KEY `time_start` (`time_start`), ADD KEY `time_end` (`time_end`);

--
-- Indexes for table `employment`
--
ALTER TABLE `employment`
 ADD PRIMARY KEY (`id`), ADD KEY `person` (`person`), ADD KEY `client` (`company`), ADD KEY `pub_level` (`pub_level`);

--
-- Indexes for table `file`
--
ALTER TABLE `file`
 ADD PRIMARY KEY (`id`), ADD KEY `parent_item` (`parent_item`), ADD KEY `is_latest` (`is_latest`);

--
-- Indexes for table `issue`
--
ALTER TABLE `issue`
 ADD PRIMARY KEY (`id`), ADD KEY `task` (`task`), ADD KEY `task_2` (`task`), ADD KEY `task_3` (`task`), ADD FULLTEXT KEY `plattform` (`plattform`,`os`,`version`,`production_build`,`steps_to_reproduce`,`expected_result`,`suggested_solution`);

--
-- Indexes for table `item`
--
ALTER TABLE `item`
 ADD PRIMARY KEY (`id`), ADD KEY `type` (`type`), ADD KEY `project` (`project`), ADD KEY `state` (`state`);

--
-- Indexes for table `itemchange`
--
ALTER TABLE `itemchange`
 ADD PRIMARY KEY (`id`), ADD KEY `item` (`item`,`modified_by`), ADD KEY `modified` (`modified`);

--
-- Indexes for table `itemperson`
--
ALTER TABLE `itemperson`
 ADD PRIMARY KEY (`id`), ADD KEY `item` (`item`,`person`), ADD KEY `feedback_requested_by` (`feedback_requested_by`);

--
-- Indexes for table `person`
--
ALTER TABLE `person`
 ADD PRIMARY KEY (`id`), ADD KEY `state` (`state`), ADD KEY `id` (`id`), ADD KEY `nickname` (`nickname`), ADD KEY `cookie_string` (`cookie_string`), ADD KEY `can_login` (`can_login`), ADD KEY `pub_level` (`pub_level`), ADD FULLTEXT KEY `name` (`name`,`nickname`,`tagline`,`description`), ADD FULLTEXT KEY `name_2` (`name`,`nickname`,`tagline`,`description`), ADD FULLTEXT KEY `name_3` (`name`,`nickname`,`tagline`,`description`);

--
-- Indexes for table `project`
--
ALTER TABLE `project`
 ADD PRIMARY KEY (`id`), ADD KEY `pub_level` (`pub_level`), ADD FULLTEXT KEY `name` (`name`,`status_summary`,`description`), ADD FULLTEXT KEY `name_2` (`name`,`status_summary`,`description`), ADD FULLTEXT KEY `name_3` (`name`,`status_summary`,`description`);

--
-- Indexes for table `projectperson`
--
ALTER TABLE `projectperson`
 ADD PRIMARY KEY (`id`), ADD KEY `project` (`project`), ADD KEY `state` (`state`), ADD KEY `person` (`person`), ADD KEY `proj_rights` (`proj_rights`), ADD KEY `person_2` (`person`,`project`);

--
-- Indexes for table `task`
--
ALTER TABLE `task`
 ADD PRIMARY KEY (`id`), ADD KEY `parent_task` (`parent_task`), ADD KEY `is_folder` (`is_folder`), ADD KEY `status` (`status`), ADD KEY `is_milestone` (`is_milestone`), ADD KEY `milestone` (`for_milestone`), ADD KEY `resolved_version` (`resolved_version`), ADD KEY `is_milestone_2` (`is_milestone`), ADD KEY `for_milestone` (`for_milestone`), ADD KEY `resolved_version_2` (`resolved_version`), ADD KEY `is_released` (`is_released`), ADD KEY `time_released` (`time_released`), ADD FULLTEXT KEY `name` (`name`,`short`,`description`), ADD FULLTEXT KEY `name_2` (`name`,`short`,`description`), ADD FULLTEXT KEY `name_3` (`name`,`short`,`description`);

--
-- Indexes for table `taskperson`
--
ALTER TABLE `taskperson`
 ADD PRIMARY KEY (`id`), ADD KEY `person` (`person`,`task`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `item`
--
ALTER TABLE `item`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `itemchange`
--
ALTER TABLE `itemchange`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `itemperson`
--
ALTER TABLE `itemperson`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `taskperson`
--
ALTER TABLE `taskperson`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
