-- DropIndex
DROP INDEX `drive_details_answerAnswerId_fkey` ON `drive_details`;

-- AlterTable
ALTER TABLE `Mcqs` MODIFY `question` VARCHAR(191) NULL DEFAULT 'text',
    MODIFY `option1` VARCHAR(1024) NOT NULL,
    MODIFY `option2` VARCHAR(1024) NOT NULL,
    MODIFY `option3` VARCHAR(1024) NOT NULL,
    MODIFY `option4` VARCHAR(1024) NOT NULL,
    MODIFY `topic` VARCHAR(200) NULL,
    MODIFY `imageLink` VARCHAR(1024) NULL,
    MODIFY `snippet` VARCHAR(1024) NULL;

-- AddForeignKey
ALTER TABLE `candidate_tracking` ADD CONSTRAINT `candidate_tracking_studentId_fkey` FOREIGN KEY (`studentId`) REFERENCES `candidate_details_college`(`studentId`) ON DELETE RESTRICT ON UPDATE CASCADE;
