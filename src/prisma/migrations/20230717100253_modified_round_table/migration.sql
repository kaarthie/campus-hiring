/*
  Warnings:

  - You are about to drop the column `round1` on the `round_details` table. All the data in the column will be lost.
  - You are about to drop the column `round1Difficulty` on the `round_details` table. All the data in the column will be lost.
  - You are about to drop the column `round1Duration` on the `round_details` table. All the data in the column will be lost.
  - You are about to drop the column `round1Topics` on the `round_details` table. All the data in the column will be lost.
  - You are about to drop the column `round1TotalQuestions` on the `round_details` table. All the data in the column will be lost.
  - You are about to drop the column `round2` on the `round_details` table. All the data in the column will be lost.
  - You are about to drop the column `round2Duration` on the `round_details` table. All the data in the column will be lost.
  - You are about to drop the column `round2TotalQuestions` on the `round_details` table. All the data in the column will be lost.
  - You are about to drop the column `round3` on the `round_details` table. All the data in the column will be lost.
  - You are about to drop the column `round3Duration` on the `round_details` table. All the data in the column will be lost.
  - You are about to drop the column `round3TotalQuestions` on the `round_details` table. All the data in the column will be lost.
  - You are about to drop the column `round4` on the `round_details` table. All the data in the column will be lost.
  - You are about to drop the column `round4Duration` on the `round_details` table. All the data in the column will be lost.
  - You are about to drop the column `round5` on the `round_details` table. All the data in the column will be lost.
  - You are about to drop the column `round5Duration` on the `round_details` table. All the data in the column will be lost.
  - Added the required column `round` to the `round_details` table without a default value. This is not possible if the table is not empty.
  - Added the required column `roundDuration` to the `round_details` table without a default value. This is not possible if the table is not empty.
  - Added the required column `roundTotalQuestions` to the `round_details` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `round_details` DROP COLUMN `round1`,
    DROP COLUMN `round1Difficulty`,
    DROP COLUMN `round1Duration`,
    DROP COLUMN `round1Topics`,
    DROP COLUMN `round1TotalQuestions`,
    DROP COLUMN `round2`,
    DROP COLUMN `round2Duration`,
    DROP COLUMN `round2TotalQuestions`,
    DROP COLUMN `round3`,
    DROP COLUMN `round3Duration`,
    DROP COLUMN `round3TotalQuestions`,
    DROP COLUMN `round4`,
    DROP COLUMN `round4Duration`,
    DROP COLUMN `round5`,
    DROP COLUMN `round5Duration`,
    ADD COLUMN `round` VARCHAR(191) NOT NULL,
    ADD COLUMN `roundDifficulty` VARCHAR(191) NULL,
    ADD COLUMN `roundDuration` INTEGER NOT NULL,
    ADD COLUMN `roundTotalQuestions` INTEGER NOT NULL;

-- CreateTable
CREATE TABLE `Results` (
    `driveId` INTEGER NOT NULL,
    `studentId` INTEGER NOT NULL,
    `round` VARCHAR(191) NULL,
    `scores` INTEGER NOT NULL,

    PRIMARY KEY (`driveId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Results` ADD CONSTRAINT `Results_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Results` ADD CONSTRAINT `Results_studentId_fkey` FOREIGN KEY (`studentId`) REFERENCES `candidate_details_college`(`studentId`) ON DELETE RESTRICT ON UPDATE CASCADE;
