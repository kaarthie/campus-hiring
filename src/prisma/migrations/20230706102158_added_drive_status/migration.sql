/*
  Warnings:

  - Added the required column `driveStatus` to the `drive_details` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `drive_details` ADD COLUMN `driveStatus` VARCHAR(191) NOT NULL;
