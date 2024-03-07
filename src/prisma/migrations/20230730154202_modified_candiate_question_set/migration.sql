/*
  Warnings:

  - The primary key for the `candidateQuestionSet` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
-- AlterTable
ALTER TABLE `candidateQuestionSet` DROP PRIMARY KEY,
    ADD PRIMARY KEY (`driveId`, `studentId`, `questionId`, `id`);
