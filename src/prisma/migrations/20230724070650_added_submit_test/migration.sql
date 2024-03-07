/*
  Warnings:

  - You are about to drop the column `submitted` on the `Results` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `Results` DROP COLUMN `submitted`;

-- CreateTable
CREATE TABLE `submitTest` (
    `driveId` INTEGER NOT NULL,
    `candidateId` INTEGER NOT NULL,
    `round` INTEGER NOT NULL,

    PRIMARY KEY (`driveId`, `candidateId`, `round`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `submitTest` ADD CONSTRAINT `submitTest_candidateId_fkey` FOREIGN KEY (`candidateId`) REFERENCES `candidate_details_college`(`studentId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `submitTest` ADD CONSTRAINT `submitTest_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;
