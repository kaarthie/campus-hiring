-- CreateTable
CREATE TABLE `round_privileges` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `driveId` INTEGER NOT NULL,
    `IsSkipped` BOOLEAN NULL,
    `round` INTEGER NULL,

    UNIQUE INDEX `round_privileges_id_key`(`id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `round_privileges` ADD CONSTRAINT `round_privileges_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;
