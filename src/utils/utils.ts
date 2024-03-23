import * as XlsxPopulate from "xlsx-populate";
import * as path from "path";
import { cloudinary } from "../config/cloudinary";
interface Question {
  questionId: number;
  round: number;
}
let pathToExcel;
interface NumberedQuestion {
  [key: number]: Question;
}

export async function shuffle(questionSet: any) {
  // let questionSet = array.questionSet
  await questionSet.sort(() => Math.random() - 0.5);
  // return array
  const numberedObject = questionSet.reduce(
    (obj: any, value: any, index: number) => {
      obj[index + 1] = value;
      return obj;
    },
    {}
  );
  return numberedObject;
}

export async function generateExcel(Result: any, driveId: any) {
  try {
    const workbook = await XlsxPopulate.fromBlankAsync();
    const sheet = workbook.sheet("Sheet1");

    // Add headers
    const headerWidths = {
      Score: 8,
      "Student Count": 15,
      "Candidate Id": 15,
      "Student Id": 10,
      "Register Number": 15,
      Name: 20,
      Email: 40,
      College: 20,
      Branch: 15,
      "Date Of Birth": 15,
      Gender: 12,
      "Mobile Number": 15,
    };

    Object.entries(headerWidths).forEach(([header, width], index) => {
      sheet.cell(1, index + 1).value(header);
      sheet.column(index + 1).width(width);
    });

    // Populate the sheet with data
    let currentRow = 2;
    Result.forEach((entry: any) => {
      entry.candidates.forEach((candidate: any) => {
        sheet.cell(currentRow, 1).value(entry.score);
        sheet.cell(currentRow, 2).value(entry.student_count);
        sheet.cell(currentRow, 3).value(candidate.candidateId);
        sheet.cell(currentRow, 4).value(candidate.studentId);
        sheet.cell(currentRow, 5).value(candidate.registerNumber);
        sheet.cell(currentRow, 6).value(candidate.name);
        sheet.cell(currentRow, 7).value(candidate.email);
        sheet.cell(currentRow, 8).value(candidate.college);
        sheet.cell(currentRow, 9).value(candidate.branch);
        sheet.cell(currentRow, 10).value(candidate.dateOfBirth);
        sheet.cell(currentRow, 11).value(candidate.gender);
        sheet.cell(currentRow, 12).value(candidate.mobileNumber);
        currentRow++;
      });
    });

    const timestamp = new Date().toISOString();

    pathToExcel = path.join(
      __dirname +
        `../../NextRoundStudents/` +
        `studentsData-${timestamp}-${driveId}.xlsx`
    );

    await workbook.toFileAsync(pathToExcel);

    const resultant = await cloudinary.uploader.upload(pathToExcel, {
      resource_type: "raw",
      public_id: `studentData-drive-${timestamp}-${driveId}`,
      tags: ["excel", "files"],
    });

    return resultant.secure_url;
  } catch (error) {
    console.log(error);
  }
}

export async function generateExcel2(Result: any, driveId: any) {
  try {
    const workbook = await XlsxPopulate.fromBlankAsync();
    const sheet = workbook.sheet("Sheet1");

    // Add headers
    const headerWidths = {
      "Roll No": 15,
      Name: 20,
      Email: 40,
      College: 20,
      Branch: 15,
      Gender: 12,
      "Mobile Number": 15,
      Score: 10,
      "Ds score": 10,
      "SQL score": 10,
      "Logical score": 10,
      "Tab Count": 10,
    };

    Object.entries(headerWidths).forEach(([header, width], index) => {
      sheet.cell(1, index + 1).value(header);
      sheet.column(index + 1).width(width);
    });

    // Populate the sheet with data
    let currentRow = 2;
    Result.forEach((entry: any) => {
      sheet.cell(currentRow, 1).value(entry.registerNumber);
      sheet.cell(currentRow, 2).value(entry.name);
      sheet.cell(currentRow, 3).value(entry.email);
      sheet.cell(currentRow, 4).value(entry.college);
      sheet.cell(currentRow, 5).value(entry.branch);
      sheet.cell(currentRow, 6).value(entry.gender);
      sheet.cell(currentRow, 7).value(entry.mobileNumber);
      sheet.cell(currentRow, 8).value(entry.score);
      sheet.cell(currentRow, 9).value(entry.ds);
      sheet.cell(currentRow, 10).value(entry.sql);
      sheet.cell(currentRow, 11).value(entry.logical);
      sheet.cell(currentRow, 12).value(entry?.tabSwitchCount);
      currentRow++;
    });

    const timestamp = new Date().toISOString();

    pathToExcel = path.join(
      __dirname +
        `../../NextRoundStudents/` +
        `studentsData-${timestamp}-${driveId}.xlsx`
    );

    await workbook.toFileAsync(pathToExcel);

    const resultant = await cloudinary.uploader.upload(pathToExcel, {
      resource_type: "raw",
      public_id: `studentData-drive-${timestamp}-${driveId}`,
      tags: ["excel", "files"],
    });

    return resultant.secure_url;
  } catch (error) {
    console.log(error);
  }
}

export function getRandomNumber(range: number): number {
  // specify the range to get numbers within the range
  return Math.floor(Math.random() * range) + 1;
}

export function shuffleQuestionOptions(question: any): any {
  const shuffledOptions = [
    { key: "1", value: question.option1 },
    { key: "2", value: question.option2 },
    { key: "3", value: question.option3 },
    { key: "4", value: question.option4 },
  ];

  for (let i = shuffledOptions.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [shuffledOptions[i], shuffledOptions[j]] = [
      shuffledOptions[j],
      shuffledOptions[i],
    ];
  }

  return shuffledOptions;
}

export function shuffleArray(array: any) {
  for (let i = array.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [array[i], array[j]] = [array[j], array[i]];
  }
}

export async function collectStream(stream: any) {
  try {
    let data = Buffer.alloc(0);
    for await (const chunk of stream) {
      data = Buffer.concat([data, chunk]);
    }
    return data;
  } catch (error) {
    console.log("Error in collectStream: ", error);
    throw error;
  }
}

export function transformDriveResponse(responseBody: any) {
  const {
    campusId,
    college: { driveName },
    driveDate,
    jobRoles,
    Rounds,
    RoundPrivileges,
    RecruitmentTeam,
  } = responseBody;

  return {
    hiringYear: campusId, // Using campusId as hiringYear
    driveName,
    driveDate: new Date(driveDate).toISOString().split("T")[0], // Formatting driveDate to 'YYYY-MM-DD'
    jobRoles: jobRoles.map((role: any) => role.jobRole), // Concatenating job roles
    roundName: Rounds[0].roundName, // Assuming there's only one round
    duration: Rounds[0].roundDuration,
    totalQuestions: Rounds[0].roundTotalQuestions,
    skip: RoundPrivileges[0].IsSkipped ? "Yes" : "No", // Assuming there's only one round and privilege
    questionTopics: Object.keys(JSON.parse(Rounds[0].roundTestConfig)),
    recruitmentTeam: RecruitmentTeam,
    questionData: JSON.parse(Rounds[0].roundTestConfig),
  };
}
