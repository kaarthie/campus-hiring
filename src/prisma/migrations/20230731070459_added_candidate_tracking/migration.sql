-- CreateTable
CREATE TABLE `candidate_tracking` (
    `driveId` INTEGER NOT NULL,
    `studentId` INTEGER NOT NULL,
    `round` INTEGER NOT NULL,
    `startTime` VARCHAR(191) NOT NULL,
    `loginAttempts` INTEGER NULL DEFAULT 0,
    `roundOneDurationTaken` VARCHAR(191) NULL DEFAULT '0',

    PRIMARY KEY (`driveId`, `studentId`, `round`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `candidate_tracking` ADD CONSTRAINT `candidate_tracking_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `candidate_tracking` ADD CONSTRAINT `candidate_tracking_studentId_fkey` FOREIGN KEY (`studentId`) REFERENCES `candidate_details_college`(`studentId`) ON DELETE RESTRICT ON UPDATE CASCADE;
