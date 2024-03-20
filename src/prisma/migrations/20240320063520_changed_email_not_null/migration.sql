/*
  Warnings:

  - Made the column `email` on table `candidate_details_college` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE `candidate_details_college` MODIFY `email` VARCHAR(191) NOT NULL;
