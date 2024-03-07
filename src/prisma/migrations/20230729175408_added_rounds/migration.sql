-- CreateTable
CREATE TABLE `round_details` (
    `driveId` INTEGER NOT NULL,
    `round` INTEGER NOT NULL,
    `roundName` VARCHAR(191) NULL,
    `roundDuration` INTEGER NOT NULL,
    `roundTotalQuestions` INTEGER NOT NULL,
    `roundDifficulty` VARCHAR(191) NULL,
    `roundTopics` VARCHAR(191) NULL,

    PRIMARY KEY (`driveId`, `round`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `round_details` ADD CONSTRAINT `round_details_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;
