class FirebaseOpportunityConstants {

  FirebaseOpportunityConstants({
    this.collection: opportunitiesCollection,
    this.title: opportunityTitle,
    this.organisationName: opportunityOrganisationName,
    this.organisationUID: opportunityOrganisationUID,
    this.venueLocation: opportunityVenueLocation,
    this.type: opportunityType,
    this.startDate: opportunityStartDate,
    this.endDate: opportunityEndDate,
    this.lowAge: opportunityLowAge,
    this.highAge: opportunityHighAge,
    this.topic: opportunityTopic,
    this.applicationDeadline: opportunityApplicationDeadline,
    this.participationCost: opportunityParticipationCost,
    this.reimbursementLimit: opportunityReimbursementLimit,
    this.applicationLink: opportunityApplicationLink,
    this.provideForDisabilities: opportunityProvideForDisabilities,
    this.description: opportunityDescription,
  });

  static const opportunitiesCollection = 'opportunities';
  static const opportunityTitle = 'title';
  static const opportunityOrganisationName = 'organisationName';
  static const opportunityOrganisationUID = 'organisationUID';
  static const opportunityVenueLocation = 'venueLocation';
  static const opportunityType = 'type';
  static const opportunityStartDate = 'startDate';
  static const opportunityEndDate = 'endDate';
  static const opportunityLowAge = 'lowAge';
  static const opportunityHighAge = 'highAge';
  static const opportunityTopic = 'topic';
  static const opportunityApplicationDeadline = 'applicationDeadline';
  static const opportunityParticipationCost = 'participationCost';
  static const opportunityReimbursementLimit = 'reimbursementLimit';
  static const opportunityApplicationLink = 'applicationLink';
  static const opportunityProvideForDisabilities = 'provideForDisabilities';
  static const opportunityDescription = 'description';

  final String collection;
  final String title;
  final String organisationName;
  final String organisationUID;
  final String venueLocation;
  final String type;
  final String startDate;
  final String endDate;
  final String lowAge;
  final String highAge;
  final String topic;
  final String applicationDeadline;
  final String participationCost;
  final String reimbursementLimit;
  final String applicationLink;
  final String provideForDisabilities;
  final String description;
}
