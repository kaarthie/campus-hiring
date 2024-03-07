/*
  Warnings:

  - Added the required column `roundId` to the `Answer` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `Answer` ADD COLUMN `roundId` INTEGER NOT NULL;
