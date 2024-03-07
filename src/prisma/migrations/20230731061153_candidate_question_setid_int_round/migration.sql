/*
  Warnings:

  - The primary key for the `candidateQuestionSet` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `candidateQuestionSet` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Int`.
  - Added the required column `round` to the `candidateQuestionSet` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `candidateQuestionSet` DROP PRIMARY KEY,
    ADD COLUMN `round` INTEGER NOT NULL,
    MODIFY `id` INTEGER NOT NULL,
    ADD PRIMARY KEY (`driveId`, `studentId`, `questionId`, `id`, `round`);
