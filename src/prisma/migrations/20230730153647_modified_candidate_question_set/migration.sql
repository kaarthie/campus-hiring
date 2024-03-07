/*
  Warnings:

  - The primary key for the `candidateQuestionSet` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `round` on the `candidateQuestionSet` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `candidateQuestionSet` DROP PRIMARY KEY,
    DROP COLUMN `round`,
    MODIFY `id` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`driveId`, `studentId`, `questionId`);
