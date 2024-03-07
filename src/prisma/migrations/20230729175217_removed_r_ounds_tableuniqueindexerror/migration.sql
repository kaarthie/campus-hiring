/*
  Warnings:

  - You are about to drop the `round_details` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `round_details` DROP FOREIGN KEY `round_details_driveId_fkey`;

-- DropTable
DROP TABLE `round_details`;
