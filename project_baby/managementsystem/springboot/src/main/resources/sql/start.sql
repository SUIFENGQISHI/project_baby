-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: management
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS = @@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION = @@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE = @@TIME_ZONE */;
/*!40103 SET TIME_ZONE = '+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */;
/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES = @@SQL_NOTES, SQL_NOTES = 0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin`
(
    `id`       int NOT NULL AUTO_INCREMENT,
    `username` varchar(255) DEFAULT NULL,
    `password` varchar(255) DEFAULT NULL,
    `name`     varchar(255) DEFAULT NULL,
    `role`     varchar(255) DEFAULT NULL,
    `avatar`   varchar(255) DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `admin_username` (`username`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 6
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin`
    DISABLE KEYS */;
INSERT INTO `admin`
VALUES (1, 'SUIFENGQISHI', '123456', '随风起誓', 'ADMIN',
        'http://localhost:8080/files/download/1765158716447_微信图片_20250714093432.jpg'),
       (3, 'kebo', '123456', '劳大', 'ADMIN', 'http://localhost:8080/files/download/1765271191770_laoda_avatar.jpg'),
       (4, 'MANAGER', '666666', '杨子恒', 'ADMIN', 'http://localhost:8080/files/download/1765270876250_yzh_avatar.jpg'),
       (5, 'kuli', '123456', '科比', 'ADMIN',
        'http://localhost:8080/files/download/1765270869296_微信图片_20251125134604_6_126.jpg');
/*!40000 ALTER TABLE `admin`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article`
(
    `id`          int NOT NULL AUTO_INCREMENT,
    `title`       varchar(255) DEFAULT NULL,
    `img`         varchar(255) DEFAULT NULL,
    `description` varchar(255) DEFAULT NULL,
    `content`     longtext,
    `time`        datetime     DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `article_title` (`title`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 23
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article`
--

LOCK TABLES `article` WRITE;
/*!40000 ALTER TABLE `article`
    DISABLE KEYS */;
