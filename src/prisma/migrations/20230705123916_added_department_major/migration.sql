/*
  Warnings:

  - The primary key for the `departments` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `department_id` on the `departments` table. All the data in the column will be lost.
  - The primary key for the `sub_departments` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `department_id` on the `sub_departments` table. All the data in the column will be lost.
  - You are about to drop the column `sub_department` on the `sub_departments` table. All the data in the column will be lost.
  - You are about to drop the column `sub_department_id` on the `sub_departments` table. All the data in the column will be lost.
  - You are about to drop the `Instructions` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[departmentId]` on the table `departments` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[subDepartmentId]` on the table `sub_departments` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `departmentId` to the `departments` table without a default value. This is not possible if the table is not empty.
  - Added the required column `departmentMajorId` to the `departments` table without a default value. This is not possible if the table is not empty.
  - Added the required column `departmentId` to the `sub_departments` table without a default value. This is not possible if the table is not empty.
  - Added the required column `subDepartment` to the `sub_departments` table without a default value. This is not possible if the table is not empty.
  - Added the required column `subDepartmentId` to the `sub_departments` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `sub_departments` DROP FOREIGN KEY `sub_departments_department_id_fkey`;

-- DropIndex
DROP INDEX `departments_department_id_key` ON `departments`;

-- DropIndex
DROP INDEX `sub_departments_sub_department_id_key` ON `sub_departments`;

-- AlterTable
ALTER TABLE `departments` DROP PRIMARY KEY,
    DROP COLUMN `department_id`,
    ADD COLUMN `departmentId` INTEGER NOT NULL AUTO_INCREMENT,
    ADD COLUMN `departmentMajorId` INTEGER NOT NULL,
    ADD PRIMARY KEY (`departmentId`);

-- AlterTable
ALTER TABLE `sub_departments` DROP PRIMARY KEY,
    DROP COLUMN `department_id`,
    DROP COLUMN `sub_department`,
    DROP COLUMN `sub_department_id`,
    ADD COLUMN `departmentId` INTEGER NOT NULL,
    ADD COLUMN `subDepartment` VARCHAR(191) NOT NULL,
    ADD COLUMN `subDepartmentId` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`subDepartmentId`);

-- DropTable
DROP TABLE `Instructions`;

-- CreateTable
CREATE TABLE `instructions` (
    `instruction_id` INTEGER NOT NULL AUTO_INCREMENT,
    `instruction` VARCHAR(191) NULL,

    PRIMARY KEY (`instruction_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `department_major` (
    `departmentMajorId` INTEGER NOT NULL AUTO_INCREMENT,
    `departmentMajor` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`departmentMajorId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE UNIQUE INDEX `departments_departmentId_key` ON `departments`(`departmentId`);

-- CreateIndex
CREATE UNIQUE INDEX `sub_departments_subDepartmentId_key` ON `sub_departments`(`subDepartmentId`);

-- AddForeignKey
ALTER TABLE `departments` ADD CONSTRAINT `departments_departmentMajorId_fkey` FOREIGN KEY (`departmentMajorId`) REFERENCES `department_major`(`departmentMajorId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `sub_departments` ADD CONSTRAINT `sub_departments_departmentId_fkey` FOREIGN KEY (`departmentId`) REFERENCES `departments`(`departmentId`) ON DELETE RESTRICT ON UPDATE CASCADE;
