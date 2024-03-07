-- CreateTable
CREATE TABLE `departments` (
    `department_id` INTEGER NOT NULL AUTO_INCREMENT,
    `departments` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `departments_department_id_key`(`department_id`),
    PRIMARY KEY (`department_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sub_departments` (
    `sub_department_id` INTEGER NOT NULL AUTO_INCREMENT,
    `department_id` INTEGER NOT NULL,
    `sub_department` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `sub_departments_sub_department_id_key`(`sub_department_id`),
    PRIMARY KEY (`sub_department_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `sub_departments` ADD CONSTRAINT `sub_departments_department_id_fkey` FOREIGN KEY (`department_id`) REFERENCES `departments`(`department_id`) ON DELETE RESTRICT ON UPDATE CASCADE;
