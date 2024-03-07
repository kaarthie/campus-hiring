/*
  Warnings:

  - A unique constraint covering the columns `[driveId]` on the table `drive_details` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateTable
CREATE TABLE `college_details` (
    `userId` INTEGER NOT NULL AUTO_INCREMENT,
    `driveId` INTEGER NOT NULL,
    `college` VARCHAR(70) NOT NULL,

    PRIMARY KEY (`userId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Answer` (
    `driveId` INTEGER NOT NULL,
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `questionId` INTEGER NOT NULL,
    `candidateId` INTEGER NOT NULL,
    `answer` VARCHAR(191) NULL,

    UNIQUE INDEX `Answer_driveId_key`(`driveId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `recruitment_team` (
    `driveId` INTEGER NOT NULL,
    `teamMembers` VARCHAR(191) NULL,

    UNIQUE INDEX `recruitment_team_driveId_key`(`driveId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `round_privilege` (
    `driveId` INTEGER NOT NULL,
    `IsSkipped` BOOLEAN NULL,
    `IsPrev` BOOLEAN NULL,
    `skipQuestions` BOOLEAN NULL,
    `SubmitOnAnswered` BOOLEAN NULL,

    UNIQUE INDEX `round_privilege_driveId_key`(`driveId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Instructions` (
    `instruction_id` INTEGER NOT NULL AUTO_INCREMENT,
    `instruction` VARCHAR(191) NULL,

    PRIMARY KEY (`instruction_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Rounds` (
    `driveId` INTEGER NOT NULL,

    PRIMARY KEY (`driveId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE UNIQUE INDEX `drive_details_driveId_key` ON `drive_details`(`driveId`);

-- AddForeignKey
ALTER TABLE `college_details` ADD CONSTRAINT `college_details_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Answer` ADD CONSTRAINT `Answer_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Mcqs`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Answer` ADD CONSTRAINT `Answer_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `recruitment_team` ADD CONSTRAINT `recruitment_team_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `round_privilege` ADD CONSTRAINT `round_privilege_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Rounds` ADD CONSTRAINT `Rounds_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;
