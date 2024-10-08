-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 09, 2023 at 11:05 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dishub`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getLocationRecord` (IN `lokasi` VARCHAR(50))   BEGIN
    SELECT pemilik_kendaraan.nama, perizinan.nopol, record.lokasi, record.tanggal
    FROM pemilik_kendaraan INNER JOIN perizinan ON pemilik_kendaraan.NIK_pemilik_kendaraan = perizinan.NIK_pemilik_kendaraan
    INNER JOIN record ON record.nomor_perizinan = perizinan.nomor_perizinan 
    INNER JOIN kendaraan ON perizinan.nopol = kendaraan.nopol
    WHERE lokasi = record.lokasi AND kendaraan.jenis_transportasi LIKE "Darat";
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getPemilikJenis` (IN `jenis` VARCHAR(50))   BEGIN
    SELECT perizinan.nomor_perizinan, pemilik_kendaraan.nama, kendaraan.jenis_transportasi, kendaraan.rute, kendaraan.jumlah_penumpang, kendaraan.nopol 
    FROM perizinan INNER JOIN pemilik_kendaraan ON perizinan.NIK_pemilik_kendaraan = pemilik_kendaraan.NIK_pemilik_kendaraan
    INNER JOIN kendaraan ON perizinan.nopol = kendaraan.nopol
    WHERE jenis = kendaraan.jenis_transportasi;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `kendaraan`
--

CREATE TABLE `kendaraan` (
  `nopol` varchar(12) NOT NULL,
  `jumlah_penumpang` int(3) NOT NULL,
  `jenis_transportasi` varchar(12) NOT NULL,
  `rute` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kendaraan`
--

INSERT INTO `kendaraan` (`nopol`, `jumlah_penumpang`, `jenis_transportasi`, `rute`) VALUES
('B 1234 ABC', 30, 'Darat', 'Jakarta-Depok'),
('D 5678 DEF', 4, 'Darat', 'Pribadi'),
('F 9101 GHI', 80, 'Laut', 'Bali-Madura'),
('J 1123 JKL', 77, 'Laut', 'Lampung-Palembang'),
('M 4567 MNO', 23, 'Darat', 'Malang-Sidoarjo-Yogyakarta'),
('S 2345 STU', 55, 'Udara', 'NTB-Surabaya'),
('T 8901 PQR', 24, 'Darat', 'Mojokerto-Surabaya'),
('W 6789 VWX', 69, 'Udara', 'Sabang-Jayapura'),
('Y 0123 YZ0', 19, 'Darat', 'Malang-Madiun'),
('Z 4567 ZAB', 27, 'Darat', 'Magelang-Banyuwangi');

-- --------------------------------------------------------

--
-- Table structure for table `kepala_dinas`
--

