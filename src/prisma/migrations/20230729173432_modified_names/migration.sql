/*
  Warnings:

  - You are about to drop the `Answer` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `campus` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `Answer` DROP FOREIGN KEY `Answer_driveId_fkey`;

-- DropForeignKey
ALTER TABLE `Answer` DROP FOREIGN KEY `Answer_questionId_fkey`;

-- DropForeignKey
ALTER TABLE `drive_details` DROP FOREIGN KEY `drive_details_campusId_fkey`;

-- DropTable
DROP TABLE `Answer`;

-- DropTable
DROP TABLE `campus`;

-- CreateTable
CREATE TABLE `campus_details` (
    `id` INTEGER NOT NULL,
    `campusYear` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `campus_details_id_key`(`id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Answers` (
    `answerId` INTEGER NOT NULL AUTO_INCREMENT,
    `driveId` INTEGER NOT NULL,
    `roundId` INTEGER NOT NULL,
    `questionId` INTEGER NOT NULL,
    `candidateId` INTEGER NOT NULL,
    `answer` VARCHAR(191) NULL,

    UNIQUE INDEX `Answers_answerId_key`(`answerId`),
    PRIMARY KEY (`answerId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `drive_details` ADD CONSTRAINT `drive_details_campusId_fkey` FOREIGN KEY (`campusId`) REFERENCES `campus_details`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Answers` ADD CONSTRAINT `Answers_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Answers` ADD CONSTRAINT `Answers_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Mcqs`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
