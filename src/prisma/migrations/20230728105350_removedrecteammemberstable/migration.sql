/*
  Warnings:

  - A unique constraint covering the columns `[id]` on the table `recruitment_team` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `id` to the `recruitment_team` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `recruitment_team` ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`id`);

-- CreateTable
CREATE TABLE `recruitment_team_members` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE UNIQUE INDEX `recruitment_team_id_key` ON `recruitment_team`(`id`);
