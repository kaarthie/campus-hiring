/*
  Warnings:

  - The primary key for the `college_details` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `userId` on the `college_details` table. All the data in the column will be lost.
  - Added the required column `collegeId` to the `college_details` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `college_details` DROP PRIMARY KEY,
    DROP COLUMN `userId`,
    ADD COLUMN `collegeId` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`collegeId`);
