import prisma from "../../../utils/prisma";

export async function checkAdmin(email: string) {
  try {
    const admin = await prisma.adminCredentials.findFirst({
      where: {
        email: email,
      },
    });
    if (admin?.email) {
      return admin?.email;
    } else {
      return false;
    }
  } catch (error) {
    console.log("Error in checkAdmin:", error);
  }

}

export async function createAdmin(email: string) {
  try {
    const admin = await prisma.adminCredentials.create({
      data: {
        email: email,
      },
    });
    if (admin?.email) {
      return admin?.email;
    } else {
      return false;
    }
  } catch (error) {
    console.log("Error in createAdmin:", error);
  }
}
