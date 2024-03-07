/*
  Warnings:

  - The primary key for the `Answer` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `Answer` table. All the data in the column will be lost.
  - The primary key for the `instructions` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `instruction_id` on the `instructions` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[answerId]` on the table `Answer` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `answerId` to the `Answer` table without a default value. This is not possible if the table is not empty.
  - Added the required column `instructionId` to the `instructions` table without a default value. This is not possible if the table is not empty.
  - Made the column `teamMembers` on table `recruitment_team` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE `Answer` DROP FOREIGN KEY `Answer_driveId_fkey`;

-- AlterTable
ALTER TABLE `Answer` DROP PRIMARY KEY,
    DROP COLUMN `id`,
    ADD COLUMN `answerId` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`answerId`);

-- AlterTable
ALTER TABLE `drive_details` ADD COLUMN `answerAnswerId` INTEGER NULL;

-- AlterTable
ALTER TABLE `instructions` DROP PRIMARY KEY,
    DROP COLUMN `instruction_id`,
    ADD COLUMN `instructionId` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`instructionId`);

-- AlterTable
ALTER TABLE `recruitment_team` MODIFY `teamMembers` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`driveId`);

-- AlterTable
ALTER TABLE `round_privilege` ADD PRIMARY KEY (`driveId`);

-- CreateIndex
CREATE UNIQUE INDEX `Answer_answerId_key` ON `Answer`(`answerId`);

-- AddForeignKey
ALTER TABLE `drive_details` ADD CONSTRAINT `drive_details_answerAnswerId_fkey` FOREIGN KEY (`answerAnswerId`) REFERENCES `Answer`(`answerId`) ON DELETE SET NULL ON UPDATE CASCADE;
