/*
  Warnings:

  - Added the required column `round1` to the `Rounds` table without a default value. This is not possible if the table is not empty.
  - Added the required column `round1Duration` to the `Rounds` table without a default value. This is not possible if the table is not empty.
  - Added the required column `round1TotalQuestions` to the `Rounds` table without a default value. This is not possible if the table is not empty.
  - Added the required column `round2` to the `Rounds` table without a default value. This is not possible if the table is not empty.
  - Added the required column `round2Duration` to the `Rounds` table without a default value. This is not possible if the table is not empty.
  - Added the required column `round2TotalQuestions` to the `Rounds` table without a default value. This is not possible if the table is not empty.
  - Added the required column `round3` to the `Rounds` table without a default value. This is not possible if the table is not empty.
  - Added the required column `round3Duration` to the `Rounds` table without a default value. This is not possible if the table is not empty.
  - Added the required column `round3TotalQuestions` to the `Rounds` table without a default value. This is not possible if the table is not empty.
  - Added the required column `round4` to the `Rounds` table without a default value. This is not possible if the table is not empty.
  - Added the required column `round4Duration` to the `Rounds` table without a default value. This is not possible if the table is not empty.
  - Added the required column `round5` to the `Rounds` table without a default value. This is not possible if the table is not empty.
  - Added the required column `round5Duration` to the `Rounds` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `Rounds` ADD COLUMN `round1` VARCHAR(191) NOT NULL,
    ADD COLUMN `round1Duration` INTEGER NOT NULL,
    ADD COLUMN `round1TotalQuestions` INTEGER NOT NULL,
    ADD COLUMN `round2` VARCHAR(191) NOT NULL,
    ADD COLUMN `round2Duration` INTEGER NOT NULL,
    ADD COLUMN `round2TotalQuestions` INTEGER NOT NULL,
    ADD COLUMN `round3` VARCHAR(191) NOT NULL,
    ADD COLUMN `round3Duration` INTEGER NOT NULL,
    ADD COLUMN `round3TotalQuestions` INTEGER NOT NULL,
    ADD COLUMN `round4` VARCHAR(191) NOT NULL,
    ADD COLUMN `round4Duration` INTEGER NOT NULL,
    ADD COLUMN `round5` VARCHAR(191) NOT NULL,
    ADD COLUMN `round5Duration` INTEGER NOT NULL;
