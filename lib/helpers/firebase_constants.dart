class FirebaseOpportunityConstants {

  FirebaseOpportunityConstants({
    this.collection: opportunitiesCollection,
    this.title: opportunityTitle,
    this.organisationName: opportunityOrganisationName,
    this.organisationUID: opportunityOrganisationUID,
    this.venueAddress: opportunityVenueAddress,
    this.venueCountry: opportunityVenueCountry,
    this.participatingCountries: opportunityParticipatingCountries,
    this.type: opportunityType,
    this.startDate: opportunityStartDate,
    this.endDate: opportunityEndDate,
    this.lowAge: opportunityLowAge,
    this.highAge: opportunityHighAge,
    this.topics: opportunityTopics,
    this.applicationDeadline: opportunityApplicationDeadline,
    this.participationCost: opportunityParticipationCost,
    this.reimbursementLimit: opportunityReimbursementLimit,
    this.applicationLink: opportunityApplicationLink,
    this.provideForDisabilities: opportunityProvideForDisabilities,
    this.description: opportunityDescription,
    this.timestamp: opportunityTimestamp,
    this.coverImage: opportunityCoverImage,
    this.postImage: opportunityPostImage,
    this.postVideo: opportunityPostVideo,
  });

  static const opportunitiesCollection = 'opportunities';
  static const opportunityTitle = 'title';
  static const opportunityOrganisationName = 'organisationName';
  static const opportunityOrganisationUID = 'organisationUID';
  static const opportunityVenueAddress = 'venueAddress';
  static const opportunityVenueCountry = 'venueCountry';
  static const opportunityParticipatingCountries = 'participatingCountries';
  static const opportunityType = 'type';
  static const opportunityStartDate = 'startDate';
  static const opportunityEndDate = 'endDate';
  static const opportunityLowAge = 'lowAge';
  static const opportunityHighAge = 'highAge';
  static const opportunityTopics = 'topics';
  static const opportunityApplicationDeadline = 'applicationDeadline';
  static const opportunityParticipationCost = 'participationCost';
  static const opportunityReimbursementLimit = 'reimbursementLimit';
  static const opportunityApplicationLink = 'applicationLink';
  static const opportunityProvideForDisabilities = 'provideForDisabilities';
  static const opportunityDescription = 'description';
  static const opportunityTimestamp = 'timestamp';
  static const opportunityCoverImage = 'coverImage';
  static const opportunityPostImage = 'postImage';
  static const opportunityPostVideo = 'postVideo';

  final String collection;
  final String title;
  final String organisationName;
  final String organisationUID;
  final String venueAddress;
  final String venueCountry;
  final String participatingCountries;
  final String type;
  final String startDate;
  final String endDate;
  final String lowAge;
  final String highAge;
  final String topics;
  final String applicationDeadline;
  final String participationCost;
  final String reimbursementLimit;
  final String applicationLink;
  final String provideForDisabilities;
  final String description;
  final String timestamp;
  final String coverImage;
  final String postImage;
  final String postVideo;
}
