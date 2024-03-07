/*
  Warnings:

  - You are about to drop the column `scores` on the `Results` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `Results` DROP COLUMN `scores`,
    ADD COLUMN `score` INTEGER NOT NULL DEFAULT 0;
