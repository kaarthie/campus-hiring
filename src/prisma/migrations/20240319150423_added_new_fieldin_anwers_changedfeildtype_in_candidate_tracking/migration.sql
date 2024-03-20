/*
  Warnings:

  - Added the required column `timeStamp` to the `Answers` table without a default value. This is not possible if the table is not empty.
  - Made the column `loginAttempts` on table `candidate_tracking` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE `Answers` ADD COLUMN `timeStamp` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `candidate_tracking` MODIFY `loginAttempts` BOOLEAN NOT NULL DEFAULT false;
