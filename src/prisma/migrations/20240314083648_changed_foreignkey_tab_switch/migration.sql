/*
  Warnings:

  - You are about to drop the column `candidateId` on the `tabSwitch` table. All the data in the column will be lost.
  - Added the required column `answerId` to the `tabSwitch` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `tabSwitch` DROP FOREIGN KEY `tabSwitch_candidateId_fkey`;

-- DropIndex
DROP INDEX `Answers_candidateId_key` ON `Answers`;

-- AlterTable
ALTER TABLE `tabSwitch` DROP COLUMN `candidateId`,
    ADD COLUMN `answerId` INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE `tabSwitch` ADD CONSTRAINT `tabSwitch_answerId_fkey` FOREIGN KEY (`answerId`) REFERENCES `Answers`(`answerId`) ON DELETE RESTRICT ON UPDATE CASCADE;
