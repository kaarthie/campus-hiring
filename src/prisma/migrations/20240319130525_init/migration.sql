/*
  Warnings:

  - The primary key for the `college_details` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `college` on the `college_details` table. All the data in the column will be lost.
  - You are about to drop the column `collegeId` on the `college_details` table. All the data in the column will be lost.
  - Added the required column `driveName` to the `college_details` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `college_details` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `college_details` DROP PRIMARY KEY,
    DROP COLUMN `college`,
    DROP COLUMN `collegeId`,
    ADD COLUMN `driveName` VARCHAR(70) NOT NULL,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`id`);
