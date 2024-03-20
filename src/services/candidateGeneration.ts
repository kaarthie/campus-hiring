import * as xlsx from "xlsx";
import path from "path";
import prisma from "../utils/prisma";

export const uploadCandidate = async (fileStream,id) => {
  console.log("check up ---->",id)
  try {
    let data: Record<string, string>[] = [];
    // console.log("Creating Candidates");
    const header: string[] = [
      "registerNumber",
      "name",
      "college",
      "degree",
      "branch",
      "dateOfBirth",
      "gender",
      "tenthPercentage",
      "tenthYOP",
      "twelthPercentage",
      "twelthYOP",
      "diplomaPercentage",
      "diplomaYOP",
      "UG_CGPA",
      "UG_YOP",
      "PG_CGPA",
      "PG_YOP",
      "arrearStatus",
      "arrearCount",
      "mobileNumber",
      "email",
      "address",
    ];
    let file = xlsx.read(fileStream, { type: "buffer" });
    const sheets = file.SheetNames;

    for (let i = 0; i < sheets.length; i++) {
      const temp = xlsx.utils.sheet_to_json(file.Sheets[file.SheetNames[i]]);
      temp.forEach(async (res: any) => {
        let obj: Record<string, string> = {};
        header.forEach((h, i) => {
          obj[h] = String(res[h]);
        });
        data.push(obj);
        // const driveId = await prisma.drive.findFirst({
        //   where: {
        //     driveStatus: "upcoming",
        //   },
        // });

        const driveId = id;
        if (driveId) {
          const {
            registerNumber,
            name,
            college,
            degree,
            branch,
            dateOfBirth,
            gender,
            tenthPercentage,
            tenthYOP,
            twelthPercentage,
            twelthYOP,
            diplomaPercentage,
            diplomaYOP,
            UG_CGPA,
            UG_YOP,
            PG_CGPA,
            PG_YOP,
            arrearStatus,
            arrearCount,
            mobileNumber,
            email,
            address,
          } = obj;
          // console.log(
          //   registerNumber,
          //   name,
          //   college,
          //   degree,
          //   branch,
          //   dateOfBirth,
          //   gender,
          //   tenthPercentage,
          //   tenthYOP,
          //   twelthPercentage,
          //   twelthYOP,
          //   diplomaPercentage,
          //   diplomaYOP,
          //   UG_CGPA,
          //   UG_YOP,
          //   PG_CGPA,
          //   PG_YOP,
          //   arrearStatus,
          //   arrearCount,
          //   mobileNumber,
          //   email,
          //   address
          // );
          const response = await prisma.candidateDetailsCollege.create({
            data: {
              driveId: +driveId,
              registerNumber: registerNumber,
              name: name,
              college: college,
              degree: degree,
              branch: branch,
              dateOfBirth: dateOfBirth,
              gender: gender,
              tenthPercentage: parseInt(tenthPercentage as string),
              tenthYOP: parseInt(tenthYOP as string),
              twelthPercentage: isNaN(parseInt(twelthPercentage as string))
                ? null
                : parseInt(twelthPercentage as string),
              twelthYOP: isNaN(parseInt(twelthYOP as string))
                ? null
                : parseInt(twelthYOP as string),
              diplomaPercentage: isNaN(parseInt(diplomaPercentage as string))
                ? null
                : parseInt(diplomaPercentage as string),
              diplomaYOP: isNaN(parseInt(diplomaYOP as string))
                ? null
                : parseInt(diplomaYOP as string),
              UG_CGPA: isNaN(parseInt(UG_CGPA as string))
                ? null
                : parseInt(UG_CGPA as string),
              UG_YOP: isNaN(parseInt(UG_YOP as string))
                ? null
                : parseInt(UG_YOP as string),
              PG_CGPA: isNaN(parseInt(PG_CGPA as string))
                ? null
                : parseInt(PG_CGPA as string),
              PG_YOP: isNaN(parseInt(PG_YOP as string))
                ? null
                : parseInt(PG_YOP as string),
              arrearStatus: arrearStatus ? arrearStatus : null,
              arrearCount: isNaN(parseInt(arrearCount as string))
                ? null
                : parseInt(arrearCount as string),
              mobileNumber: mobileNumber,
              email: email,
              address: address,
            },
          });
          // console.log(response,"pirachanai")
          return response;
        } else {
          console.log("Could not find driveID");
        }
      });
    }
  } catch (error) {
    throw error;
  }
};
