/*
  Warnings:

  - You are about to drop the column `feedBack` on the `feedBack` table. All the data in the column will be lost.
  - Added the required column `hospitalityRating` to the `feedBack` table without a default value. This is not possible if the table is not empty.
  - Added the required column `internetBandwidthRating` to the `feedBack` table without a default value. This is not possible if the table is not empty.
  - Added the required column `labFacilityRating` to the `feedBack` table without a default value. This is not possible if the table is not empty.
  - Added the required column `studentAbility` to the `feedBack` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `feedBack` DROP COLUMN `feedBack`,
    ADD COLUMN `hospitalityRating` INTEGER NOT NULL,
    ADD COLUMN `internetBandwidthRating` INTEGER NOT NULL,
    ADD COLUMN `labFacilityRating` INTEGER NOT NULL,
    ADD COLUMN `overallFeedBack` VARCHAR(191) NULL,
    ADD COLUMN `studentAbility` INTEGER NOT NULL;
