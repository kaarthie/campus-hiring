/*
  Warnings:

  - A unique constraint covering the columns `[questionId]` on the table `questionSet` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX `questionSet_questionId_key` ON `questionSet`(`questionId`);
