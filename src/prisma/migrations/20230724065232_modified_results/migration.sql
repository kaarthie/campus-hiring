/*
  Warnings:

  - Added the required column `submitted` to the `Results` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `Results` ADD COLUMN `submitted` BOOLEAN NOT NULL;
