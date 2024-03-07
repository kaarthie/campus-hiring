/*
  Warnings:

  - A unique constraint covering the columns `[driveId]` on the table `college_details` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX `college_details_driveId_key` ON `college_details`(`driveId`);
