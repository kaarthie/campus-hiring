/*
  Warnings:

  - A unique constraint covering the columns `[driveName]` on the table `college_details` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX `college_details_driveName_key` ON `college_details`(`driveName`);
