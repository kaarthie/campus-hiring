-- CreateTable
CREATE TABLE `Answer` (
    `driveId` INTEGER NOT NULL,
    `questionId` INTEGER NOT NULL,
    `candidateId` INTEGER NOT NULL,
    `answer` VARCHAR(191) NULL,
    `answerId` INTEGER NOT NULL AUTO_INCREMENT,

    UNIQUE INDEX `Answer_answerId_key`(`answerId` ASC),
    INDEX `Answer_driveId_fkey`(`driveId` ASC),
    INDEX `Answer_questionId_fkey`(`questionId` ASC),
    PRIMARY KEY (`answerId` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Mcqs` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `question` VARCHAR(1024) NULL DEFAULT 'text',
    `difficultLevel` VARCHAR(20) NULL,
    `optionType` VARCHAR(50) NULL DEFAULT 'text',
    `option1` VARCHAR(1024) NOT NULL,
    `option2` VARCHAR(1024) NOT NULL,
    `option3` VARCHAR(1024) NOT NULL,
    `option4` VARCHAR(1024) NOT NULL,
    `answer` VARCHAR(60) NOT NULL,
    `topic` VARCHAR(200) NULL,
    `imageLink` VARCHAR(1024) NULL,
    `snippet` VARCHAR(1024) NULL,

    PRIMARY KEY (`id` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `campus` (
    `id` INTEGER NOT NULL,
    `campusYear` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `candidate_details` (
    `userId` INTEGER NOT NULL AUTO_INCREMENT,
    `driveId` INTEGER NOT NULL,
    `candidateName` VARCHAR(191) NOT NULL,
    `mobileNumber` VARCHAR(30) NOT NULL,
    `registerNumber` VARCHAR(30) NOT NULL,
    `email` VARCHAR(30) NOT NULL,
    `college` VARCHAR(70) NOT NULL,
    `department` VARCHAR(40) NOT NULL,

    INDEX `candidate_details_driveId_fkey`(`driveId` ASC),
    PRIMARY KEY (`userId` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `candidate_details_college` (
    `studentId` INTEGER NOT NULL AUTO_INCREMENT,
    `registerNumber` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `college` VARCHAR(191) NOT NULL,
    `degree` VARCHAR(191) NOT NULL,
    `branch` VARCHAR(191) NOT NULL,
    `dateOfBirth` VARCHAR(191) NOT NULL,
    `gender` VARCHAR(191) NOT NULL,
    `tenthPercentage` INTEGER NOT NULL,
    `tenthYOP` INTEGER NOT NULL,
    `twelthPercentage` INTEGER NULL,
    `twelthYOP` INTEGER NULL,
    `diplomaPercentage` INTEGER NULL,
    `diplomaYOP` INTEGER NULL,
    `UG_CGPA` INTEGER NULL,
    `UG_YOP` INTEGER NULL,
    `PG_CGPA` INTEGER NULL,
    `PG_YOP` INTEGER NULL,
    `arrearStatus` VARCHAR(191) NULL,
    `arrearCount` INTEGER NULL,
    `mobileNumber` VARCHAR(191) NULL,
    `email` VARCHAR(191) NULL,
    `address` VARCHAR(191) NULL,
    `driveId` INTEGER NOT NULL,

    INDEX `candidate_details_college_driveId_fkey`(`driveId` ASC),
    UNIQUE INDEX `candidate_details_college_studentId_key`(`studentId` ASC),
    PRIMARY KEY (`studentId` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `candidate_tracking` (
    `driveId` INTEGER NOT NULL,
    `studentId` INTEGER NOT NULL,
    `startTime` VARCHAR(191) NOT NULL,
    `loginAttempts` INTEGER NULL DEFAULT 0,
    `roundOneDurationTaken` INTEGER NULL DEFAULT 0,
    `roundtwoDurationTaken` INTEGER NULL DEFAULT 0,

    INDEX `candidate_tracking_studentId_fkey`(`studentId` ASC),
    PRIMARY KEY (`driveId` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `college_details` (
    `driveId` INTEGER NOT NULL,
    `college` VARCHAR(70) NOT NULL,
    `collegeId` INTEGER NOT NULL AUTO_INCREMENT,

    UNIQUE INDEX `college_details_driveId_key`(`driveId` ASC),
    PRIMARY KEY (`collegeId` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `department_major` (
    `departmentMajorId` INTEGER NOT NULL AUTO_INCREMENT,
    `departmentMajor` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`departmentMajorId` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `departments` (
    `departments` VARCHAR(191) NOT NULL,
    `departmentId` INTEGER NOT NULL AUTO_INCREMENT,
    `departmentMajorId` INTEGER NOT NULL,

    UNIQUE INDEX `departments_departmentId_key`(`departmentId` ASC),
    INDEX `departments_departmentMajorId_fkey`(`departmentMajorId` ASC),
    PRIMARY KEY (`departmentId` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `drive_details` (
    `campusId` INTEGER NOT NULL,
    `driveId` INTEGER NOT NULL AUTO_INCREMENT,
    `driveDate` DATETIME(3) NOT NULL,
    `answerAnswerId` INTEGER NULL,
    `driveStatus` VARCHAR(191) NOT NULL,

    INDEX `drive_details_campusId_fkey`(`campusId` ASC),
    PRIMARY KEY (`driveId` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `instructions` (
    `instruction` VARCHAR(191) NULL,
    `instructionId` INTEGER NOT NULL AUTO_INCREMENT,

    PRIMARY KEY (`instructionId` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `recruitment_team` (
    `driveId` INTEGER NOT NULL,
    `teamMembers` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `recruitment_team_driveId_key`(`driveId` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `round_details` (
    `driveId` INTEGER NOT NULL,
    `round1` VARCHAR(191) NOT NULL,
    `round1Duration` INTEGER NOT NULL,
    `round1TotalQuestions` INTEGER NOT NULL,
    `round2` VARCHAR(191) NULL,
    `round2Duration` INTEGER NULL,
    `round2TotalQuestions` INTEGER NULL,
    `round3` VARCHAR(191) NULL,
    `round3Duration` INTEGER NULL,
    `round3TotalQuestions` INTEGER NULL,
    `round4` VARCHAR(191) NULL,
    `round4Duration` INTEGER NULL,
    `round5` VARCHAR(191) NULL,
    `round5Duration` INTEGER NULL,

    UNIQUE INDEX `round_details_driveId_key`(`driveId` ASC),
    PRIMARY KEY (`driveId` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `round_privileges` (
    `driveId` INTEGER NOT NULL,
    `IsSkipped` BOOLEAN NULL,
    `IsPrev` BOOLEAN NULL,
    `SubmitOnAnswered` BOOLEAN NULL,

    UNIQUE INDEX `round_privileges_driveId_key`(`driveId` ASC),
    PRIMARY KEY (`driveId` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sub_departments` (
    `departmentId` INTEGER NOT NULL,
    `subDepartment` VARCHAR(191) NOT NULL,
    `subDepartmentId` INTEGER NOT NULL AUTO_INCREMENT,

    INDEX `sub_departments_departmentId_fkey`(`departmentId` ASC),
    UNIQUE INDEX `sub_departments_subDepartmentId_key`(`subDepartmentId` ASC),
    PRIMARY KEY (`subDepartmentId` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Answer` ADD CONSTRAINT `Answer_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Answer` ADD CONSTRAINT `Answer_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Mcqs`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `candidate_details` ADD CONSTRAINT `candidate_details_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `candidate_details_college` ADD CONSTRAINT `candidate_details_college_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `candidate_tracking` ADD CONSTRAINT `candidate_tracking_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `candidate_tracking` ADD CONSTRAINT `candidate_tracking_studentId_fkey` FOREIGN KEY (`studentId`) REFERENCES `candidate_details_college`(`studentId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `college_details` ADD CONSTRAINT `college_details_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `departments` ADD CONSTRAINT `departments_departmentMajorId_fkey` FOREIGN KEY (`departmentMajorId`) REFERENCES `department_major`(`departmentMajorId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `drive_details` ADD CONSTRAINT `drive_details_campusId_fkey` FOREIGN KEY (`campusId`) REFERENCES `campus`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `recruitment_team` ADD CONSTRAINT `recruitment_team_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `round_details` ADD CONSTRAINT `round_details_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `round_privileges` ADD CONSTRAINT `round_privileges_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details`(`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `sub_departments` ADD CONSTRAINT `sub_departments_departmentId_fkey` FOREIGN KEY (`departmentId`) REFERENCES `departments`(`departmentId`) ON DELETE RESTRICT ON UPDATE CASCADE;

