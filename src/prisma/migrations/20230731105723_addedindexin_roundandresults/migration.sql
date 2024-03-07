-- CreateIndex
CREATE INDEX `round_details_round_driveId_idx` ON `round_details`(`round`, `driveId`);

-- AddForeignKey
ALTER TABLE `Results` ADD CONSTRAINT `Results_round_driveId_fkey` FOREIGN KEY (`round`, `driveId`) REFERENCES `round_details`(`round`, `driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;
