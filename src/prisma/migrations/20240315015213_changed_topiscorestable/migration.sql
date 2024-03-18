/*
  Warnings:

  - You are about to drop the column `easy` on the `topicScores` table. All the data in the column will be lost.
  - You are about to drop the column `hard` on the `topicScores` table. All the data in the column will be lost.
  - You are about to drop the column `medium` on the `topicScores` table. All the data in the column will be lost.
  - You are about to drop the column `overall` on the `topicScores` table. All the data in the column will be lost.
  - You are about to drop the column `topic` on the `topicScores` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `topicScores` DROP COLUMN `easy`,
    DROP COLUMN `hard`,
    DROP COLUMN `medium`,
    DROP COLUMN `overall`,
    DROP COLUMN `topic`,
    ADD COLUMN `ds_easy` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `ds_hard` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `ds_medium` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `logical_easy` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `logical_hard` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `logical_medium` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `sql_easy` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `sql_hard` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `sql_medium` INTEGER NOT NULL DEFAULT 0;
