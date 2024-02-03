-- phpMyAdmin SQL Dump
-- version 6.0.0-dev+20231017.984ca84bc5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 03, 2024 at 04:47 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `stockbarang`
--

-- --------------------------------------------------------

--
-- Table structure for table `keluar`
--

CREATE TABLE `keluar` (
  `idkeluar` int(11) NOT NULL,
  `idbarang` int(11) NOT NULL,
  `tanggal` timestamp NOT NULL DEFAULT current_timestamp(),
  `penerima` varchar(25) NOT NULL,
  `qty` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `keluar`
--

INSERT INTO `keluar` (`idkeluar`, `idbarang`, `tanggal`, `penerima`, `qty`) VALUES
(1, 1, '2022-05-10 08:51:26', 'pembeli', 1),
(2, 3, '2022-05-10 09:18:40', 'Hilang', 3),
(4, 2, '2022-05-13 15:29:53', 'Test 1', 2),
(5, 3, '2022-05-13 15:43:04', 'Test ', 1),
(7, 7, '2022-05-17 09:36:45', 'Vini', 3),
(8, 15, '2022-05-17 10:05:34', 'Rini', 5),
(9, 14, '2022-05-22 09:51:06', 'Rini', 530),
(10, 14, '2022-05-22 09:54:32', 'saya', 170),
(11, 14, '2022-05-22 09:54:44', 'saya', 7),
(12, 13, '2022-05-22 10:12:07', 'Test', 10),
(13, 24, '2022-05-24 07:06:49', 'saya', 15),
(14, 14, '2022-05-25 04:27:55', 'Vino', 12);

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `iduser` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`iduser`, `email`, `password`) VALUES
(1, 'vina@gmail.com', '12345'),
(6, 'vini@gmail.com', '12345'),
(7, 'vino@gmail.com', '12345'),
(8, 'vania@gmail.com', '123');

-- --------------------------------------------------------

--
-- Table structure for table `masuk`
--

