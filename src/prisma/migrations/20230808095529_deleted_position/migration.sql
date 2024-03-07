/*
  Warnings:

  - You are about to drop the column `position` on the `recruitment_team` table. All the data in the column will be lost.
  - You are about to drop the column `position` on the `recruitment_team_members` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `recruitment_team` DROP COLUMN `position`;

-- AlterTable
ALTER TABLE `recruitment_team_members` DROP COLUMN `position`;
