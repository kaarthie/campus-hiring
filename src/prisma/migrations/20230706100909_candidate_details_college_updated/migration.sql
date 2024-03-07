/*
  Warnings:

  - You are about to drop the column `candidateDetailsCollegeStudentId` on the `drive_details` table. All the data in the column will be lost.
  - Added the required column `driveId` to the `candidate_details_college` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `drive_details` DROP FOREIGN KEY `drive_details_candidateDetailsCollegeStudentId_fkey`;

-- DropIndex
DROP INDEX `drive_details_driveId_key` ON `drive_details`;

-- AlterTable
ALTER TABLE `candidate_details_college` ADD COLUMN `driveId` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `drive_details` DROP COLUMN `candidateDetailsCollegeStudentId`;

-- AddForeignKey
ALTER TABLE `candidate_details_college` ADD CONSTRAINT `candidate_details_college_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;
