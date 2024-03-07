/*
  Warnings:

  - You are about to drop the column `DriveDate` on the `drive_details` table. All the data in the column will be lost.
  - Added the required column `driveDate` to the `drive_details` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `campus` MODIFY `campusYear` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `drive_details` DROP COLUMN `DriveDate`,
    ADD COLUMN `driveDate` DATETIME(3) NOT NULL;
