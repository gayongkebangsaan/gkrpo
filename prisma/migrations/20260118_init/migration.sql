-- Migration: initial schema for MySQL (created for Prisma)
SET FOREIGN_KEY_CHECKS=0;

CREATE TABLE `User` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `telefon` varchar(191),
  `role` varchar(191) NOT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'pending',
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  UNIQUE INDEX `User.email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `ProfilAhli` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `namaPenuh` varchar(191) NOT NULL,
  `alamat` varchar(191),
  `noTelefon` varchar(191),
  `noKP_ciphertext` varchar(191),
  `pekerjaan` varchar(191),
  `tempatLahir` varchar(191),
  `tarikhLahir` datetime(3),
  `namaGelanggang` varchar(191),
  `gurulatihUserId` int,
  `gelanggangId` int,
  `daerah` varchar(191),
  `negeri` varchar(191),
  `bengkung` varchar(191),
  `noAhli` varchar(191),
  `statusAhli` varchar(191) NOT NULL DEFAULT 'Ahli Biasa',
  `sandangBerjawatan` varchar(191),
  `approvedByHQ` tinyint(1) NOT NULL DEFAULT 0,
  `approvedAt` datetime(3),
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ProfilAhli.userId_unique` (`userId`),
  CONSTRAINT `ProfilAhli_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Rangkaian` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ahliUserId` int NOT NULL,
  `sponsorUserId` int,
  `uplinePembantuGurulatihUserId` int,
  `uplineGurulatihMudaUserId` int,
  `uplineGurulatihUserId` int,
  `uplineGurulatihKananUserId` int,
  `uplineGurulatihTertinggiUserId` int,
  `daerahOwnerUserId` int,
  `negeriOwnerUserId` int,
  `pssgmkHqOwnerUserId` int,
  `pentadbirWebOwnerUserId` int,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Rangkaian.ahliUserId_unique` (`ahliUserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Pembayaran` (
  `id` int NOT NULL AUTO_INCREMENT,
  `payerUserId` int NOT NULL,
  `paymentType` varchar(191) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `currency` varchar(191) NOT NULL DEFAULT 'MYR',
  `tahun` int,
  `bulan` int,
  `gelanggangId` int,
  `status` varchar(191) NOT NULL DEFAULT 'pending',
  `paymentProvider` varchar(191),
  `stripePaymentIntentId` varchar(191),
  `stripeCheckoutSessionId` varchar(191),
  `paidAt` datetime(3),
  `requiresApproval` tinyint(1) NOT NULL DEFAULT 0,
  `approvedByUserId` int,
  `approvedAt` datetime(3),
  `nota` varchar(191),
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `LedgerKomisyen` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pembayaranId` int NOT NULL,
  `penerimaUserId` int NOT NULL,
  `penerimaRole` varchar(191) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'pending',
  `stripeTransferId` varchar(191),
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `JadualYuranBengkung` (
  `id` int NOT NULL AUTO_INCREMENT,
  `namaBengkung` varchar(191) NOT NULL,
  `gurulatihAmount` decimal(10,2) NOT NULL,
  `negeriAmount` decimal(10,2) NOT NULL,
  `pssgmkHqAmount` decimal(10,2) NOT NULL,
  `totalAmount` decimal(10,2) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  UNIQUE INDEX `JadualYuranBengkung.namaBengkung_unique` (`namaBengkung`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET FOREIGN_KEY_CHECKS=1;

