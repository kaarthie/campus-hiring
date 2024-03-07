/*
  Warnings:

  - You are about to drop the `department_major` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `departments` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `sub_departments` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `departments` DROP FOREIGN KEY `departments_departmentMajorId_fkey`;

-- DropForeignKey
ALTER TABLE `sub_departments` DROP FOREIGN KEY `sub_departments_departmentId_fkey`;

-- DropTable
DROP TABLE `department_major`;

-- DropTable
DROP TABLE `departments`;

-- DropTable
DROP TABLE `sub_departments`;
