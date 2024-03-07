/*
  Warnings:

  - You are about to drop the `round_privileges` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `round_privileges` DROP FOREIGN KEY `round_privileges_driveId_fkey`;

-- DropTable
DROP TABLE `round_privileges`;
