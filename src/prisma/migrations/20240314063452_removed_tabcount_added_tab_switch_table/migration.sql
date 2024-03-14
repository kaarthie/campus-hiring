/*
  Warnings:

  - You are about to drop the column `tabCount` on the `Answers` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[candidateId]` on the table `Answers` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE `Answers` DROP COLUMN `tabCount`;

-- CreateTable
CREATE TABLE `tabSwitch` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `tabCount` INTEGER NOT NULL DEFAULT 0,
    `candidateId` INTEGER NOT NULL,

    UNIQUE INDEX `tabSwitch_id_key`(`id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE UNIQUE INDEX `Answers_candidateId_key` ON `Answers`(`candidateId`);

-- AddForeignKey
ALTER TABLE `tabSwitch` ADD CONSTRAINT `tabSwitch_candidateId_fkey` FOREIGN KEY (`candidateId`) REFERENCES `Answers`(`candidateId`) ON DELETE RESTRICT ON UPDATE CASCADE;