INSERT INTO `article`
VALUES (1, '文章测试', 'http://localhost:8080/files/download/1765339957761_2.png', '这是一篇测试文章', NULL,
        '2025-12-12 20:38:35'),
       (3, '论文', 'http://localhost:8080/files/download/1765348109410_微信图片_20250922083551_16_2.jpg', '测试论文',
        '<p><span style=\"color: rgb(106, 57, 201);\"><em><strong>尼玛死了</strong></em></span></p>',
        '2025-12-12 20:38:28'),
       (4, '时间测试', 'http://localhost:8080/files/download/1765340857741_微信图片_20251125134609_12_126.jpg',
        '时间测试',
        '<p>111<img src=\"http://localhost:8080/files/download/1765349586080_avter.jpg\" alt=\"\" data-href=\"\" style=\"width: 100%;\"/></p>',
        '2025-12-10 12:27:52'),
       (5, '111', 'http://localhost:8080/files/download/1765347843372_yzh_avatar.jpg', '111',
        '<p> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img src=\"http://localhost:8080/files/download/1765347696627_1.jpeg\" alt=\"\" data-href=\"\" style=\"width: 299.32px;height: 241.17px;\"/></p><p> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <span style=\"color: rgb(225, 60, 57); font-size: 22px;\">小宝贝，让我看看</span></p><p><span style=\"color: rgb(225, 60, 57); font-size: 22px;\">😀😃😅</span></p>',
        '2025-12-10 14:21:45'),
       (15, '123', 'http://localhost:8080/files/download/1765347843372_yzh_avatar.jpg', '111',
        '<p> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img src=\"http://localhost:8080/files/download/1765347696627_1.jpeg\" alt=\"\" data-href=\"\" style=\"width: 299.32px;height: 241.17px;\"/></p><p> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <span style=\"color: rgb(225, 60, 57); font-size: 22px;\">小宝贝，让我看看</span></p><p><span style=\"color: rgb(225, 60, 57); font-size: 22px;\">😀😃😅</span></p>',
        '2025-12-10 14:21:45'),
       (16, '131', 'http://localhost:8080/files/download/1765347843372_yzh_avatar.jpg', '111',
        '<p> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img src=\"http://localhost:8080/files/download/1765347696627_1.jpeg\" alt=\"\" data-href=\"\" style=\"width: 299.32px;height: 241.17px;\"/></p><p> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <span style=\"color: rgb(225, 60, 57); font-size: 22px;\">小宝贝，让我看看</span></p><p><span style=\"color: rgb(225, 60, 57); font-size: 22px;\">😀😃😅</span></p>',
        '2025-12-09 14:21:45'),
       (17, '21', 'http://localhost:8080/files/download/1765347843372_yzh_avatar.jpg', '111',
        '<p> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img src=\"http://localhost:8080/files/download/1765347696627_1.jpeg\" alt=\"\" data-href=\"\" style=\"width: 299.32px;height: 241.17px;\"/></p><p> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <span style=\"color: rgb(225, 60, 57); font-size: 22px;\">小宝贝，让我看看</span></p><p><span style=\"color: rgb(225, 60, 57); font-size: 22px;\">😀😃😅</span></p>',
        '2025-12-09 14:21:45'),
       (18, '324', 'http://localhost:8080/files/download/1765347843372_yzh_avatar.jpg', '111',
        '<p> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img src=\"http://localhost:8080/files/download/1765347696627_1.jpeg\" alt=\"\" data-href=\"\" style=\"width: 299.32px;height: 241.17px;\"/></p><p> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <span style=\"color: rgb(225, 60, 57); font-size: 22px;\">小宝贝，让我看看</span></p><p><span style=\"color: rgb(225, 60, 57); font-size: 22px;\">😀😃😅</span></p>',
        '2025-12-08 14:21:45'),
       (19, '234', 'http://localhost:8080/files/download/1765347843372_yzh_avatar.jpg', '111',
        '<p> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img src=\"http://localhost:8080/files/download/1765347696627_1.jpeg\" alt=\"\" data-href=\"\" style=\"width: 299.32px;height: 241.17px;\"/></p><p> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <span style=\"color: rgb(225, 60, 57); font-size: 22px;\">小宝贝，让我看看</span></p><p><span style=\"color: rgb(225, 60, 57); font-size: 22px;\">😀😃😅</span></p>',
        '2025-12-07 14:21:45'),
       (20, '454', 'http://localhost:8080/files/download/1765347843372_yzh_avatar.jpg', '111',
        '<p> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img src=\"http://localhost:8080/files/download/1765347696627_1.jpeg\" alt=\"\" data-href=\"\" style=\"width: 299.32px;height: 241.17px;\"/></p><p> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <span style=\"color: rgb(225, 60, 57); font-size: 22px;\">小宝贝，让我看看</span></p><p><span style=\"color: rgb(225, 60, 57); font-size: 22px;\">😀😃😅</span></p>',
        '2025-12-05 14:21:45'),
       (21, '434', 'http://localhost:8080/files/download/1765347843372_yzh_avatar.jpg', '111',
        '<p> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img src=\"http://localhost:8080/files/download/1765347696627_1.jpeg\" alt=\"\" data-href=\"\" style=\"width: 299.32px;height: 241.17px;\"/></p><p> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <span style=\"color: rgb(225, 60, 57); font-size: 22px;\">小宝贝，让我看看</span></p><p><span style=\"color: rgb(225, 60, 57); font-size: 22px;\">😀😃😅</span></p>',
        '2025-12-05 14:21:45'),
       (22, '12.14文章测试', 'http://localhost:8080/files/download/1765692259306_laoda_avatar.jpg', '这是一篇测试文章',
        '<p><span style=\"color: rgb(146, 84, 222);\"><strong>11111 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</strong></span><img src=\"http://localhost:8080/files/download/1765692331718_微信图片_20251125134604_6_126.jpg\" alt=\"\" data-href=\"\" style=\"width: 366.32px;height: 362.75px;\"/></p>',
        '2025-12-14 14:05:42');
/*!40000 ALTER TABLE `article`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department`
(
    `id`   int NOT NULL AUTO_INCREMENT,
    `name` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 7
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department`
    DISABLE KEYS */;
INSERT INTO `department`
VALUES (1, '销售部'),
       (2, '宣传部'),
       (3, '技术部'),
       (4, '美工部'),
       (5, '摆烂部'),
       (6, '采购部');
