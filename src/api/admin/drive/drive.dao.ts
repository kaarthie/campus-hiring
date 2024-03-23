import prisma from "../../../utils/prisma";

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
      (campus: any) => Object.keys(campus.drive).length > 0
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
    throw error;
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
    const driveIds = driveData.map((data: { college: { driveName: any } }) => {
      return data.college?.driveName;
    });
    return driveIds;
  } catch (error) {
    console.log("Error in getDrive() ->", error);
    throw error;
  }
}

export async function drivefeedback(
  labFacilitiesRating: any,
  hospitalityRating: any,
  internetBandwidthRating: any,
  studentAbilityRating: any,
  feedback: any,
  id: any
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
    throw error;
  }
}

export async function deleteFeedback(id: number) {
  try {
    const result = await prisma.feedBack.delete({
      where: {
        driveId: id,
      },
    });
    return true;
  } catch (error) {
    console.log("Error in deletefeedback:", error);
    throw error;
  }
}

export async function createNewDrive(
  campusId: any,
  ConvertedDriveDate: Date,
  driveName: any,
  recruitmentTeam: any,
  job: any,
  duration: any,
  roundName: any,
  skip: any,
  totalQuestions: any,
  questionData: any
) {
  try {
    skip = skip === "No" ? false : true;
    const result = await prisma.$transaction([
      prisma.drive.create({
        data: {
          campusId: Number(campusId),
          driveDate: ConvertedDriveDate,
          driveStatus: "upcoming",
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
            create: job.map((role: any) => ({
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
    throw error;
  }
}

export async function deleteDriveDao(driveId: number) {
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
    throw error;
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
    throw error;
  }
}

export async function updateDriveStatus(driveId: any) {
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
    throw error;
  }
}

export async function updateRoundStatus(
  driveId: Number,
  roundId: number,
  status: string
) {
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
    throw error;
  }
}

export async function updateDriveStatusCompleted(
  driveId: Number,
  roundId: number
) {
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
    throw error;
  }
}

export async function getDriveById(driveId: number) {
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

    let transformedResults: any;
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
    throw error;
  }
}

export async function updateDrive(
  driveId: number,
  campusId: any,
  ConvertedDriveDate: string | number | Date,
  driveName: any,
  recruitmentTeam: any,
  job: {
    split: (arg0: string) => any;
    map: (arg0: (role: any) => { jobRole: any }) => any;
  },
  duration: any,
  roundName: any,
  skip: string | boolean,
  totalQuestions: any,
  questionData: any
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
          create: job.map((role: any) => ({
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
    throw error;
  }
}

export async function getCollegeNameDao(driveName: string) {
  try {
    let collegeNames: any = [];
    if (driveName) {
      const driveData = await prisma.college.findFirst({
        where: { driveName: driveName },
      });
      collegeNames = await prisma.candidateDetailsCollege.groupBy({
        by: ["college"],
        where: {
          driveId: driveData?.driveId,
        },
      });
    }
    return collegeNames;
  } catch (error) {
    console.log("Error in getCollegeNameDao() ->", error);
    throw error;
  }
}
