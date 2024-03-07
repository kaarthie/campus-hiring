/*
  Warnings:

  - Added the required column `position` to the `recruitment_team` table without a default value. This is not possible if the table is not empty.
  - Added the required column `position` to the `recruitment_team_members` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `recruitment_team` ADD COLUMN `position` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `recruitment_team_members` ADD COLUMN `position` VARCHAR(191) NOT NULL;
