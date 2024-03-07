/*
  Warnings:

  - You are about to drop the column `roundName` on the `questionSet` table. All the data in the column will be lost.
  - Added the required column `round` to the `candidateQuestionSet` table without a default value. This is not possible if the table is not empty.
  - Added the required column `round` to the `questionSet` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `candidateQuestionSet` ADD COLUMN `round` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `questionSet` DROP COLUMN `roundName`,
    ADD COLUMN `round` INTEGER NOT NULL;
