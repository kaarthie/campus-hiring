/*
  Warnings:

  - The primary key for the `recruitment_team` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
-- DropIndex
DROP INDEX `Answer_driveId_key` ON `Answer`;

-- AlterTable
ALTER TABLE `drive_details` ADD COLUMN `candidateDetailsCollegeStudentId` INTEGER NULL;

-- AlterTable
ALTER TABLE `recruitment_team` DROP PRIMARY KEY;

-- CreateTable
CREATE TABLE `candidate_details_college` (
    `studentId` INTEGER NOT NULL AUTO_INCREMENT,
    `registerNumber` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `college` VARCHAR(191) NOT NULL,
    `degree` VARCHAR(191) NOT NULL,
    `branch` VARCHAR(191) NOT NULL,
    `dateOfBirth` VARCHAR(191) NOT NULL,
    `gender` VARCHAR(191) NOT NULL,
    `tenthPercentage` INTEGER NOT NULL,
    `tenthYOP` INTEGER NOT NULL,
    `twelthPercentage` INTEGER NULL,
    `twelthYOP` INTEGER NULL,
    `diplomaPercentage` INTEGER NULL,
    `diplomaYOP` INTEGER NULL,
    `UG_CGPA` INTEGER NULL,
    `UG_YOP` INTEGER NULL,
    `PG_CGPA` INTEGER NULL,
    `PG_YOP` INTEGER NULL,
    `arrearStatus` VARCHAR(191) NULL,
    `arrearCount` INTEGER NULL,
    `mobileNumber` INTEGER NULL,
    `email` VARCHAR(191) NULL,
    `address` VARCHAR(191) NULL,

    UNIQUE INDEX `candidate_details_college_studentId_key`(`studentId`),
    PRIMARY KEY (`studentId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `drive_details` ADD CONSTRAINT `drive_details_candidateDetailsCollegeStudentId_fkey` FOREIGN KEY (`candidateDetailsCollegeStudentId`) REFERENCES `candidate_details_college`(`studentId`) ON DELETE SET NULL ON UPDATE CASCADE;
