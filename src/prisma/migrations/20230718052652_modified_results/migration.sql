/*
  Warnings:

  - The primary key for the `Results` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `studentId` on the `Results` table. All the data in the column will be lost.
  - Added the required column `candidateId` to the `Results` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `Results` DROP FOREIGN KEY `Results_studentId_fkey`;

-- AlterTable
ALTER TABLE `Results` DROP PRIMARY KEY,
    DROP COLUMN `studentId`,
    ADD COLUMN `candidateId` INTEGER NOT NULL,
    ADD PRIMARY KEY (`driveId`, `candidateId`, `round`);

-- AddForeignKey
ALTER TABLE `Results` ADD CONSTRAINT `Results_candidateId_fkey` FOREIGN KEY (`candidateId`) REFERENCES `candidate_details_college`(`studentId`) ON DELETE RESTRICT ON UPDATE CASCADE;
