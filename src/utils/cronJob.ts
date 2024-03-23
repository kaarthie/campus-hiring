import * as cron from "node-cron";
import * as nodemailer from "nodemailer";
import prisma from "./prisma";

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "karthikeyan.r@codingmart.com",
    pass: "Karthi@09CM",
  },
});

const areDatesSame = (date1: Date, date2: Date) => {
  return (
    date1.getFullYear() === date2.getFullYear() &&
    date1.getMonth() === date2.getMonth() &&
    date1.getDate() === date2.getDate()
  );
};

const sendReminderEmail = async (
  email: any,
  driveDate: any,
  daysBefore: number
) => {
  const currentDate = new Date();
  const formattedDate = new Date(driveDate);
  formattedDate.setDate(formattedDate.getDate() - daysBefore);
  console.log(formattedDate, currentDate);
  if (areDatesSame(formattedDate, currentDate)) {
    const mailOptions = {
      from: "karthikey.r@codingmart.com",
      to: email,
      subject: `Reminder: Upcoming Drive on ${driveDate.toDateString()}`,
      text: `This is a reminder for the upcoming drive scheduled on ${driveDate.toDateString()}.`,
    };

    await transporter.sendMail(mailOptions);
    console.log("Successfully Mail sent to ->", email);
  } else {
    console.log("Need to wait to send mail");
  }
};

export const scheduleEmails = () => {
  const Emails: any = [];

  // Schedule emails two days before the drive date
  cron.schedule("0 9 * * *", async () => {
    const teamMembers = await prisma.drive.findMany({
      where: {
        driveStatus: "upcoming",
      },
      include: {
        RecruitmentTeam: true,
      },
    });

    console.log(teamMembers);

    teamMembers.forEach(({ RecruitmentTeam, driveDate }: any) => {
      if (RecruitmentTeam && driveDate) {
        const teamMemberNames = RecruitmentTeam.flatMap(
          (teamData: { teamMembers: any }) => teamData.teamMembers
        );

        teamMemberNames.forEach(async (teamMemberName: any) => {
          const { email }: any = await prisma.recruitmentTeamMembers.findFirst({
            where: {
              name: teamMemberName,
            },
            select: {
              email: true,
            },
          });
          if (email) {
            Emails.push(email);
            await sendReminderEmail(email, driveDate, 2);
          }
        });
      }
    });
  });

  // Schedule emails one day before the drive date
  cron.schedule("0 9 * * *", async () => {
    const teamMembers = await prisma.drive.findMany({
      where: {
        driveStatus: "upcoming",
      },
      include: {
        RecruitmentTeam: true,
      },
    });

    teamMembers.forEach(({ RecruitmentTeam, driveDate }: any) => {
      if (RecruitmentTeam && driveDate) {
        const teamMemberNames = RecruitmentTeam.flatMap(
          (teamData: { teamMembers: string }) =>
            teamData.teamMembers.split(",").map((name) => name.trim())
        );

        teamMemberNames.forEach(async (teamMemberName: any) => {
          const { email }: any = await prisma.recruitmentTeamMembers.findFirst({
            where: {
              name: teamMemberName,
            },
            select: {
              email: true,
            },
          });

          if (email) {
            Emails.push(email);
            await sendReminderEmail(email, driveDate, 1);
          }
        });
      }
    });
  });
};
