export interface campusParams {
  campusId: Number;
}

export interface addFeedback {
  driveId: Number;
  labFacilitiesRating: Number;
  hospitalityRating: Number;
  internetBandwidthRating: Number;
  studentAbilityRating: Number;
  feedback: String;
}

export interface driveId {
  id: string; 
}

export interface newDrive {
  hiringYear: String;
  campusId: String[];
  driveDate: String[];
  collegeName: String[];
  totalQuestions: String[];
  recruitmentTeam: number |number[];
  jobRoles: string | string[];
  noOfRounds: String[];
  studentData: String;
  duration: String[];
  difficultyLevel: String[];
  roundName: String[];
  skip: String[];
  questionTopics: String[];
  quiz: String[];
}
export interface startRound {
  driveId: Number;
  status: Boolean;
}
