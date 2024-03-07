/*
  Warnings:

  - You are about to drop the `round_privilege` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `round_privilege` DROP FOREIGN KEY `round_privilege_driveId_fkey`;

-- DropTable
DROP TABLE `round_privilege`;

-- CreateTable
CREATE TABLE `round_privileges` (
    `driveId` INTEGER NOT NULL,
    `IsSkipped` BOOLEAN NULL,
    `IsPrev` BOOLEAN NULL,
    `skipQuestions` BOOLEAN NULL,
    `SubmitOnAnswered` BOOLEAN NULL,

    PRIMARY KEY (`driveId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `round_privileges` ADD CONSTRAINT `round_privileges_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;
