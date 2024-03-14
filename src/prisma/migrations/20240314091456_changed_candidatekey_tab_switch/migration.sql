/*
  Warnings:

  - A unique constraint covering the columns `[candidateId]` on the table `tabSwitch` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX `tabSwitch_candidateId_key` ON `tabSwitch`(`candidateId`);
