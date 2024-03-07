/*
  Warnings:

  - You are about to drop the `recruitment_team` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `recruitment_team` DROP FOREIGN KEY `recruitment_team_driveId_fkey`;

-- DropTable
DROP TABLE `recruitment_team`;
