/*
  Warnings:

  - A unique constraint covering the columns `[campusYear]` on the table `campus_details` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX `campus_details_campusYear_key` ON `campus_details`(`campusYear`);
