import XlsxPopulate from "xlsx-populate";
import path from "path";
import { cloudinary } from "../config/cloudinary";
import { getCandidateDetailsForExcel } from "../api/admin/candidate/candidate.dao";
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


export async function generateExcel2(result, driveId) {
  try {
    const workbook = await XlsxPopulate.fromBlankAsync();
    const sheet = workbook.sheet("Sheet1");
    const Result = await enrichTestReportDetails(result["results"])
    const student_count = result["results"].length
    // Add headers
    const headerWidths = {
      Score: 8,
      // "Student Count": 15,
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
    Result.forEach((candidate) => {
        sheet.cell(currentRow, 1).value(candidate.score);
        sheet.cell(currentRow, 2).value(candidate.candidateId);
        sheet.cell(currentRow, 3).value(candidate.studentId);
        sheet.cell(currentRow, 4).value(candidate.registerNumber);
        sheet.cell(currentRow, 5).value(candidate.name);
        sheet.cell(currentRow, 6).value(candidate.email);
        sheet.cell(currentRow, 7).value(candidate.college);
        sheet.cell(currentRow, 8).value(candidate.branch);
        sheet.cell(currentRow, 9).value(candidate.dateOfBirth);
        sheet.cell(currentRow, 10).value(candidate.gender);
        sheet.cell(currentRow, 11).value(candidate.mobileNumber);
        currentRow++;
      });

    const timestamp = new Date().toISOString();

    pathToExcel = path.join(
      __dirname +
        `${timestamp}-${driveId}.xlsx`
    );

    await workbook.toFileAsync(pathToExcel);

    const resultant = await cloudinary.uploader.upload(pathToExcel, {
      resource_type: "raw",
      public_id: `studentData-drive-${timestamp}-${driveId}`,
      tags: ["excel", "files"],
    });
    console.log(resultant.secure_url);
    return resultant.secure_url;
  } catch (error) {
    console.log(error);
  }
}

async function enrichTestReportDetails(testReportDetails: any[]): Promise<any[]> {
  try {
    const enrichedDetails: any[] = [];

    for (const report of testReportDetails) {
      const { ds, logical, sql, ...reportWithoutUnwantedFields } = report; // Destructure and exclude unwanted fields
      const studentId: number = report.candidateId;
      const candidateDetails = await getCandidateDetailsForExcel(studentId);
      // Merge candidate details into test report without the candidate key
      const enrichedReport = { ...reportWithoutUnwantedFields, ...candidateDetails };
      const {
        candidateId,
        score,
        name,
        email,
        college,
        branch,
        dateOfBirth,
        gender,
        mobileNumber
      } = enrichedReport;
      const newObject = {
        candidateId,
        studentId,
        score,
        registerNumber : enrichedReport?.student?.registerNumber,
        name,
        email,
        college,
        branch,
        dateOfBirth,
        gender,
        mobileNumber
      };
      enrichedDetails.push(newObject);
    }
    console.log(enrichedDetails);
    return enrichedDetails;
  } catch (error) {
    console.error('Error enriching test report details:', error);
    throw error;
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

export function transformDriveResponse(responseBody) {
  const {
    campusId,
    college: { college: collegeName },
    driveDate,
    jobRoles,
    Rounds,
    RoundPrivileges,
    RecruitmentTeam
  } = responseBody;

  const driveData = {
    hiringYear: campusId, // Using campusId as hiringYear
    collegeName,
    driveDate: new Date(driveDate).toISOString().split('T')[0], // Formatting driveDate to 'YYYY-MM-DD'
    jobRoles: jobRoles.map(role => role.jobRole), // Concatenating job roles
    roundName: Rounds[0].roundName, // Assuming there's only one round
    duration: Rounds[0].roundDuration,
    totalQuestions: Rounds[0].roundTotalQuestions,
    skip: RoundPrivileges[0].IsSkipped ? 'Yes' : 'No', // Assuming there's only one round and privilege
    questionTopics: Object.keys(JSON.parse(Rounds[0].roundTestConfig)),
    recruitmentTeam: RecruitmentTeam,
    questionData: JSON.parse(Rounds[0].roundTestConfig)
  };

  return { "driveData": driveData };
}