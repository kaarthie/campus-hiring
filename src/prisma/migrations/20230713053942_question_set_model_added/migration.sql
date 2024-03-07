-- CreateTable
CREATE TABLE `questionSet` (
    `driveId` INTEGER NOT NULL,
    `studentId` INTEGER NOT NULL,
    `questionId` INTEGER NOT NULL,

    PRIMARY KEY (`driveId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `questionSet` ADD CONSTRAINT `questionSet_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `questionSet` ADD CONSTRAINT `questionSet_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Mcqs`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `questionSet` ADD CONSTRAINT `questionSet_studentId_fkey` FOREIGN KEY (`studentId`) REFERENCES `candidate_details_college`(`studentId`) ON DELETE RESTRICT ON UPDATE CASCADE;
