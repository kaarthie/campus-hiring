/*
  Warnings:

  - Added the required column `id` to the `candidateQuestionSet` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `candidateQuestionSet` ADD COLUMN `id` INTEGER NOT NULL;
