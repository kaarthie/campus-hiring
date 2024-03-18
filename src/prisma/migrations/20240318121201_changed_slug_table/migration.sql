/*
  Warnings:

  - A unique constraint covering the columns `[slug]` on the table `slugDetails` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX `slugDetails_slug_key` ON `slugDetails`(`slug`);
