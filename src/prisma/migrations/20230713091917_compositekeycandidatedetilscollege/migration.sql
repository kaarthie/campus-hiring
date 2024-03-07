/*
  Warnings:

  - The primary key for the `candidate_details_college` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `studentQuestionSet` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
-- AlterTable
ALTER TABLE `candidate_details_college` DROP PRIMARY KEY,
    ADD PRIMARY KEY (`driveId`, `studentId`);

-- AlterTable
ALTER TABLE `studentQuestionSet` DROP PRIMARY KEY,
    ADD PRIMARY KEY (`driveId`, `questionId`);
