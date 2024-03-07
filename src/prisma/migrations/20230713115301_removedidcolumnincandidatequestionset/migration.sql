/*
  Warnings:

  - You are about to drop the column `id` on the `candidateQuestionSet` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX `candidateQuestionSet_id_key` ON `candidateQuestionSet`;

-- AlterTable
ALTER TABLE `candidateQuestionSet` DROP COLUMN `id`;
