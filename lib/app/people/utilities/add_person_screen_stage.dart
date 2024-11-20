enum AddPersonScreenStage {
  addPersonModeSelection,
  createHousehold,
  searchExistingHousehold,
  registerNewPerson,
  finished
}

extension AddPersonScreenStageExtension on AddPersonScreenStage {
  String get title {
    switch (this) {
      case AddPersonScreenStage.addPersonModeSelection:
        return "Add Person";
      case AddPersonScreenStage.createHousehold:
        return "Create Household";
      case AddPersonScreenStage.searchExistingHousehold:
        return "Search Existing Household";
      case AddPersonScreenStage.registerNewPerson:
        return "Add Person";
      default:
        return "";
    }
  }
}