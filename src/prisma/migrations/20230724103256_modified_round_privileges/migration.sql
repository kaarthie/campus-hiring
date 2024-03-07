/*
  Warnings:

  - You are about to drop the column `IsPrev` on the `round_privileges` table. All the data in the column will be lost.
  - You are about to drop the column `SubmitOnAnswered` on the `round_privileges` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `round_privileges` DROP COLUMN `IsPrev`,
    DROP COLUMN `SubmitOnAnswered`;
