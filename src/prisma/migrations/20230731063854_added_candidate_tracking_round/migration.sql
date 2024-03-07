/*
  Warnings:

  - Added the required column `round` to the `candidate_tracking` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `candidate_tracking` ADD COLUMN `round` INTEGER NOT NULL;
