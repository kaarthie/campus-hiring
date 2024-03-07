-- DropForeignKey
ALTER TABLE `drive_details` DROP FOREIGN KEY `drive_details_answerAnswerId_fkey`;

-- CreateTable
CREATE TABLE `candidate_tracking` (
    `driveId` INTEGER NOT NULL,
    `studentId` INTEGER NOT NULL,
    `startTime` DATETIME(3) NOT NULL,
    `loginAttempts` INTEGER NOT NULL DEFAULT 0,
    `roundOneDurationTaken` INTEGER NOT NULL DEFAULT 0,
    `roundtwoDurationTaken` INTEGER NULL DEFAULT 0,

    PRIMARY KEY (`driveId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `candidate_tracking` ADD CONSTRAINT `candidate_tracking_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Answer` ADD CONSTRAINT `Answer_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;
