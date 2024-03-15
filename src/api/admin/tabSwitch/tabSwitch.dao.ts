import prisma from "../../../utils/prisma";

export async function createTabCount(tabCount, candidateId) {
  try {
    console.log(tabCount,"FIRED");
    const tabSwitch = await prisma.tabSwitch.findFirst({
      where: { candidateId: candidateId },
    });
    let response;
    if (tabSwitch) {
      response = await prisma.tabSwitch.update({
        where: { candidateId: candidateId },
        data: { tabCount: { increment: 1 } },
      });
    } else {
      response = await prisma.tabSwitch.create({
        data: {
          tabCount: 1,
          candidateId: candidateId,
        },
      });
    }
    return response;
  } catch (error) {
    console.log("Error in createCandidate:", error);
  }
}
