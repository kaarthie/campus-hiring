import { includes, map } from "lodash";
import prisma from "../../../utils/prisma";
import fastifyMulter from "fastify-multer";
import { Prisma } from "@prisma/client";
// import { storage } from "../../../services/multerStorage";

export async function getDriveDetails() {
  try {
    const res = await prisma.campus.findMany({
      include: {
        drive: {
          select: {
            driveId: true,
            driveDate: true,
            driveStatus: true,
            college: {
              select: {
                driveName: true,
              },
            },
            slugDetails: true,
            Rounds: true,
            feedBack: true,
          },
        },
      },
    });
    const filteredCampuses = res.filter(
      (campus) => Object.keys(campus.drive).length > 0
    );
    console.log(filteredCampuses);
    return filteredCampuses;

    // const response = await prisma.drive.findMany({
    //   include: {
    //     campus: true,
    //     Rounds: true,
    //     feedBack: true,
    //     CandidateDetailsCollege: true,
    //   },
    // });
    // return response;
  } catch (error) {
    console.log("Error in getDriveDetails:", error);
  }
}

export async function getDrive() {
  try {
    const driveData = await prisma.drive.findMany({
      where: {
        NOT: { driveStatus: "completed" },
      },
      include: {
        college: {
          select: {
            driveName: true,
          },
        },
      },
    });
    console.log("Drive data --> ", driveData);
    const driveIds = driveData.map((data) => {
      return data.college?.driveName;
    });
    return driveIds;
  } catch (error) {
    console.log("Error in getDrive() ->", error);
  }
}

export async function drivefeedback(
  labFacilitiesRating,
  hospitalityRating,
  internetBandwidthRating,
  studentAbilityRating,
  feedback,
  id
) {
  try {
    const res = await prisma.feedBack.create({
      data: {
        driveId: id,
        labFacilityRating: labFacilitiesRating,
        hospitalityRating: hospitalityRating,
        studentAbility: studentAbilityRating,
        internetBandwidthRating: internetBandwidthRating,
        overallFeedBack: feedback,
      },
    });
    return res;
  } catch (error) {
    console.log("Error in drivefeedback:", error);
  }
}

export async function deleteFeedback(id) {
  try {
    const result = await prisma.feedBack.delete({
      where: {
        driveId: id,
      },
    });
    return true;
  } catch (error) {
    console.log("Error in deletefeedback:", error);
  }
}

export async function createNewDrive(
  campusId,
  ConvertedDriveDate,
  driveName,
  recruitmentTeam,
  job,
  duration,
  roundName,
  skip,
  totalQuestions,
  questionData
) {
  try {
    skip = skip === "No" ? false : true;
    const result = await prisma.$transaction([
      prisma.drive.create({
        data: {
          campusId: Number(campusId),
          driveDate: ConvertedDriveDate,
          driveStatus: "upcoming", //
          college: {
            create: {
              driveName: driveName,
            },
          },
          // RecruitmentTeam: {
          //   create: recruitmentTeam.map((teamMember) =>
          //     // console.log(JSON.stringify(teamMember) + " for " + i),
          //     ({
          //       teamMembers: teamMember.name,
          //       position: teamMember.position,
          //     })
          //   ),
          // },
          jobRoles: {
            create: job.map((role) => ({
              jobRole: role,
            })),
          },
          RoundPrivileges: {
            create: { IsSkipped: skip, round: 1 },
          },
          Rounds: {
            create: {
              round: 1,
              roundName: roundName,
              roundDuration: Number(duration),
              roundTotalQuestions: Number(totalQuestions),
              roundStatus: "notStarted",
              roundTestConfig: questionData,
            },
          },
        },
      }),
    ]);

    let recruitmentMembers = await prisma.recruitmentTeamMembers.findMany({
      where: {
        id: { in: recruitmentTeam },
      },
    });
    console.log("Results  --->>>  ", JSON.stringify(result));
    for (let members of recruitmentMembers) {
      await prisma.recruitmentTeam.create({
        data: {
          teamMembers: members.name,
          position: members.position,
          driveId: result[0].driveId,
        },
      });
    }
    console.log(
      "Recruitment Members  --->>>  ",
      JSON.stringify(recruitmentMembers)
    );
    return { result };
  } catch (error) {
    console.log("Error in createNewDrive:", error);
  }
}

export async function deleteDriveDao(driveId) {
  try {
    const drive = await prisma.drive.findUnique({
      where: {
        driveId: driveId,
      },
      include: {
        Rounds: true,
        RoundPrivileges: true,
        college: true,
        RecruitmentTeam: true,
        jobRoles: true,
      },
    });

    if (!drive) {
      console.error("Drive not found.");
      return;
    }

    // Delete related records first
    await prisma.rounds.deleteMany({
      where: {
        drive: {
          driveId: driveId,
        },
      },
    });

    await prisma.roundPrivileges.deleteMany({
      where: {
        drive: {
          driveId: driveId,
        },
      },
    });

    await prisma.college.delete({
      where: {
        driveId: driveId,
      },
    });

    await prisma.recruitmentTeam.deleteMany({
      where: {
        drive: {
          driveId: driveId,
        },
      },
    });

    await prisma.jobRoles.deleteMany({
      where: {
        drive: {
          driveId: driveId,
        },
      },
    });

    await prisma.questionSet.deleteMany({
      where: {
        drive: {
          driveId: driveId,
        },
      },
    });

    await prisma.drive.delete({
      where: {
        driveId: driveId,
      },
    });

    // console.log('Drive data and related records deleted successfully.');
    return true;
  } catch (error) {
    console.log("Error in deleteDriveDao:", error);
  }
}

