/*
  Warnings:

  - The primary key for the `drive_details` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Drive_id` on the `drive_details` table. All the data in the column will be lost.
  - You are about to drop the column `campus_id` on the `drive_details` table. All the data in the column will be lost.
  - You are about to drop the `candidateDetails` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `campusId` to the `drive_details` table without a default value. This is not possible if the table is not empty.
  - Added the required column `driveId` to the `drive_details` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `candidateDetails` DROP FOREIGN KEY `candidateDetails_driveId_fkey`;

-- AlterTable
ALTER TABLE `drive_details` DROP PRIMARY KEY,
    DROP COLUMN `Drive_id`,
    DROP COLUMN `campus_id`,
    ADD COLUMN `campusId` INTEGER NOT NULL,
    ADD COLUMN `driveId` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`driveId`);

-- DropTable
DROP TABLE `candidateDetails`;

-- CreateTable
CREATE TABLE `Campus` (
    `id` INTEGER NOT NULL,
    `campusYear` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `CandidateDetails` (
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
ALTER TABLE `drive_details` ADD CONSTRAINT `drive_details_campusId_fkey` FOREIGN KEY (`campusId`) REFERENCES `Campus`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `CandidateDetails` ADD CONSTRAINT `CandidateDetails_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;
