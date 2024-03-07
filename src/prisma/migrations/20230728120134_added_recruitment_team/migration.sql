-- CreateTable
CREATE TABLE `recruitment_team` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `driveId` INTEGER NOT NULL,
    `teamMembers` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `recruitment_team_id_key`(`id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `recruitment_team` ADD CONSTRAINT `recruitment_team_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;
