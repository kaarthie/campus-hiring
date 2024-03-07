/*
  Warnings:

  - You are about to drop the column `Drive_date` on the `drive_details` table. All the data in the column will be lost.
  - You are about to drop the `Campus` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `CandidateDetails` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `DriveDate` to the `drive_details` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `CandidateDetails` DROP FOREIGN KEY `CandidateDetails_driveId_fkey`;

-- DropForeignKey
ALTER TABLE `drive_details` DROP FOREIGN KEY `drive_details_campusId_fkey`;

-- AlterTable
ALTER TABLE `drive_details` DROP COLUMN `Drive_date`,
    ADD COLUMN `DriveDate` DATETIME(3) NOT NULL;

-- DropTable
DROP TABLE `Campus`;

-- DropTable
DROP TABLE `CandidateDetails`;

-- CreateTable
CREATE TABLE `campus` (
    `id` INTEGER NOT NULL,
    `campusYear` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `candidate_details` (
    `userId` INTEGER NOT NULL AUTO_INCREMENT,
    `driveId` INTEGER NOT NULL,
    `candidateName` VARCHAR(191) NOT NULL,
    `mobileNumber` VARCHAR(30) NOT NULL,
    `registerNumber` VARCHAR(30) NOT NULL,
    `email` VARCHAR(30) NOT NULL,
    `college` VARCHAR(70) NOT NULL,
    `department` VARCHAR(40) NOT NULL,

    PRIMARY KEY (`userId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `drive_details` ADD CONSTRAINT `drive_details_campusId_fkey` FOREIGN KEY (`campusId`) REFERENCES `campus`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `candidate_details` ADD CONSTRAINT `candidate_details_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;
