/*
  Warnings:

  - A unique constraint covering the columns `[round,driveId]` on the table `round_details` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateTable
CREATE TABLE `questionPdf` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `questionName` VARCHAR(191) NOT NULL,
    `questionUrl` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pdfSlug` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `driveId` INTEGER NOT NULL,
    `pdfQuestionId` INTEGER NOT NULL,
    `slug` VARCHAR(191) NOT NULL,
    `isAccess` BOOLEAN NOT NULL DEFAULT true,

    UNIQUE INDEX `pdfSlug_slug_key`(`slug`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE UNIQUE INDEX `round_details_round_driveId_key` ON `round_details`(`round`, `driveId`);

-- AddForeignKey
ALTER TABLE `pdfSlug` ADD CONSTRAINT `pdfSlug_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `pdfSlug` ADD CONSTRAINT `pdfSlug_pdfQuestionId_fkey` FOREIGN KEY (`pdfQuestionId`) REFERENCES `questionPdf`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