export async function campusYears() {
  try {
    const res = await prisma.campus.findMany();
    if (res.length > 0) {
      return res;
    }
    return false;
  } catch (error) {
    console.log("Error in campusYears:", error);
  }
}

export async function updateDriveStatus(driveId) {
  try {
    const res = await prisma.drive.update({
      where: {
        driveId: driveId,
      },
      data: {
        driveStatus: "pending",
      },
    });
    return true;
  } catch (error) {
    console.log("Error in updateDriveStatus:", error);
  }
}

export async function updateRoundStatus(driveId, roundId, status) {
  try {
    const res = await prisma.rounds.update({
      where: {
        driveId_round: {
          driveId: Number(driveId),
          round: roundId,
        },
      },
      data: {
        roundStatus: status,
      },
    });
    return true;
  } catch (error) {
    console.log("Error in updateRoundStatus:", error);
  }
}

export async function updateDriveStatusCompleted(driveId, roundId) {
  try {
    const round = await prisma.rounds.findFirst({
      where: {
        driveId: Number(driveId),
      },
      select: {
        round: true,
      },
      orderBy: {
        round: "desc",
      },
    });
    // Replacing the Pending Drive to Completed by driveId
    if (round?.round == Number(roundId)) {
      const res = await prisma.drive.update({
        where: {
          driveId: Number(driveId),
        },
        data: {
          driveStatus: "completed",
        },
      });
    }
    return true;
  } catch (error) {
    console.log("Error in updateDriveStatusCompleted:", error);
  }
}

export async function getDriveById(driveId) {
  try {
    const drive = await prisma.drive.findUnique({
      where: {
        driveId: driveId,
      },
      include: {
        college: {
          select: {
            driveName: true,
          },
        },
        jobRoles: true,
        RoundPrivileges: true,
        Rounds: true,
        RecruitmentTeam: true,
      },
    });
    console.log("object --> ", drive);
    let resultsFormat = drive?.Rounds[0]?.roundTestConfig
      ? JSON.parse(drive?.Rounds[0]?.roundTestConfig)
      : null;

    let transformedResults;
    if (resultsFormat) {
      transformedResults = {};
      Object.keys(resultsFormat).forEach((topic) => {
        const overall = Object.values(resultsFormat[topic]).reduce(
          (acc: any, val: any) => acc + val,
          0
        );
        transformedResults[`${topic.toUpperCase()} Overall`] = overall;
        transformedResults[`${topic.toUpperCase()} Easy`] =
          resultsFormat[topic].easy || 0;
        transformedResults[`${topic.toUpperCase()} Medium`] =
          resultsFormat[topic].medium || 0;
        transformedResults[`${topic.toUpperCase()} Hard`] =
          resultsFormat[topic].hard || 0;
      });
    }

    return { drive, transformedResults };
  } catch (error) {
    console.log("Error in getDriveById:", error);
  }
}

export async function updateDrive(
  driveId,
  campusId,
  ConvertedDriveDate,
  driveName,
  recruitmentTeam,
  job,
  duration,
  roundName,
  skip,
  totalQuestions,
  questionData
) {
  try {
    // Update the drive
    console.log("total questions -- ", typeof totalQuestions, typeof duration);

    skip = skip === "No" ? false : true;
    job = job.split(",");

    // Update drive
    const updatedDrive = await prisma.drive.update({
      where: { driveId },
      data: {
        campusId: Number(campusId),
        driveDate: new Date(ConvertedDriveDate),
        driveStatus: "upcoming",
        college: {
          update: { driveName: driveName },
        },
        jobRoles: {
          deleteMany: {},
          create: job.map((role) => ({
            jobRole: role,
          })),
        },
        RoundPrivileges: {
          deleteMany: {},
          create: { IsSkipped: skip, round: 1 },
        },
        Rounds: {
          deleteMany: {},
          create: {
            round: 1,
            roundName: roundName,
            roundDuration: Number(duration),
            roundTotalQuestions: Number(totalQuestions),
            roundStatus: "notStarted",
            roundTestConfig: questionData,
          },
        },
      },
    });

    await prisma.recruitmentTeam.deleteMany({
      where: {
        driveId,
      },
    });
    recruitmentTeam = recruitmentTeam.split(",").map(Number);
    // Update or create recruitment team members
    let recruitmentMembers = await prisma.recruitmentTeamMembers.findMany({
      where: {
        id: { in: recruitmentTeam },
      },
    });
    for (let members of recruitmentMembers) {
      await prisma.recruitmentTeam.create({
        data: {
          teamMembers: members.name,
          position: members.position,
          driveId: driveId,
        },
      });
    }
    return updatedDrive;
  } catch (error) {
    console.log("Error in updateDrive:", error);
  }
}

export async function getCollegeNameDao(driveName: string) {
  try {
    const driveData = await prisma.college.findFirst({
      where: { driveName: driveName },
    });

    const collegeNames = await prisma.candidateDetailsCollege.groupBy({
      by: ["college"],
      where: {
        driveId: driveData?.driveId,
      },
    });
    return collegeNames;
  } catch (error) {
    console.log("Error in getCollegeNameDao() ->", error);
  }
}
