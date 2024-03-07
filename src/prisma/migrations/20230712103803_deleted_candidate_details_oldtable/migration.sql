/*
  Warnings:

  - You are about to drop the `candidate_details` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `candidate_details` DROP FOREIGN KEY `candidate_details_driveId_fkey`;

-- DropTable
DROP TABLE `candidate_details`;
