CREATE DATABASE  IF NOT EXISTS `new` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `new`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: new
-- ------------------------------------------------------
-- Server version	9.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `dich_vu_tien_ich`
--

DROP TABLE IF EXISTS `dich_vu_tien_ich`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dich_vu_tien_ich` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `chi_so_cu` double DEFAULT NULL,
  `chi_so_moi` double DEFAULT NULL,
  `don_gia` double DEFAULT NULL,
  `ghi_chu` varchar(255) DEFAULT NULL,
  `loai_dich_vu` enum('DIEN','NUOC','INTERNET') NOT NULL,
  `ngay_ghi_nhan` date DEFAULT NULL,
  `so_tieu_thu` double DEFAULT NULL,
  `thang_nam` varchar(255) NOT NULL,
  `thanh_tien` double DEFAULT NULL,
  `trang_thai` enum('CHUA_THANH_TOAN','DA_THANH_TOAN','QUA_HAN') DEFAULT NULL,
  `ho_khau_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK89wkcc8tuxufp9h27xx8pbp4l` (`ho_khau_id`),
  CONSTRAINT `FK89wkcc8tuxufp9h27xx8pbp4l` FOREIGN KEY (`ho_khau_id`) REFERENCES `ho_khau` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ho_khau`
--

DROP TABLE IF EXISTS `ho_khau`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ho_khau` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `address` varchar(255) NOT NULL,
  `chu_ho` varchar(255) NOT NULL,
  `duong` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `hoat_dong` bit(1) NOT NULL,
  `ngay_lam_ho_khau` date DEFAULT NULL,
  `phuong` varchar(255) DEFAULT NULL,
  `quan` varchar(255) DEFAULT NULL,
  `so_dien_thoai` varchar(255) DEFAULT NULL,
  `so_ho_khau` varchar(255) NOT NULL,
  `so_nha` varchar(255) DEFAULT NULL,
  `so_thanh_vien` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_g8jxrdteuvkrw0g4iv3s32c7l` (`so_ho_khau`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `khoan_thu`
--

DROP TABLE IF EXISTS `khoan_thu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `khoan_thu` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `bat_buoc` bit(1) NOT NULL,
  `ghi_chu` varchar(255) DEFAULT NULL,
  `hoat_dong` bit(1) NOT NULL,
  `ngay_tao` date NOT NULL,
  `so_tien` double NOT NULL,
  `ten_khoan_thu` varchar(255) NOT NULL,
  `thoi_han` date NOT NULL,
  `loai_khoan_thu` enum('PHI_QUAN_LY','PHI_BAO_TRI','DONG_GOP_TU_NGUYEN','PHI_GUI_XE','PHI_DIEN','PHI_NUOC','PHI_INTERNET','PHI_DICH_VU_KHAC') DEFAULT NULL,
  `thang_nam_ap_dung` varchar(255) DEFAULT NULL,
  `tu_dong_tinh_toan` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lich_su_ho_khau`
--

DROP TABLE IF EXISTS `lich_su_ho_khau`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lich_su_ho_khau` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `ghi_chu` varchar(255) DEFAULT NULL,
  `loai_thay_doi` enum('TAM_TRU','TAM_VANG','THEM_NHAN_KHAU','XOA_NHAN_KHAU') NOT NULL,
  `thoi_gian` date NOT NULL,
  `ho_khau_id` bigint NOT NULL,
  `nhan_khau_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKhb3jqlmujsnhxwf36aqf9jvwn` (`ho_khau_id`),
  KEY `FKdupkvc1bte28twbdg4nhvvies` (`nhan_khau_id`),
  CONSTRAINT `FKdupkvc1bte28twbdg4nhvvies` FOREIGN KEY (`nhan_khau_id`) REFERENCES `nhan_khau` (`id`),
  CONSTRAINT `FKhb3jqlmujsnhxwf36aqf9jvwn` FOREIGN KEY (`ho_khau_id`) REFERENCES `ho_khau` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nhan_khau`
--

DROP TABLE IF EXISTS `nhan_khau`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nhan_khau` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cccd` varchar(255) NOT NULL,
  `dan_toc` varchar(255) DEFAULT NULL,
  `ghi_chu` varchar(255) DEFAULT NULL,
  `gioi_tinh` varchar(255) NOT NULL,
  `ho_ten` varchar(255) NOT NULL,
  `ngay_cap` date DEFAULT NULL,
  `ngay_sinh` date NOT NULL,
  `ngay_them_nhan_khau` date NOT NULL,
  `nghe_nghiep` varchar(255) DEFAULT NULL,
  `noi_cap` varchar(255) DEFAULT NULL,
  `quan_he_voi_chu_ho` varchar(255) DEFAULT NULL,
  `ton_giao` varchar(255) DEFAULT NULL,
  `ho_khau_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_ki87si3fjhtopmhaqfj85ag51` (`cccd`),
  KEY `FKkrbbyoj4olxij5pucwtg9q0ad` (`ho_khau_id`),
  CONSTRAINT `FKkrbbyoj4olxij5pucwtg9q0ad` FOREIGN KEY (`ho_khau_id`) REFERENCES `ho_khau` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nop_phi`
--

DROP TABLE IF EXISTS `nop_phi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nop_phi` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `da_xac_nhan` bit(1) NOT NULL,
  `ghi_chu` varchar(255) DEFAULT NULL,
  `ngay_nop` date NOT NULL,
  `nguoi_nop` varchar(255) DEFAULT NULL,
  `so_tien` double NOT NULL,
  `tong_tien` double NOT NULL,
  `ho_khau_id` bigint NOT NULL,
  `khoan_thu_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKpe2sok0cjmjdxb72uo5d1xj06` (`ho_khau_id`),
  KEY `FKo44vql56wbprvovryqmouo5xv` (`khoan_thu_id`),
  CONSTRAINT `FKo44vql56wbprvovryqmouo5xv` FOREIGN KEY (`khoan_thu_id`) REFERENCES `khoan_thu` (`id`),
  CONSTRAINT `FKpe2sok0cjmjdxb72uo5d1xj06` FOREIGN KEY (`ho_khau_id`) REFERENCES `ho_khau` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `entity_id` bigint DEFAULT NULL,
  `entity_type` enum('FEE','HOUSEHOLD','PAYMENT') NOT NULL,
  `message` varchar(1000) NOT NULL,
  `is_read` bit(1) NOT NULL,
  `title` varchar(255) NOT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9y21adhxn0ayjhfocscqox7bh` (`user_id`),
  CONSTRAINT `FK9y21adhxn0ayjhfocscqox7bh` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phuong_tien`
--

DROP TABLE IF EXISTS `phuong_tien`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phuong_tien` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `bien_so` varchar(255) NOT NULL,
  `ghi_chu` varchar(255) DEFAULT NULL,
  `hang_xe` varchar(255) DEFAULT NULL,
  `hoat_dong` bit(1) DEFAULT NULL,
  `loai_phuong_tien` enum('XE_MAY','O_TO') NOT NULL,
  `mau_xe` varchar(255) DEFAULT NULL,
  `ngay_dang_ky` date NOT NULL,
  `ho_khau_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_i0prdf22q5j2u6heqnt83mgd6` (`bien_so`),
  KEY `FKksuy0p778x74sapt6pllwyof` (`ho_khau_id`),
  CONSTRAINT `FKksuy0p778x74sapt6pllwyof` FOREIGN KEY (`ho_khau_id`) REFERENCES `ho_khau` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tam_tru_tam_vang`
--

DROP TABLE IF EXISTS `tam_tru_tam_vang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tam_tru_tam_vang` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `dia_chi_tam_tru_tam_vang` varchar(255) NOT NULL,
  `noi_dung_de_nghi` varchar(255) DEFAULT NULL,
  `thoi_gian` date NOT NULL,
  `trang_thai` enum('TAM_TRU','TAM_VANG') NOT NULL,
  `nhan_khau_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKqat94opsqtibtpd6it5vmj8hr` (`nhan_khau_id`),
  CONSTRAINT `FKqat94opsqtibtpd6it5vmj8hr` FOREIGN KEY (`nhan_khau_id`) REFERENCES `nhan_khau` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `enabled` bit(1) NOT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `vai_tro` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_r43af9ap4edm43mmtq01oddj6` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `utility_payment`
--

DROP TABLE IF EXISTS `utility_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utility_payment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `ghi_chu` varchar(255) DEFAULT NULL,
  `ho_khau_id` bigint NOT NULL,
  `ma_giao_dich` varchar(255) DEFAULT NULL,
  `nam` int NOT NULL,
  `ngay_thanh_toan` date NOT NULL,
  `nguoi_thu` varchar(255) DEFAULT NULL,
  `phuong_thuc_thanh_toan` varchar(255) NOT NULL,
  `so_tien_thanh_toan` double NOT NULL,
  `thang` int NOT NULL,
  `trang_thai` varchar(255) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `utility_service_id` bigint DEFAULT NULL,
  `phi_dich_vu` double DEFAULT NULL,
  `phi_gui_xe` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKew9eea8bb0dvscin287kfprdq` (`ho_khau_id`),
  KEY `FKbjgrjn0whhy1ajr7y9skdru8l` (`utility_service_id`),
  CONSTRAINT `FKbjgrjn0whhy1ajr7y9skdru8l` FOREIGN KEY (`utility_service_id`) REFERENCES `utility_service` (`id`),
  CONSTRAINT `FKew9eea8bb0dvscin287kfprdq` FOREIGN KEY (`ho_khau_id`) REFERENCES `ho_khau` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `utility_service`
--

DROP TABLE IF EXISTS `utility_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utility_service` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `chi_so_cu` double DEFAULT NULL,
  `chi_so_moi` double DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `don_gia` double DEFAULT NULL,
  `ghi_chu` varchar(255) DEFAULT NULL,
  `ho_khau_id` bigint NOT NULL,
  `loai_dich_vu` varchar(255) NOT NULL,
  `nam` int NOT NULL,
  `ngay_ghi_nhan` datetime(6) DEFAULT NULL,
  `phi_co_dinh` double DEFAULT NULL,
  `so_luong_su_dung` double DEFAULT NULL,
  `thang` int NOT NULL,
  `tong_tien` double NOT NULL,
  `trang_thai` varchar(255) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `don_vi_tinh` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1oqhkt2plqj46a83lkocj3bbe` (`ho_khau_id`),
  CONSTRAINT `FK1oqhkt2plqj46a83lkocj3bbe` FOREIGN KEY (`ho_khau_id`) REFERENCES `ho_khau` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `bien_so_xe` varchar(255) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `ghi_chu` varchar(255) DEFAULT NULL,
  `hang_xe` varchar(255) DEFAULT NULL,
  `ho_khau_id` bigint NOT NULL,
  `loai_xe` varchar(255) NOT NULL,
  `mau_sac` varchar(255) DEFAULT NULL,
  `mau_xe` varchar(255) DEFAULT NULL,
  `nam_san_xuat` int DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_h3jgqid4rgnk0oomn3aonceke` (`bien_so_xe`),
  KEY `FKmybmwk4y1n52yrgfkc0wcpmjn` (`ho_khau_id`),
  CONSTRAINT `FKmybmwk4y1n52yrgfkc0wcpmjn` FOREIGN KEY (`ho_khau_id`) REFERENCES `ho_khau` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-16 18:42:31
