/*
  Warnings:

  - A unique constraint covering the columns `[email,driveId]` on the table `candidate_details` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX `candidate_details_email_driveId_key` ON `candidate_details`(`email`, `driveId`);
