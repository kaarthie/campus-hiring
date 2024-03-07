/*
  Warnings:

  - You are about to drop the `studentQuestionSet` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `studentQuestionSet` DROP FOREIGN KEY `studentQuestionSet_driveId_fkey`;

-- DropForeignKey
ALTER TABLE `studentQuestionSet` DROP FOREIGN KEY `studentQuestionSet_questionId_fkey`;

-- DropForeignKey
ALTER TABLE `studentQuestionSet` DROP FOREIGN KEY `studentQuestionSet_studentId_fkey`;

-- DropTable
DROP TABLE `studentQuestionSet`;

-- CreateTable
CREATE TABLE `candidateQuestionSet` (
    `driveId` INTEGER NOT NULL,
    `studentId` INTEGER NOT NULL,
    `questionId` INTEGER NOT NULL,

    PRIMARY KEY (`driveId`, `questionId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `candidateQuestionSet` ADD CONSTRAINT `candidateQuestionSet_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `candidateQuestionSet` ADD CONSTRAINT `candidateQuestionSet_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Mcqs`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `candidateQuestionSet` ADD CONSTRAINT `candidateQuestionSet_studentId_fkey` FOREIGN KEY (`studentId`) REFERENCES `candidate_details_college`(`studentId`) ON DELETE RESTRICT ON UPDATE CASCADE;
