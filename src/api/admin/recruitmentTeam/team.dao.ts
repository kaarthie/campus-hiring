import { add } from "lodash";
import prisma from "../../../utils/prisma";

export async function getMembers() {
  try {
    const availableMembers = await prisma.recruitmentTeamMembers.findMany();
    return availableMembers;
  } catch (error) {
    console.log("Error in getMembers:", error);
  }
}

export async function addMember(name, email, position, addedBy) {
  try {
    const existingMember = await prisma.recruitmentTeamMembers.findFirst({
      where: {
        email: email,
      },
    });

    if (existingMember) {
      return {
        success: false,
        message: "User with the same email already exists.",
      };
    }

    const result = await prisma.recruitmentTeamMembers.create({
      data: {
        name,
        email,
        position,
        addedBy,
      },
    });

    if (result) {
      return {
        success: true,
        message: "User created successfully.",
      };
    }

    return {
      success: false,
      message: "Failed to create user.",
    };
  } catch (error) {
    console.log("Error in addMember:", error);
  }
}

export async function deleteMember(id) {
  try {
    const result = await prisma.recruitmentTeamMembers.delete({
      where: {
        id: id,
      },
    });
    return true;
  } catch (error) {
    console.log("Error in deleteMember:", error);
  }
}

export async function updateTeamMember(id, name, email, position) {
  try {
    const existingMember = await prisma.recruitmentTeamMembers.findFirst({
      where: {
        id: id,
      },
      select: {
        email: true,
      },
    });
    if (existingMember) {
      //update
      const result = await prisma.recruitmentTeamMembers.update({
        where: {
          id: id,
        },
        data: {
          name: name,
          email: email,
          position: position,
        },
      });

      if (result) {
        return {
          success: true,
          message: "User updated successfully.",
        };
      }
    } else {
      return {
        success: false,
        message: "User does not exist",
      };
    }
  } catch (error) {
    console.log("Error in updateTeamMember:", error);
  }

  // try {
  //     const result = await prisma.recruitmentTeamMembers.update({
  //         where: {
  //             id: id
  //         },
  //         data: {
  //             name: name,
  //             email: email
  //         }
  //     })
  //     return true;
  // }
  // catch (error) {
  //     // return error;
  //     console.log(error);
  // }
}

export async function checkSuperAdminDao(email: string) {
  try {
    const teamMemberData = await prisma.recruitmentTeamMembers.findFirst({
      where: { email },
    });
    return teamMemberData?.position?.toLowerCase() === "superadmin";
  } catch (error) {
    console.log("Error in checkSuperAdminDao() ->", error);
  }
}
