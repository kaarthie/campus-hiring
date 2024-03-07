/*
  Warnings:

  - You are about to drop the `candidate_tracking` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `candidate_tracking` DROP FOREIGN KEY `candidate_tracking_driveId_fkey`;

-- DropForeignKey
ALTER TABLE `candidate_tracking` DROP FOREIGN KEY `candidate_tracking_studentId_fkey`;

-- DropTable
DROP TABLE `candidate_tracking`;

-- CreateTable
CREATE TABLE `CandidateTracking` (
    `driveId` INTEGER NOT NULL,
    `studentId` INTEGER NOT NULL,
    `startTime` VARCHAR(191) NOT NULL,
    `loginAttempts` INTEGER NULL DEFAULT 0,
    `roundOneDurationTaken` INTEGER NULL DEFAULT 0,

    UNIQUE INDEX `CandidateTracking_driveId_key`(`driveId`),
    PRIMARY KEY (`driveId`, `studentId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `CandidateTracking` ADD CONSTRAINT `CandidateTracking_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `CandidateTracking` ADD CONSTRAINT `CandidateTracking_studentId_fkey` FOREIGN KEY (`studentId`) REFERENCES `candidate_details_college`(`studentId`) ON DELETE RESTRICT ON UPDATE CASCADE;