CREATE TABLE `kepala_dinas` (
  `Id_dinas` varchar(7) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `umur` date NOT NULL,
  `NIK` varchar(20) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `lokasi_dinas` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kepala_dinas`
--

INSERT INTO `kepala_dinas` (`Id_dinas`, `nama`, `umur`, `NIK`, `alamat`, `lokasi_dinas`) VALUES
('KD-001', 'Slamet Sumitro', '1988-12-08', '000312839211', 'Sawojajar', 'Batu'),
('KD-002', 'Kanz Abdillah', '1976-12-16', '098364738126', 'Araya', 'Jakarta'),
('KD-003', 'John', '1984-12-05', '098263728356', 'Mangunrejo', 'Subang'),
('KD-004', 'Audric Nagata', '1979-08-21', '267382936721', 'Blimbing', 'Pangkal Piang'),
('KD-005', 'Billy Jason', '1975-06-06', '126738495038', 'Araya', 'Kupang'),
('KD-006', 'Maden Tanta', '1990-11-09', '145263726142', 'Kepanjen', 'Kediri'),
('KD-007', 'Johan Satria', '1989-12-18', '728394012634', 'Sumedang', 'Malang'),
('KD-008', 'KOKO', '1988-12-25', '726381263049', 'Karangploso', 'Tulungagung'),
('KD-009', 'Bayu Aji', '1978-12-11', '827394028173', 'Pakis', 'NTB'),
('KD-010', 'Koni Ari', '1988-12-25', '736482039485', 'Sawojajar', 'Surabaya');

-- --------------------------------------------------------

--
-- Table structure for table `pegawai`
--

CREATE TABLE `pegawai` (
  `id_pegawai` varchar(7) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `umur` date NOT NULL,
  `NIK` varchar(20) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `id_dinas` varchar(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pegawai`
--

INSERT INTO `pegawai` (`id_pegawai`, `nama`, `umur`, `NIK`, `alamat`, `id_dinas`) VALUES
('PD-001', 'Subhkan', '1993-12-19', '562738201923', 'Sidoarjo', 'KD-001'),
('PD-002', 'Bukhori', '1998-08-14', '526371263548', 'Malang', 'KD-002'),
('PD-003', 'Sulistiono', '1997-11-20', '627301928374', 'Kertosono', 'KD-004'),
('PD-004', 'Febri', '1989-10-09', '516273812736', 'Araya', 'KD-004'),
('PD-005', 'Wahyu', '1998-07-18', '354612839456', 'Pakis', 'KD-002'),
('PD-006', 'Suyono', '1996-12-05', '351263748591', 'Mojosari', 'KD-008'),
('PD-007', 'Kamal ', '1987-12-04', '261736251423', 'Kebonagung', 'KD-006'),
('PD-008', 'Hidayat', '1998-12-04', '837462734576', 'Sukun', 'KD-010'),
('PD-009', 'Winarno', '1998-12-19', '738471234562', 'Kepanjen', 'KD-008'),
('PD-010', 'Marun', '1990-12-03', '245361783948', 'Araya', 'KD-010');

-- --------------------------------------------------------

--
-- Table structure for table `pemilik_kendaraan`
--

CREATE TABLE `pemilik_kendaraan` (
  `NIK_pemilik_kendaraan` varchar(20) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `alamat_tempat_tinggal` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pemilik_kendaraan`
--

INSERT INTO `pemilik_kendaraan` (`NIK_pemilik_kendaraan`, `nama`, `tanggal_lahir`, `alamat_tempat_tinggal`) VALUES
('123890765432', 'Budi Santoso', '1985-12-09', 'Pakis'),
('163248507932', 'Nita Putri', '1982-09-08', 'Arjosari'),
('216789430521', 'Agus Widodo', '1991-07-20', 'Araya'),
('307856124985', 'Adi Nugroho', '1998-04-30', 'Sumedang'),
('482930175614', 'Maya Utami', '1987-01-15', 'Sawojajar'),
('530917462845', 'Rini Suryani', '1975-11-03', 'Arjosari'),
('648701593287', 'Dewi Rahayu', '1978-10-14', 'Araya'),
('759102834671', 'Joko Susanto', '1994-03-27', 'Sawojajar'),
('894605312178', 'Dedi Pratama', '2000-05-12', 'Arjosari'),
('975346218034', 'Siti Hidayah', '1989-02-06', 'Araya');

-- --------------------------------------------------------

--
-- Table structure for table `perizinan`
--

CREATE TABLE `perizinan` (
  `nomor_perizinan` varchar(12) NOT NULL,
  `tanggal_perizinan` date NOT NULL,
  `id_pegawai` varchar(7) NOT NULL,
  `nopol` varchar(12) NOT NULL,
  `NIK_pemilik_kendaraan` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `perizinan`
--

INSERT INTO `perizinan` (`nomor_perizinan`, `tanggal_perizinan`, `id_pegawai`, `nopol`, `NIK_pemilik_kendaraan`) VALUES
('184570923562', '2023-09-05', 'PD-003', 'W 6789 VWX', '759102834671'),
('305768914278', '2023-05-22', 'PD-005', 'S 2345 STU', '530917462845'),
('426109753804', '2023-01-25', 'PD-007', 'D 5678 DEF', '163248507932'),
('518402367591', '2023-04-18', 'PD-001', 'J 1123 JKL', '307856124985'),
('573689401287', '2023-06-27', 'PD-003', 'Y 0123 YZ0', '894605312178'),
('639875124309', '2023-08-09', 'PD-004', 'F 9101 GHI', '216789430521'),
('742195830246', '2023-11-30', 'PD-010', 'M 4567 MNO', '482930175614'),
('820346197534', '2023-02-10', 'PD-002', 'Z 4567 ZAB', '975346218034'),
('857209314682', '2023-07-12', 'PD-004', 'B 1234 ABC', '123890765432'),
('961237508413', '2023-03-14', 'PD-004', 'T 8901 PQR', '648701593287');

-- --------------------------------------------------------

--
-- Stand-in structure for view `perizinan_with_salary`
-- (See below for the actual view)
--
CREATE TABLE `perizinan_with_salary` (
`nama` varchar(50)
,`id_pegawai` varchar(7)
,`Gaji Kotor` varchar(41)
);

-- --------------------------------------------------------

--
-- Table structure for table `record`
--

CREATE TABLE `record` (
  `id_record` varchar(7) NOT NULL,
  `nomor_perizinan` varchar(12) NOT NULL,
  `nopol` varchar(12) NOT NULL,
  `tanggal` datetime NOT NULL,
  `lokasi` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `record`
--

INSERT INTO `record` (`id_record`, `nomor_perizinan`, `nopol`, `tanggal`, `lokasi`) VALUES
('1234567', '639875124309', 'S 2345 STU', '2023-05-22 14:20:56', 'Batu'),
('3456789', '820346197534', 'W 6789 VWX', '2023-09-05 19:36:04', 'Tulungagung'),
('4892156', '184570923562', 'B 1234 ABC', '2023-07-12 08:14:32', 'Malang'),
('5647389', '426109753804', 'F 9101 GHI', '2023-08-09 12:45:21', 'Malang'),
('6578901', '573689401287', 'M 4567 MNO', '2023-11-30 05:52:43', 'Malang'),
('6789123', '961237508413', 'Z 4567 ZAB', '2023-02-10 21:10:47', 'Jakarta'),
('7238901', '305768914278', 'D 5678 DEF', '2023-01-25 17:03:49', 'Malang'),
('8901234', '742195830246', 'T 8901 PQR', '2023-03-14 10:08:27', 'Kediri'),
('8912345', '518402367591', 'J 1123 JKL', '2023-04-18 23:30:15', 'Malang'),
('9012345', '857209314682', 'Y 0123 YZ0', '2023-06-27 03:59:18', 'Surabaya');

-- --------------------------------------------------------

--
-- Stand-in structure for view `strukturdinas`
-- (See below for the actual view)
--
CREATE TABLE `strukturdinas` (
`Kepala` varchar(255)
,`Bawahan` varchar(50)
,`Lokasi Dinas` varchar(255)
);

-- --------------------------------------------------------

--
-- Structure for view `perizinan_with_salary`
--
DROP TABLE IF EXISTS `perizinan_with_salary`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `perizinan_with_salary`  AS SELECT `pg`.`nama` AS `nama`, `p`.`id_pegawai` AS `id_pegawai`, concat('Rp ',format(sum(500000),0)) AS `Gaji Kotor` FROM (`perizinan` `p` join `pegawai` `pg` on(`p`.`id_pegawai` = `pg`.`id_pegawai`)) GROUP BY `p`.`id_pegawai`, `pg`.`nama` ;

-- --------------------------------------------------------

--
-- Structure for view `strukturdinas`
--
DROP TABLE IF EXISTS `strukturdinas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `strukturdinas`  AS SELECT `k`.`nama` AS `Kepala`, `p`.`nama` AS `Bawahan`, `k`.`lokasi_dinas` AS `Lokasi Dinas` FROM (`kepala_dinas` `k` join `pegawai` `p` on(`k`.`Id_dinas` = `p`.`id_dinas`)) ORDER BY `k`.`nama` ASC ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kendaraan`
--
ALTER TABLE `kendaraan`
  ADD PRIMARY KEY (`nopol`);

--
-- Indexes for table `kepala_dinas`
--
ALTER TABLE `kepala_dinas`
  ADD PRIMARY KEY (`Id_dinas`);

--
-- Indexes for table `pegawai`
--
ALTER TABLE `pegawai`
  ADD PRIMARY KEY (`id_pegawai`),
  ADD KEY `id_dinas` (`id_dinas`);

--
-- Indexes for table `pemilik_kendaraan`
--
ALTER TABLE `pemilik_kendaraan`
  ADD PRIMARY KEY (`NIK_pemilik_kendaraan`);

--
-- Indexes for table `perizinan`
--
ALTER TABLE `perizinan`
  ADD PRIMARY KEY (`nomor_perizinan`),
  ADD KEY `NIK_pemilik_kendaraan` (`NIK_pemilik_kendaraan`),
  ADD KEY `nopol` (`nopol`),
  ADD KEY `id_pegawai` (`id_pegawai`);

--
-- Indexes for table `record`
--
ALTER TABLE `record`
  ADD PRIMARY KEY (`id_record`),
  ADD KEY `nomor_perizinan` (`nomor_perizinan`),
  ADD KEY `nopol` (`nopol`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `pegawai`
--
ALTER TABLE `pegawai`
  ADD CONSTRAINT `pegawai_ibfk_1` FOREIGN KEY (`id_dinas`) REFERENCES `kepala_dinas` (`Id_dinas`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `perizinan`
--
ALTER TABLE `perizinan`
  ADD CONSTRAINT `perizinan_ibfk_1` FOREIGN KEY (`id_pegawai`) REFERENCES `pegawai` (`id_pegawai`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `perizinan_ibfk_2` FOREIGN KEY (`nopol`) REFERENCES `kendaraan` (`nopol`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `perizinan_ibfk_3` FOREIGN KEY (`NIK_pemilik_kendaraan`) REFERENCES `pemilik_kendaraan` (`NIK_pemilik_kendaraan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `record`
--
ALTER TABLE `record`
  ADD CONSTRAINT `record_ibfk_1` FOREIGN KEY (`nopol`) REFERENCES `kendaraan` (`nopol`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `record_ibfk_2` FOREIGN KEY (`nomor_perizinan`) REFERENCES `perizinan` (`nomor_perizinan`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
