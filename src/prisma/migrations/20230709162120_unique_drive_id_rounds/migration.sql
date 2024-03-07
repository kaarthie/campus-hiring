/*
  Warnings:

  - A unique constraint covering the columns `[driveId]` on the table `Rounds` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX `Rounds_driveId_key` ON `Rounds`(`driveId`);
