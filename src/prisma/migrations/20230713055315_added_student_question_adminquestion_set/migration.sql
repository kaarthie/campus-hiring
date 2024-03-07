/*
  Warnings:

  - You are about to drop the column `studentId` on the `questionSet` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE `questionSet` DROP FOREIGN KEY `questionSet_studentId_fkey`;

-- AlterTable
ALTER TABLE `questionSet` DROP COLUMN `studentId`,
    ADD COLUMN `roundName` VARCHAR(191) NULL;

-- CreateTable
CREATE TABLE `studentQuestionSet` (
    `driveId` INTEGER NOT NULL,
    `studentId` INTEGER NOT NULL,
    `questionId` INTEGER NOT NULL,

    PRIMARY KEY (`driveId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `studentQuestionSet` ADD CONSTRAINT `studentQuestionSet_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `studentQuestionSet` ADD CONSTRAINT `studentQuestionSet_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Mcqs`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `studentQuestionSet` ADD CONSTRAINT `studentQuestionSet_studentId_fkey` FOREIGN KEY (`studentId`) REFERENCES `candidate_details_college`(`studentId`) ON DELETE RESTRICT ON UPDATE CASCADE;
