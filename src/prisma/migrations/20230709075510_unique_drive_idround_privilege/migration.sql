/*
  Warnings:

  - A unique constraint covering the columns `[driveId]` on the table `round_privileges` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX `round_privileges_driveId_key` ON `round_privileges`(`driveId`);
