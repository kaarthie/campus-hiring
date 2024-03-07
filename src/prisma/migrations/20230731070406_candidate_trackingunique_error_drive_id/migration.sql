/*
  Warnings:

  - You are about to drop the `candidate_tracking` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `candidate_tracking` DROP FOREIGN KEY `candidate_tracking_driveId_fkey`;

-- DropForeignKey
ALTER TABLE `candidate_tracking` DROP FOREIGN KEY `candidate_tracking_studentId_fkey`;

-- DropTable
DROP TABLE `candidate_tracking`;
