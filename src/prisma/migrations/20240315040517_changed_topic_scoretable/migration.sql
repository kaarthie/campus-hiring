-- AlterTable
ALTER TABLE `topicScores` ADD COLUMN `ds` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `logical` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `sql` INTEGER NOT NULL DEFAULT 0;
