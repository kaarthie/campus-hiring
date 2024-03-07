/*
  Warnings:

  - The primary key for the `Results` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `roundName` on the `Results` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `Results` DROP PRIMARY KEY,
    DROP COLUMN `roundName`,
    ADD PRIMARY KEY (`driveId`);
