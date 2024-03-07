-- CreateTable
CREATE TABLE `feedBack` (
    `driveId` INTEGER NOT NULL,
    `feedBack` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`driveId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `feedBack` ADD CONSTRAINT `feedBack_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;
