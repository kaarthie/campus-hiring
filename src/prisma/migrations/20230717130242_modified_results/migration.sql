/*
  Warnings:

  - Made the column `round` on table `Results` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE `Results` ADD COLUMN `roundName` VARCHAR(191) NULL,
    MODIFY `round` INTEGER NOT NULL;
