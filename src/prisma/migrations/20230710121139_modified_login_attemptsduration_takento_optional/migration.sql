-- AlterTable
ALTER TABLE `candidate_tracking` MODIFY `loginAttempts` INTEGER NULL DEFAULT 0,
    MODIFY `roundOneDurationTaken` INTEGER NULL DEFAULT 0;
