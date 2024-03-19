/*
  Warnings:

  - Added the required column `addedBy` to the `recruitment_team_members` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `candidate_details_college` MODIFY `degree` VARCHAR(191) NULL,
    MODIFY `dateOfBirth` VARCHAR(191) NULL,
    MODIFY `gender` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `recruitment_team_members` ADD COLUMN `addedBy` VARCHAR(191) NOT NULL;
