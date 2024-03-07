/*
  Warnings:

  - You are about to drop the `Mcq` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE `Mcq`;

-- CreateTable
CREATE TABLE `Mcqs` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `question` VARCHAR(191) NULL,
    `difficultLevel` VARCHAR(20) NULL,
    `optionType` VARCHAR(50) NULL DEFAULT 'text',
    `option1` VARCHAR(191) NULL,
    `option2` VARCHAR(191) NULL,
    `option3` VARCHAR(191) NULL,
    `option4` VARCHAR(191) NULL,
    `answer` VARCHAR(4) NULL,
    `topic` VARCHAR(191) NULL,
    `imageLink` VARCHAR(191) NULL,
    `snippet` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
