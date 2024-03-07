/*
  Warnings:

  - A unique constraint covering the columns `[id]` on the table `candidateQuestionSet` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `id` to the `candidateQuestionSet` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `candidateQuestionSet` ADD COLUMN `id` INTEGER NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX `candidateQuestionSet_id_key` ON `candidateQuestionSet`(`id`);
