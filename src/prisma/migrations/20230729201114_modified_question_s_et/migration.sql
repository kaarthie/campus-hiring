/*
  Warnings:

  - You are about to drop the `candidateQuestionSet` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `questionSet` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `candidateQuestionSet` DROP FOREIGN KEY `candidateQuestionSet_driveId_fkey`;

-- DropForeignKey
ALTER TABLE `candidateQuestionSet` DROP FOREIGN KEY `candidateQuestionSet_questionId_fkey`;

-- DropForeignKey
ALTER TABLE `candidateQuestionSet` DROP FOREIGN KEY `candidateQuestionSet_studentId_fkey`;

-- DropForeignKey
ALTER TABLE `questionSet` DROP FOREIGN KEY `questionSet_driveId_fkey`;

-- DropForeignKey
ALTER TABLE `questionSet` DROP FOREIGN KEY `questionSet_questionId_fkey`;

-- DropTable
DROP TABLE `candidateQuestionSet`;

-- DropTable
DROP TABLE `questionSet`;
