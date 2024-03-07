/*
  Warnings:

  - The primary key for the `questionSet` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
-- AlterTable
ALTER TABLE `questionSet` DROP PRIMARY KEY,
    ADD PRIMARY KEY (`driveId`, `questionId`);
