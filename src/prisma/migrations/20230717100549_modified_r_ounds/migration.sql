/*
  Warnings:

  - The primary key for the `round_details` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `round` on the `round_details` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Int`.

*/
-- AlterTable
ALTER TABLE `round_details` DROP PRIMARY KEY,
    ADD COLUMN `roundName` VARCHAR(191) NULL,
    ADD COLUMN `roundTopics` VARCHAR(191) NULL,
    MODIFY `round` INTEGER NOT NULL,
    ADD PRIMARY KEY (`driveId`, `round`);
