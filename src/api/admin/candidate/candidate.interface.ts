export interface ICandidateDetailsCollege {
  registerNumber: string;
  name: string;
  college: string;
  degree: string;
  branch: string;
  dateOfBirth: string;
  gender: string;
  tenthPercentage?: number | null;
  tenthYOP?: number | null;
  twelthPercentage?: number | null;
  twelthYOP?: number | null;
  diplomaPercentage?: number | null;
  diplomaYOP?: number | null;
  UG_CGPA?: number | null;
  UG_YOP?: number | null;
  PG_CGPA?: number | null;
  PG_YOP?: number | null;
  arrearStatus?: string | null;
  arrearCount?: number | null;
  mobileNumber?: string | null;
  email?: string | null;
  address?: string | null;
  driveId: number;
}