CREATE TABLE `masuk` (
  `idmasuk` int(11) NOT NULL,
  `idbarang` int(11) NOT NULL,
  `tanggal` timestamp NOT NULL DEFAULT current_timestamp(),
  `keterangan` varchar(25) NOT NULL,
  `qty` int(11) NOT NULL,
  `penerima` varchar(255) DEFAULT NULL,
  `iduser` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `masuk`
--

INSERT INTO `masuk` (`idmasuk`, `idbarang`, `tanggal`, `keterangan`, `qty`, `penerima`, `iduser`) VALUES
(2, 1, '2022-05-10 08:39:11', 'Rini', 1, NULL, 0),
(5, 2, '2022-05-14 02:14:21', 'Rini', 4, NULL, 0),
(6, 10, '2022-05-17 07:33:31', 'saya', 2, NULL, 0),
(7, 7, '2022-05-17 09:33:31', 'saya', 17, NULL, 0),
(8, 14, '2022-05-17 10:05:08', 'Vini', 5, NULL, 0),
(9, 13, '2022-05-17 10:22:16', 'Rina', 10, NULL, 0),
(10, 13, '2022-05-17 13:10:45', 'Vini', 10, NULL, 0),
(11, 13, '2022-05-17 13:12:35', 'Vini', 10, NULL, 0),
(12, 16, '2022-05-17 15:46:22', 'saya', 5, NULL, 0),
(13, 14, '2022-05-22 09:53:22', 'Vini', 2, NULL, 0),
(14, 14, '2022-05-22 09:53:45', 'saya', 200, NULL, 0),
(15, 14, '2022-05-22 09:54:12', 'saya', 200, NULL, 0),
(16, 24, '2022-05-24 07:06:23', 'Rini', 5, NULL, 0),
(17, 14, '2022-05-25 04:27:23', 'Vino', 12, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `stock`
--

CREATE TABLE `stock` (
  `idbarang` int(11) NOT NULL,
  `namabarang` varchar(255) NOT NULL,
  `deskripsi` varchar(1000) NOT NULL,
  `stock` int(11) NOT NULL,
  `image` varchar(99) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `stock`
--

INSERT INTO `stock` (`idbarang`, `namabarang`, `deskripsi`, `stock`, `image`) VALUES
(13, 'ZenBook Pro Duo 15 OLED ', 'ZenBook Pro Duo 15 OLED memberikan Anda pengalaman menonton yang luar biasa imersif, dengan layar NanoEdge 4K OLED HDR 1 yang brilian, dimana menghadirkan warna ultra-vivid dan hitam pekat. Color gamut 100% DCI-P3 setingkat bioskop dan akurasi warna Delta-E <2 2, menjadikannya serba bisa untuk kreasi profesional, serta tervalidasi PANTONE® untuk akurasi warna tingkat profesional dan bersertifikat TÜV Rheinland untuk menjaga Kesehatan mata Anda.  ZenBook Pro Duo 15 OLED juga menyertakan ScreenPad Plus baru yang dapat dimiringkan, layar sentuh sekunder yang dapat dimiringkan secara otomatis sebesar 9,5°, menciptakan sudut 144,5° antara layar utama dan ScreenPad Plus untuk tampilan yang lebih nyaman. Anda dapat menikmati visual yang mulus di kedua layar, dengan multitasking yang mudah berkat aplikasi bawaan ScreenPad Plus yang dioptimalkan yang meningkatkan alur kerja Anda.', 520, 'ba9398e068f754e804952bda59ba3ec6.png'),
(14, 'ASUS ZenBook 13 OLED', 'ZenBook 13 OLED yang sangat ringkas, tipis, dan ringan dilengkapi dengan Prosesor Mobile AMD Ryzen™ 5000 Series untuk kinerja serba kuat, dan layar NanoEdge FHD OLED HDR yang menakjubkan, dimana menghadirkan visual yang sangat jelas dan nyata. Keindahan ZenBook 13 OLED akan membuat gaya hidup Anda yang aktif bepergian menjadi lebih mudah dari sebelumnya.', 0, '3feb846ecf345b2247e36f3548cefbda.png'),
(15, 'ASUS ExpertBook B3', 'ASUS ExpertBook B3 Flip dibuat untuk menyambut normal baru — kerja dan pembelajaran hybrid. Ini adalah pendamping terbaik untuk guru dan siswa, dan rekan yang sempurna untuk pengguna bisnis dan profesional. Dengan desain yang serbaguna dan tangguh, belajar atau bekerja di mana saja bukan lagi impian. Dilengkapi dengan engsel 360° untuk fleksibilitas tampilan total, kamera1 menghadap dunia untuk perspektif baru, dan stylus2 garasi untuk input yang sederhana dan aman. B3 Flip direkayasa dengan banyak fitur perlindungan yang cerdik, termasuk ASUS Antibacterial Guard3,4 dan layar bersertifikasi TÜV Rheinland untuk perawatan mata sehari-hari. Ini juga mendukung hingga WiFi 6 dan 4G LTE5 untuk konektivitas cepat dan portabel, bersama dengan teknologi peredam bising bertenaga AI dua arah dan kamera pengurang kebisingan untuk pembelajaran jarak jauh dan konferensi yang sangat baik. Dengan ExpertBook B3 Flip di tas Anda, semua dunia Anda hanya berjarak satu putaran.', 195, 'bb0ee92645503bfe87434af536410fb5.png'),
(16, 'ASUS ExpertBook B5', 'ASUS ExpertBook B5 dibuat untuk kesuksesan bisnis dalam gaya, dengan sasis yang dibuat dengan presisi dan minimalis yang mendorong batas ringan. Ini juga diatur untuk perjalanan serius dengan masa pakai baterai 14 jam yang luar biasa, dan direkayasa dengan banyak teknologi mutakhir untuk meningkatkan efisiensi kerja Anda saat bepergian. Ini termasuk prosesor Intel® Core™ Generasi ke-11, pembatalan kebisingan AI dan dukungan dual-SSD RAID, ASUS NumberPad 2.0. Itu juga dikemas dengan fitur untuk melindungi privasi dan data bisnis Anda, termasuk sensor sidik jari built-in dan chip TPM 2.0. Dengan sertifikasi Intel Evo, ExpertBook B5 adalah mitra portabel dan kuat yang sempurna untuk dunia korporat.', 105, 'cc42ece09627812c0a3cb56dc5f4f986.png'),
(25, 'ProArt Studiobook Pro 15 W500', 'ProArt StudioBook Pro 15 yang sangat portabel adalah model paling ringkas dalam jajaran produk ini, tetapi memiliki kemampuan besar dalam hal kinerja. Grafis NVIDIA® Quadro RTX™ 5000 Max Q yang kuat membuat tugas-tugas dengan grafis intensif menjadi ringan, sedangkan PANTONE PANTONE® Validated 4K UHD panel 15,6 inci-nya memastikan citra pixel sempurna setiap saat.', 12, '87ffc5e56a2aa44fe1ff9611f82801bb.png'),
(26, 'ASUS Chromebook C425', 'Sederhanakan hidup Anda dengan ASUS Chromebook C425 yang ramping dan trendi, laptop 1,3kg-ringan1 14-inci yang memiliki semua kekuatan untuk membuat pekerjaan ringan dalam tugas sehari-hari Anda. Didukung oleh prosesor Intel Core i5, ASUS Chromebook C425 meningkatkan produktivitas Anda dan memungkinkan Anda lebih bersenang-senang saat bepergian - di mana pun Anda berada, apa pun yang Anda lakukan. Desain NanoEdge-nya yang ringkas dapat dengan mudah dimasukkan ke dalam tas apa pun, dan baterainya sepanjang hari menghilangkan kecemasan stopkontak untuk gaya hidup bebas kekhawatiran. Dimuat sebelumnya dengan yang terbaik dari Google, ASUS Chromebook C425 adalah gerbang Anda yang mudah digunakan ke berbagai macam aplikasi di Google Play Store2 untuk bekerja atau bermain.', 13, '8fdee91aeb830be458a9b83d5722216b.png');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `email`, `password`) VALUES
(1, 'vinaaa@gmail.com', '$2y$10$P.EjRcO78ZD4WylGvFquZeUYS549Qx9ILTqRIUnJtpI7Hp.ZmWZiS'),
(2, 'vinae@gmail.com', '$2y$10$fvdBSbuF9NjuwfoNGBTK/.cCAaddA7DsGYUSzYd0IxewZCjWMXqJK'),
(3, 'vania@gmail.com', '$2y$10$JSKQ9raxO97xaCBrztgCLOaIZGtl2GsDba3OcvknQoNiAH2DbTfJa'),
(4, 'chaeunwoo@gmail.com', '$2y$10$WbbrBCbn3qBW5YfMpWmxH.vHSBOTuRrr9Ry5I5sGZ4dQwEWU1W8zS'),
(5, 'pinoy@gmail.com', '$2y$10$fipMemoLTkkIg0LbkqCtV.U0sDkyPApUD5Jw0ck/cnzb/VPaEi5iG');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `keluar`
--
ALTER TABLE `keluar`
  ADD PRIMARY KEY (`idkeluar`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`iduser`);

--
-- Indexes for table `masuk`
--
ALTER TABLE `masuk`
  ADD PRIMARY KEY (`idmasuk`);

--
-- Indexes for table `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`idbarang`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `keluar`
--
ALTER TABLE `keluar`
  MODIFY `idkeluar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
  MODIFY `iduser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `masuk`
--
ALTER TABLE `masuk`
  MODIFY `idmasuk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `stock`
--
ALTER TABLE `stock`
  MODIFY `idbarang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
