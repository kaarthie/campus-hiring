/*
  Warnings:

  - The primary key for the `round_privileges` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - A unique constraint covering the columns `[id]` on the table `round_privileges` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `id` to the `round_privileges` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `round_privileges` DROP PRIMARY KEY,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`id`);

-- CreateIndex
CREATE UNIQUE INDEX `round_privileges_id_key` ON `round_privileges`(`id`);
