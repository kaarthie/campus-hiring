-- CreateTable
CREATE TABLE `slugDetails` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `driveId` INTEGER NOT NULL,
    `slug` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `slugDetails_id_key`(`id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `slugDetails` ADD CONSTRAINT `slugDetails_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;
