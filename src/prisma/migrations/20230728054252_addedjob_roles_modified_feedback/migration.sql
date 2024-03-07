/*
  Warnings:

  - You are about to drop the `feedBack` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `feedBack` DROP FOREIGN KEY `feedBack_driveId_fkey`;

-- DropTable
DROP TABLE `feedBack`;

-- CreateTable
CREATE TABLE `feedback` (
    `driveId` INTEGER NOT NULL,
    `labFacilityRating` INTEGER NOT NULL,
    `hospitalityRating` INTEGER NOT NULL,
    `internetBandwidthRating` INTEGER NOT NULL,
    `studentAbility` INTEGER NOT NULL,
    `overallFeedBack` VARCHAR(191) NULL,

    PRIMARY KEY (`driveId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- -- CreateTable
-- CREATE TABLE `job_roles` (
--     `driveId` INTEGER NOT NULL,
--     `jobRole` VARCHAR(191) NOT NULL,

--     PRIMARY KEY (`driveId`)
-- ) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `feedback` ADD CONSTRAINT `feedback_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
-- ALTER TABLE `job_roles` ADD CONSTRAINT `job_roles_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;
