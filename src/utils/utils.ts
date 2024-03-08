import XlsxPopulate from "xlsx-populate";
import path from "path";
import { cloudinary } from "../config/cloudinary";
interface Question {
  questionId: number;
  round: number;
}
let pathToExcel;
interface NumberedQuestion {
  [key: number]: Question;
}

export async function shuffle(questionSet) {
  // let questionSet = array.questionSet
  await questionSet.sort(() => Math.random() - 0.5);
  // return array
  const numberedObject = questionSet.reduce((obj, value, index) => {
    obj[index + 1] = value;
    return obj;
  }, {});
  return numberedObject;
}
export async function generateExcel(Result, driveId) {
  const workbook = await XlsxPopulate.fromBlankAsync();
    const sheet = workbook.sheet("Sheet1");
    console.log("Hiii");
    // Add headers
    const headers = [
      "score",
      "student_count",
      "candidateId",
      "studentId",
      "registerNumber",
      "name",
      "email",
      "college",
      "branch",
      "dateOfBirth",
      "gender",
      "mobileNumber",
    ];
    headers.forEach((header, index) => {
      sheet.cell(1, index + 1).value(header);
    });

    // Populate the sheet with data
    let currentRow = 2;
    Result.forEach((entry) => {
      entry.candidates.forEach((candidate) => {
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

    pathToExcel = path.join(
      __dirname +
        `../../NextRoundStudents/` +
        `studentsData${-Number(driveId)}.xlsx`
    );
    console.log(pathToExcel + " pathToExcel");
    workbook.toFileAsync(pathToExcel);


  const resultant = await cloudinary.uploader.upload(pathToExcel, {
    resource_type: "raw", // Specify raw file type
    public_id: `studentData-drive-${driveId}`, // Set a unique identifier for the file
    tags: ["excel", "files"], // Assign tags for better organization
  });
  console.log(resultant.secure_url);
  return resultant.secure_url;
  console.log("Excel file saved successfully");

  // .catch((error) => {
  //   console.error("Error:", error);
  // });
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

export async function collectStream(stream) {
  try {
    let data = Buffer.alloc(0);
    for await (const chunk of stream) {
      data = Buffer.concat([data, chunk]);
    }
    return data;
  } catch (error) {
    console.log("Error in collectStream: ",error);
    throw error
  }
}
