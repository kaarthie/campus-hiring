/*
  Warnings:

  - You are about to drop the column `ds` on the `Results` table. All the data in the column will be lost.
  - You are about to drop the column `logical` on the `Results` table. All the data in the column will be lost.
  - You are about to drop the column `sql` on the `Results` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[candidateId]` on the table `Results` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE `Results` DROP COLUMN `ds`,
    DROP COLUMN `logical`,
    DROP COLUMN `sql`;

-- CreateTable
CREATE TABLE `topicScores` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `candidateId` INTEGER NOT NULL,
    `easy` INTEGER NOT NULL DEFAULT 0,
    `medium` INTEGER NOT NULL DEFAULT 0,
    `hard` INTEGER NOT NULL DEFAULT 0,
    `overall` INTEGER NOT NULL DEFAULT 0,
    `topic` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE UNIQUE INDEX `Results_candidateId_key` ON `Results`(`candidateId`);

-- AddForeignKey
ALTER TABLE `topicScores` ADD CONSTRAINT `topicScores_candidateId_fkey` FOREIGN KEY (`candidateId`) REFERENCES `Results`(`candidateId`) ON DELETE RESTRICT ON UPDATE CASCADE;
