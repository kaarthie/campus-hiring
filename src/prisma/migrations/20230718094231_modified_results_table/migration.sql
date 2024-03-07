/*
  Warnings:

  - The primary key for the `Results` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
-- AlterTable
ALTER TABLE `Results` DROP PRIMARY KEY,
    ADD PRIMARY KEY (`driveId`, `candidateId`, `round`);
