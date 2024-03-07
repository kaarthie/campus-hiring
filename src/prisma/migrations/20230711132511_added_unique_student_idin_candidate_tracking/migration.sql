/*
  Warnings:

  - A unique constraint covering the columns `[studentId]` on the table `candidate_tracking` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX `candidate_tracking_studentId_key` ON `candidate_tracking`(`studentId`);
