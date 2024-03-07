/*
  Warnings:

  - You are about to drop the `Rounds` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `Rounds` DROP FOREIGN KEY `Rounds_driveId_fkey`;

-- DropTable
DROP TABLE `Rounds`;

-- CreateTable
CREATE TABLE `round_details` (
    `driveId` INTEGER NOT NULL,
    `round1` VARCHAR(191) NOT NULL,
    `round1Duration` INTEGER NOT NULL,
    `round1TotalQuestions` INTEGER NOT NULL,
    `round2` VARCHAR(191) NULL,
    `round2Duration` INTEGER NULL,
    `round2TotalQuestions` INTEGER NULL,
    `round3` VARCHAR(191) NULL,
    `round3Duration` INTEGER NULL,
    `round3TotalQuestions` INTEGER NULL,
    `round4` VARCHAR(191) NULL,
    `round4Duration` INTEGER NULL,
    `round5` VARCHAR(191) NULL,
    `round5Duration` INTEGER NULL,

    UNIQUE INDEX `round_details_driveId_key`(`driveId`),
    PRIMARY KEY (`driveId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `round_details` ADD CONSTRAINT `round_details_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;
