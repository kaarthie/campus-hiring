/*
  Warnings:

  - Made the column `option1` on table `Mcqs` required. This step will fail if there are existing NULL values in that column.
  - Made the column `option2` on table `Mcqs` required. This step will fail if there are existing NULL values in that column.
  - Made the column `option3` on table `Mcqs` required. This step will fail if there are existing NULL values in that column.
  - Made the column `option4` on table `Mcqs` required. This step will fail if there are existing NULL values in that column.
  - Made the column `answer` on table `Mcqs` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE `Mcqs` MODIFY `option1` VARCHAR(191) NOT NULL,
    MODIFY `option2` VARCHAR(191) NOT NULL,
    MODIFY `option3` VARCHAR(191) NOT NULL,
    MODIFY `option4` VARCHAR(191) NOT NULL,
    MODIFY `answer` VARCHAR(60) NOT NULL;

-- CreateTable
CREATE TABLE `drive_details` (
    `Drive_id` INTEGER NOT NULL AUTO_INCREMENT,
    `campus_id` INTEGER NOT NULL,
    `Drive_date` DATETIME(3) NOT NULL,

    PRIMARY KEY (`Drive_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `candidateDetails` (
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
ALTER TABLE `candidateDetails` ADD CONSTRAINT `candidateDetails_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`Drive_id`) ON DELETE RESTRICT ON UPDATE CASCADE;
