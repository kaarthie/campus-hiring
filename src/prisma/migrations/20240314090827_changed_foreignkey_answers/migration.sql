/*
  Warnings:

  - You are about to drop the column `answerId` on the `tabSwitch` table. All the data in the column will be lost.
  - Added the required column `candidateId` to the `tabSwitch` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `tabSwitch` DROP FOREIGN KEY `tabSwitch_answerId_fkey`;

-- AlterTable
ALTER TABLE `tabSwitch` DROP COLUMN `answerId`,
    ADD COLUMN `candidateId` INTEGER NOT NULL;