/*!40000 ALTER TABLE `department`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee`
(
    `id`            int         NOT NULL AUTO_INCREMENT COMMENT '员工ID',
    `name`          varchar(50) NOT NULL COMMENT '姓名',
    `sex`           varchar(10)                                            DEFAULT NULL COMMENT '性别',
    `no`            varchar(50)                                            DEFAULT NULL COMMENT '工号',
    `age`           int                                                    DEFAULT NULL COMMENT '年龄',
    `description`   varchar(500)                                           DEFAULT NULL COMMENT '描述',
    `department_id` int                                                    DEFAULT NULL COMMENT '部门ID',
    `username`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
    `password`      varchar(255)                                           DEFAULT NULL,
    `role`          varchar(255)                                           DEFAULT NULL,
    `avatar`        varchar(255)                                           DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_username` (`username`),
    UNIQUE KEY `uk_no` (`no`) COMMENT '工号唯一索引'
) ENGINE = InnoDB
  AUTO_INCREMENT = 89
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT ='员工表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee`
    DISABLE KEYS */;
INSERT INTO `employee`
VALUES (11, '刘德华', '男', 'EMP011', 35, '技术总监', 1, '111aaa', '0', 'EMP', NULL),
       (12, '张学友', '男', 'EMP012', 33, '项目经理', 2, '222bbb', '0', 'EMP', NULL),
       (13, '王菲', '女', 'EMP013', 28, '前端组长', 1, '333ccc', '0', 'EMP', NULL),
       (14, '林青霞', '女', 'EMP014', 30, '市场总监', 2, '444ddd', '0', 'EMP', NULL),
       (15, '周星驰', '男', 'EMP015', 34, '产品总监', 2, '555eee', '0', 'EMP', NULL),
       (16, '成龙', '男', 'EMP016', 36, 'CTO', 1, '666fff', '0', 'EMP', NULL),
       (17, '李连杰', '男', 'EMP017', 32, '安全工程师', 1, '777ggg', '0', 'EMP', NULL),
       (18, '甄子丹', '男', 'EMP018', 31, '运维工程师', 4, '888hhh', '0', 'EMP', NULL),
       (19, '杨幂', '女', 'EMP019', 27, '新媒体运营', 2, '999', '0', 'EMP', NULL),
       (20, '赵丽颖', '女', 'EMP020', 26, '文案策划', 2, '000', '0', 'EMP', NULL),
       (21, '迪丽热巴', '女', 'EMP021', 25, '平面设计师', 3, '11', '0', 'EMP', NULL),
       (22, '古力娜扎', '女', 'EMP022', 24, '动画设计师', 3, '22', '0', 'EMP', NULL),
       (23, '胡歌', '男', 'EMP023', 33, '数据分析师', 2, '33', '0', 'EMP', NULL),
       (24, '霍建华', '男', 'EMP024', 34, '算法工程师', 3, '44', '0', 'EMP', NULL),
       (25, '彭于晏', '男', 'EMP025', 30, 'Go开发工程师', 1, '55', '0', 'EMP', NULL),
       (26, '陈伟霆', '男', 'EMP026', 29, 'Node.js工程师', 1, '66', '0', 'EMP', NULL),
       (27, '易烊千玺', '男', 'EMP027', 22, '实习生', 1, '77', '0', 'EMP', NULL),
       (49, '杨子恒', '男', '1001', 18, '一个圣人', 3, '12', '0', 'EMP',
        'http://localhost:8080/files/download/1765336616513_OIP-C.jpg'),
       (76, '牛逼', '男', '1233', 22, '我叫马牛逼', 4, 'aaaddsf', NULL, 'EMP', NULL),
       (78, '随风起誓', '男', '666', 20, '我是武汉理工大学一名大三学生，现在在做一个宝宝项目', 4, 'SUIFENGQISHI',
        '123456', 'EMP', 'http://localhost:8080/files/download/1765158776664_微信图片_20250629225423.jpg'),
       (79, '牢大', '男', '00023', 20, '老大', 2, 'YANGZIHENG', '123456', 'EMP',
        'http://localhost:8080/files/download/1765162662898_微信图片_20250714102218.jpg'),
       (80, '112233', '女', '111', 19, 'gay', 4, '112233', '112233', 'EMP',
        'http://localhost:8080/files/download/1765271230921_avter.jpg'),
       (81, '泥马戈壁', '男', '123', 22, '泥马戈壁', 6, 'iloveyou', '123456', 'EMP', NULL),
       (87, '泰坦', '男', '521', 20, '牛逼', 5, 'apex', '123456', 'EMP', NULL),
       (88, '李西川', '男', '321', 20, '我是上海电力大学的一名学生', 3, '123456', '123456', 'EMP', NULL);
/*!40000 ALTER TABLE `employee`
    ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE = @OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE = @OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS = @OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION = @OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES = @OLD_SQL_NOTES */;

-- Dump completed on 2025-12-14 14:36:38
