/*
  Warnings:

  - You are about to drop the `adminCredentials` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE `adminCredentials`;

-- CreateTable
CREATE TABLE `admin_details` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
