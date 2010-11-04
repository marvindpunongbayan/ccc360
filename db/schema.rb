# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101104035846) do

  create_table "answer_sheet_question_sheets", :force => true do |t|
    t.integer  "answer_sheet_id"
    t.integer  "question_sheet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "counties", :force => true do |t|
    t.string "name"
    t.string "state"
  end

  add_index "counties", ["state"], :name => "state"

  create_table "countries", :force => true do |t|
    t.string  "country",  :limit => 100
    t.string  "code",     :limit => 10
    t.boolean "closed",                  :default => false
    t.string  "iso_code"
  end

  create_table "crs_conference", :primary_key => "conferenceID", :force => true do |t|
    t.datetime "createDate"
    t.string   "attributesAsked",          :limit => 30
    t.string   "name",                     :limit => 64
    t.string   "theme",                    :limit => 128
    t.string   "password",                 :limit => 20
    t.string   "staffPassword",            :limit => 20
    t.string   "region",                   :limit => 3
    t.string   "briefDescription",         :limit => 8000
    t.string   "contactName",              :limit => 60
    t.string   "contactEmail",             :limit => 50
    t.string   "contactPhone",             :limit => 24
    t.string   "contactAddress1",          :limit => 35
    t.string   "contactAddress2",          :limit => 35
    t.string   "contactCity",              :limit => 30
    t.string   "contactState",             :limit => 6
    t.string   "contactZip",               :limit => 10
    t.string   "splashPageURL",            :limit => 128
    t.string   "confImageId",              :limit => 64
    t.string   "fontFace",                 :limit => 64
    t.string   "backgroundColor",          :limit => 6
    t.string   "foregroundColor",          :limit => 6
    t.string   "highlightColor",           :limit => 6
    t.string   "confirmationEmail",        :limit => 4000
    t.string   "acceptCreditCards",        :limit => 1
    t.string   "acceptEChecks",            :limit => 1
    t.string   "acceptScholarships",       :limit => 1
    t.string   "authnetPassword",          :limit => 200
    t.datetime "preRegStart"
    t.datetime "preRegEnd"
    t.datetime "defaultDateStaffArrive"
    t.datetime "defaultDateStaffLeave"
    t.datetime "defaultDateGuestArrive"
    t.datetime "defaultDateGuestLeave"
    t.datetime "defaultDateStudentArrive"
    t.datetime "defaultDateStudentLeave"
    t.datetime "masterDefaultDateArrive"
    t.datetime "masterDefaultDateLeave"
    t.string   "ministryType",             :limit => 2
    t.string   "isCloaked",                :limit => 1
    t.float    "onsiteCost"
    t.float    "commuterCost"
    t.float    "preRegDeposit"
    t.float    "discountFullPayment"
    t.float    "discountEarlyReg"
    t.datetime "discountEarlyRegDate"
    t.string   "checkPayableTo",           :limit => 40
    t.string   "merchantAcctNum",          :limit => 64
    t.string   "backgroundColor3",         :limit => 6
    t.string   "backgroundColor2",         :limit => 6
    t.string   "highlightColor2",          :limit => 6
    t.string   "requiredColor",            :limit => 6
    t.string   "acceptVisa",               :limit => 1
    t.string   "acceptMasterCard",         :limit => 1
    t.string   "acceptAmericanExpress",    :limit => 1
    t.string   "acceptDiscover",           :limit => 1
    t.integer  "staffProfileNumber"
    t.integer  "staffProfileReqNumber"
    t.integer  "guestProfileNumber"
    t.integer  "guestProfileReqNumber"
    t.integer  "studentProfileNumber"
    t.integer  "studentProfileReqNumber"
    t.string   "askStudentChildren",       :limit => 1
    t.string   "askStaffChildren",         :limit => 1
    t.string   "askGuestChildren",         :limit => 1
    t.string   "studentLabel",             :limit => 64
    t.string   "staffLabel",               :limit => 64
    t.string   "guestLabel",               :limit => 64
    t.string   "studentDesc"
    t.string   "staffDesc"
    t.string   "guestDesc"
    t.string   "askStudentSpouse",         :limit => 1
    t.string   "askStaffSpouse",           :limit => 1
    t.string   "askGuestSpouse",           :limit => 1
  end

  create_table "crs_registration", :primary_key => "registrationID", :force => true do |t|
    t.datetime "registrationDate"
    t.string   "registrationType",      :limit => 80
    t.string   "preRegistered",         :limit => 1
    t.integer  "newPersonID"
    t.integer  "fk_ConferenceID"
    t.datetime "arriveDate"
    t.datetime "leaveDate"
    t.integer  "additionalRooms"
    t.integer  "spouseComing"
    t.integer  "spouseRegistrationID"
    t.string   "registeredFirst",       :limit => 1
    t.string   "isOnsite",              :limit => 1
    t.integer  "fk_RegistrationTypeID"
    t.integer  "fk_PersonID"
  end

  add_index "crs_registration", ["fk_ConferenceID"], :name => "fk_ConferenceID"
  add_index "crs_registration", ["fk_PersonID"], :name => "fk_PersonID"
  add_index "crs_registration", ["fk_RegistrationTypeID"], :name => "fk_RegistrationTypeID"

  create_table "hr_si_applications", :primary_key => "applicationID", :force => true do |t|
    t.integer  "oldApplicationID"
    t.integer  "locationA"
    t.string   "locationAExplanation",                    :limit => 90
    t.integer  "locationB"
    t.string   "locationBExplanation",                    :limit => 90
    t.integer  "locationC"
    t.string   "locationCExplanation",                    :limit => 90
    t.string   "availableMonth",                          :limit => 2
    t.string   "availableYear",                           :limit => 4
    t.integer  "hasMinistryConflict"
    t.text     "ministryConflictExplanation",             :limit => 2147483647
    t.integer  "hasSpecificLocation"
    t.string   "specificLocationRecruiterName",           :limit => 50
    t.text     "teamMembers",                             :limit => 2147483647
    t.integer  "isDating"
    t.text     "datingLocation",                          :limit => 2147483647
    t.integer  "hasCampusPartnership"
    t.integer  "isDatingStint"
    t.text     "datingStintName",                         :limit => 2147483647
    t.string   "language1",                               :limit => 50
    t.string   "language1YearsStudied",                   :limit => 20
    t.integer  "language1Fluency"
    t.string   "language2",                               :limit => 50
    t.string   "language2YearsStudied",                   :limit => 20
    t.integer  "language2Fluency"
    t.text     "previousMinistryExperience",              :limit => 2147483647
    t.text     "ministryTraining",                        :limit => 2147483647
    t.text     "evangelismAttitude",                      :limit => 2147483647
    t.integer  "isEvangelismTrainable"
    t.text     "participationExplanation",                :limit => 2147483647
    t.integer  "isFamiliarFourSpiritualLaws"
    t.integer  "hasExperienceFourSpiritualLaws"
    t.integer  "confidenceFourSpiritualLaws"
    t.integer  "isFamiliarLifeAtLarge"
    t.integer  "hasExperienceLifeAtLarge"
    t.integer  "confidenceLifeAtLarge"
    t.integer  "isFamiliarPersonalTestimony"
    t.integer  "hasExperiencePersonalTestimony"
    t.integer  "confidencePersonalTestimony"
    t.integer  "isFamiliarExplainingGospel"
    t.integer  "hasExperienceExplainingGospel"
    t.integer  "confidenceExplainingGospel"
    t.integer  "isFamiliarSharingFaith"
    t.integer  "hasExperienceSharingFaith"
    t.integer  "confidenceSharingFaith"
    t.integer  "isFamiliarHolySpiritBooklet"
    t.integer  "hasExperienceHolySpiritBooklet"
    t.integer  "confidenceHolySpiritBooklet"
    t.integer  "isFamiliarFollowUp"
    t.integer  "hasExperienceFollowUp"
    t.integer  "confidenceFollowUp"
    t.integer  "isFamiliarHelpGrowInFaith"
    t.integer  "hasExperienceHelpGrowInFaith"
    t.integer  "confidenceHelpGrowInFaith"
    t.integer  "isFamiliarTrainShareFaith"
    t.integer  "hasExperienceTrainShareFaith"
    t.integer  "confidenceTrainShareFaith"
    t.integer  "isFamiliarOtherReligions"
    t.integer  "hasExperienceOtherReligions"
    t.integer  "confidenceOtherReligions"
    t.text     "leadershipPositions",                     :limit => 2147483647
    t.integer  "hasLedDiscipleshipGroup"
    t.string   "discipleshipGroupSize",                   :limit => 50
    t.text     "leadershipEvaluation",                    :limit => 2147483647
    t.integer  "conversionMonth"
    t.integer  "conversionYear"
    t.string   "memberChurchDenomination",                :limit => 75
    t.string   "memberChurchDuration",                    :limit => 50
    t.string   "attendingChurchDenomination",             :limit => 50
    t.string   "attendingChurchDuration",                 :limit => 50
    t.text     "attendingChurchInvolvement",              :limit => 2147483647
    t.text     "quietTimeQuantity",                       :limit => 2147483647
    t.text     "quietTimeDescription",                    :limit => 2147483647
    t.text     "explanationOfSalvation",                  :limit => 2147483647
    t.text     "explanationOfSpiritFilled",               :limit => 2147483647
    t.integer  "hasInvolvementSpeakingTongues"
    t.text     "differenceIndwellingFilled",              :limit => 2147483647
    t.integer  "hasCrimeConviction"
    t.text     "crimeConvictionExplanation",              :limit => 2147483647
    t.integer  "hasDrugUse"
    t.integer  "isTobaccoUser"
    t.integer  "isWillingChangeHabits"
    t.text     "authorityResponseExplanation",            :limit => 2147483647
    t.text     "alcoholUseFrequency",                     :limit => 2147483647
    t.text     "alcoholUseDecision",                      :limit => 2147483647
    t.integer  "isWillingRefrainAlcohol"
    t.text     "unwillingRefrainAlcoholExplanation",      :limit => 2147483647
    t.text     "drugUseExplanation",                      :limit => 2147483647
    t.text     "tobaccoUseExplanation",                   :limit => 2147483647
    t.integer  "isWillingAbstainTobacco"
    t.integer  "hasRequestedPhoneCall"
    t.string   "contactPhoneNumber",                      :limit => 50
    t.string   "contactBestTime",                         :limit => 50
    t.string   "contactTimeZone",                         :limit => 50
    t.text     "sexualInvolvementExplanation",            :limit => 2147483647
    t.integer  "hasSexualGuidelines"
    t.text     "sexualGuidelineExplanation",              :limit => 2147483647
    t.integer  "isCurrentlyDating"
    t.text     "currentlyDatingLocation",                 :limit => 2147483647
    t.integer  "hasHomosexualInvolvement"
    t.text     "homosexualInvolvementExplanation",        :limit => 2147483647
    t.integer  "hasRecentPornographicInvolvement"
    t.integer  "pornographicInvolvementMonth"
    t.integer  "pornographicInvolvementYear"
    t.text     "pornographicInvolvementExplanation",      :limit => 2147483647
    t.integer  "hasRecentSexualImmorality"
    t.integer  "sexualImmoralityMonth"
    t.integer  "sexualImmoralityYear"
    t.text     "sexualImmoralityExplanation",             :limit => 2147483647
    t.integer  "hasOtherDateSinceImmorality"
    t.text     "singleImmoralityResultsExplanation",      :limit => 2147483647
    t.text     "marriedImmoralityResultsExplanation",     :limit => 2147483647
    t.text     "immoralityLifeChangeExplanation",         :limit => 2147483647
    t.text     "immoralityCurrentStrugglesExplanation",   :limit => 2147483647
    t.text     "additionalMoralComments",                 :limit => 2147483647
    t.integer  "isAwareMustRaiseSupport"
    t.integer  "isInDebt"
    t.string   "debtNature1",                             :limit => 50
    t.string   "debtTotal1",                              :limit => 50
    t.string   "debtMonthlyPayment1",                     :limit => 50
    t.string   "debtNature2",                             :limit => 50
    t.string   "debtTotal2",                              :limit => 50
    t.string   "debtMonthlyPayment2",                     :limit => 50
    t.string   "debtNature3",                             :limit => 50
    t.string   "debtTotal3",                              :limit => 50
    t.string   "debtMonthlyPayment3",                     :limit => 50
    t.integer  "hasOtherFinancialResponsibility"
    t.text     "otherFinancialResponsibilityExplanation", :limit => 2147483647
    t.text     "debtPaymentPlan",                         :limit => 2147483647
    t.text     "debtPaymentTimeframe",                    :limit => 2147483647
    t.text     "developingPartnersExplanation",           :limit => 2147483647
    t.integer  "isWillingDevelopPartners"
    t.text     "unwillingDevelopPartnersExplanation",     :limit => 2147483647
    t.integer  "isCommittedDevelopPartners"
    t.text     "uncommittedDevelopPartnersExplanation",   :limit => 2147483647
    t.text     "personalTestimonyGrowth",                 :limit => 2147483647
    t.text     "internshipParticipationExplanation",      :limit => 2147483647
    t.text     "internshipObjectives",                    :limit => 2147483647
    t.text     "currentMinistryDescription",              :limit => 2147483647
    t.text     "personalStrengthA",                       :limit => 2147483647
    t.text     "personalStrengthB",                       :limit => 2147483647
    t.text     "personalStrengthC",                       :limit => 2147483647
    t.text     "personalDevelopmentA",                    :limit => 2147483647
    t.text     "personalDevelopmentB",                    :limit => 2147483647
    t.text     "personalDevelopmentC",                    :limit => 2147483647
    t.text     "personalDescriptionA",                    :limit => 2147483647
    t.text     "personalDescriptionB",                    :limit => 2147483647
    t.text     "personalDescriptionC",                    :limit => 2147483647
    t.text     "familyRelationshipDescription",           :limit => 2147483647
    t.string   "electronicSignature",                     :limit => 90
    t.string   "ssn",                                     :limit => 50
    t.integer  "fk_ssmUserID"
    t.integer  "fk_personID",                                                                                  :null => false
    t.boolean  "isPaid"
    t.decimal  "appFee",                                                        :precision => 18, :scale => 0
    t.datetime "dateAppLastChanged"
    t.datetime "dateAppStarted"
    t.datetime "dateSubmitted"
    t.boolean  "isSubmitted"
    t.string   "appStatus",                               :limit => 15
    t.integer  "assignedToProject"
    t.decimal  "finalProject",                                                  :precision => 10, :scale => 0
    t.string   "siYear",                                  :limit => 50
    t.datetime "submitDate"
    t.string   "status",                                  :limit => 22
    t.string   "appType",                                 :limit => 64
    t.integer  "apply_id"
  end

  add_index "hr_si_applications", ["apply_id"], :name => "apply_id"
  add_index "hr_si_applications", ["fk_personID"], :name => "fk_PersonID"
  add_index "hr_si_applications", ["locationA"], :name => "locationA"
  add_index "hr_si_applications", ["locationB"], :name => "locationB"
  add_index "hr_si_applications", ["locationC"], :name => "locationC"
  add_index "hr_si_applications", ["oldApplicationID"], :name => "oldApplicationID"
  add_index "hr_si_applications", ["siYear"], :name => "siYear"

  create_table "hr_si_project", :primary_key => "SIProjectID", :force => true do |t|
    t.string   "name"
    t.string   "partnershipRegion",             :limit => 50
    t.string   "history",                       :limit => 8000
    t.string   "city"
    t.string   "country"
    t.string   "details",                       :limit => 8000
    t.string   "status"
    t.string   "destinationGatewayCity"
    t.datetime "departDateFromGateCity"
    t.datetime "arrivalDateAtLocation"
    t.string   "locationGatewayCity"
    t.datetime "departDateFromLocation"
    t.datetime "arrivalDateAtGatewayCity"
    t.integer  "flightBudget"
    t.string   "gatewayCitytoLocationFlightNo"
    t.string   "locationToGatewayCityFlightNo"
    t.string   "inCountryContact"
    t.string   "scholarshipAccountNo"
    t.string   "operatingAccountNo"
    t.string   "AOA"
    t.string   "MPTA"
    t.integer  "staffCost"
    t.integer  "studentCost"
    t.text     "studentCostExplaination"
    t.boolean  "insuranceFormsReceived"
    t.boolean  "CAPSFeePaid"
    t.boolean  "adminFeePaid"
    t.string   "storiesXX"
    t.string   "stats"
    t.boolean  "secure"
    t.boolean  "projEvalCompleted"
    t.integer  "evangelisticExposures"
    t.integer  "receivedChrist"
    t.integer  "jesusFilmExposures"
    t.integer  "jesusFilmReveivedChrist"
    t.integer  "coverageActivitiesExposures"
    t.integer  "coverageActivitiesDecisions"
    t.integer  "holySpiritDecisions"
    t.string   "website"
    t.string   "destinationAddress"
    t.string   "destinationPhone"
    t.string   "siYear"
    t.integer  "fk_isCoord"
    t.integer  "fk_isAPD"
    t.integer  "fk_isPD"
    t.string   "projectType",                   :limit => 1
    t.datetime "studentStartDate"
    t.datetime "studentEndDate"
    t.datetime "staffStartDate"
    t.datetime "staffEndDate"
    t.datetime "leadershipStartDate"
    t.datetime "leadershipEndDate"
    t.datetime "createDate"
    t.binary   "lastChangedDate",               :limit => 8
    t.integer  "lastChangedBy"
    t.string   "displayLocation"
    t.boolean  "partnershipRegionOnly"
    t.integer  "internCost"
    t.boolean  "onHold"
    t.integer  "maxNoStaffPMale"
    t.integer  "maxNoStaffPFemale"
    t.integer  "maxNoStaffPCouples"
    t.integer  "maxNoStaffPFamilies"
    t.integer  "maxNoStaffP"
    t.integer  "maxNoInternAMale"
    t.integer  "maxNoInternAFemale"
    t.integer  "maxNoInternACouples"
    t.integer  "maxNoInternAFamilies"
    t.integer  "maxNoInternA"
    t.integer  "maxNoInternPMale"
    t.integer  "maxNoInternPFemale"
    t.integer  "maxNoInternPCouples"
    t.integer  "maxNoInternPFamilies"
    t.integer  "maxNoInternP"
    t.integer  "maxNoStudentAMale"
    t.integer  "maxNoStudentAFemale"
    t.integer  "maxNoStudentACouples"
    t.integer  "maxNoStudentAFamilies"
    t.integer  "maxNoStudentA"
    t.integer  "maxNoStudentPMale"
    t.integer  "maxNoStudentPFemale"
    t.integer  "maxNoStudentPCouples"
    t.integer  "maxNoStudentPFamilies"
    t.integer  "maxNoStudentP"
  end

  create_table "ministry_activity", :primary_key => "ActivityID", :force => true do |t|
    t.string   "status",                   :limit => 2
    t.datetime "periodBegin"
    t.datetime "periodEnd_deprecated"
    t.string   "strategy",                 :limit => 2
    t.string   "transUsername",            :limit => 50
    t.integer  "fk_targetAreaID"
    t.integer  "fk_teamID"
    t.string   "statusHistory_deprecated", :limit => 2
    t.string   "url"
    t.string   "facebook"
    t.integer  "sent_teamID"
  end

  add_index "ministry_activity", ["fk_targetAreaID"], :name => "index1"
  add_index "ministry_activity", ["fk_teamID"], :name => "index2"
  add_index "ministry_activity", ["periodBegin"], :name => "index3"
  add_index "ministry_activity", ["strategy"], :name => "index5"

  create_table "ministry_locallevel", :primary_key => "teamID", :force => true do |t|
    t.string   "name",                   :limit => 100
    t.string   "lane",                   :limit => 10
    t.string   "note"
    t.string   "region",                 :limit => 2
    t.string   "address1",               :limit => 35
    t.string   "address2",               :limit => 35
    t.string   "city",                   :limit => 30
    t.string   "state",                  :limit => 6
    t.string   "zip",                    :limit => 10
    t.string   "country",                :limit => 64
    t.string   "phone",                  :limit => 24
    t.string   "fax",                    :limit => 24
    t.string   "email",                  :limit => 50
    t.string   "url"
    t.string   "isActive",               :limit => 1
    t.datetime "startdate"
    t.datetime "stopdate"
    t.string   "Fk_OrgRel",              :limit => 64
    t.string   "no",                     :limit => 2
    t.string   "abbrv",                  :limit => 2
    t.string   "hasMultiRegionalAccess"
    t.string   "dept_id"
  end

  create_table "ministry_missional_team_member", :force => true do |t|
    t.integer "personID"
    t.integer "teamID"
    t.boolean "is_people_soft"
    t.boolean "is_leader"
  end

  create_table "ministry_newaddress", :primary_key => "addressID", :force => true do |t|
    t.string   "deprecated_startDate", :limit => 25
    t.string   "deprecated_endDate",   :limit => 25
    t.string   "address1",             :limit => 55
    t.string   "address2",             :limit => 55
    t.string   "address3",             :limit => 55
    t.string   "address4",             :limit => 55
    t.string   "city",                 :limit => 50
    t.string   "state",                :limit => 50
    t.string   "zip",                  :limit => 15
    t.string   "country",              :limit => 64
    t.string   "homePhone",            :limit => 25
    t.string   "workPhone",            :limit => 25
    t.string   "cellPhone",            :limit => 25
    t.string   "fax",                  :limit => 25
    t.string   "email",                :limit => 200
    t.string   "url",                  :limit => 100
    t.string   "contactName",          :limit => 50
    t.string   "contactRelationship",  :limit => 50
    t.string   "addressType",          :limit => 20
    t.datetime "dateCreated"
    t.datetime "dateChanged"
    t.string   "createdBy",            :limit => 50
    t.string   "changedBy",            :limit => 50
    t.integer  "fk_PersonID"
    t.string   "email2",               :limit => 200
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "facebook_link"
    t.string   "myspace_link"
    t.string   "title"
    t.string   "dorm"
    t.string   "room"
    t.string   "preferredPhone",       :limit => 25
    t.string   "phone1_type",                         :default => "cell"
    t.string   "phone2_type",                         :default => "home"
    t.string   "phone3_type",                         :default => "work"
  end

  add_index "ministry_newaddress", ["addressType", "fk_PersonID"], :name => "unique_person_addressType", :unique => true
  add_index "ministry_newaddress", ["addressType"], :name => "index_ministry_newAddress_on_addressType"
  add_index "ministry_newaddress", ["email"], :name => "email"
  add_index "ministry_newaddress", ["fk_PersonID"], :name => "fk_PersonID"

  create_table "ministry_person", :primary_key => "personID", :force => true do |t|
    t.string   "accountNo",                     :limit => 11
    t.string   "lastName",                      :limit => 50
    t.string   "firstName",                     :limit => 50
    t.string   "middleName",                    :limit => 50
    t.string   "preferredName",                 :limit => 50
    t.string   "gender",                        :limit => 1
    t.string   "region",                        :limit => 5
    t.boolean  "workInUS",                                            :default => true,  :null => false
    t.boolean  "usCitizen",                                           :default => true,  :null => false
    t.string   "citizenship",                   :limit => 50
    t.boolean  "isStaff"
    t.string   "title",                         :limit => 5
    t.string   "campus",                        :limit => 128
    t.string   "universityState",               :limit => 5
    t.string   "yearInSchool",                  :limit => 20
    t.string   "major",                         :limit => 70
    t.string   "minor",                         :limit => 70
    t.string   "greekAffiliation",              :limit => 50
    t.string   "maritalStatus",                 :limit => 20
    t.string   "numberChildren",                :limit => 2
    t.boolean  "isChild",                                             :default => false, :null => false
    t.text     "bio",                           :limit => 2147483647
    t.string   "image",                         :limit => 100
    t.string   "occupation",                    :limit => 50
    t.string   "blogfeed",                      :limit => 200
    t.datetime "cruCommonsInvite"
    t.datetime "cruCommonsLastLogin"
    t.datetime "dateCreated"
    t.datetime "dateChanged"
    t.string   "createdBy",                     :limit => 50
    t.string   "changedBy",                     :limit => 50
    t.integer  "fk_ssmUserId"
    t.integer  "fk_StaffSiteProfileID"
    t.integer  "fk_spouseID"
    t.integer  "fk_childOf"
    t.datetime "birth_date"
    t.datetime "date_became_christian"
    t.datetime "graduation_date"
    t.string   "level_of_school"
    t.string   "staff_notes"
    t.string   "donor_number",                  :limit => 11
    t.string   "url",                           :limit => 2000
    t.string   "isSecure",                      :limit => 1
    t.integer  "primary_campus_involvement_id"
    t.integer  "mentor_id"
    t.string   "lastAttended",                  :limit => 20
    t.string   "ministry"
  end

  add_index "ministry_person", ["accountNo"], :name => "accountNo_ministry_Person"
  add_index "ministry_person", ["campus"], :name => "campus"
  add_index "ministry_person", ["firstName"], :name => "firstname_ministry_Person"
  add_index "ministry_person", ["fk_ssmUserId"], :name => "fk_ssmUserId"
  add_index "ministry_person", ["lastName"], :name => "lastname_ministry_Person"
  add_index "ministry_person", ["region"], :name => "region_ministry_Person"

  create_table "ministry_regionalteam", :primary_key => "teamID", :force => true do |t|
    t.string   "name",      :limit => 100
    t.string   "note"
    t.string   "region",    :limit => 2
    t.string   "address1",  :limit => 35
    t.string   "address2",  :limit => 35
    t.string   "city",      :limit => 30
    t.string   "state",     :limit => 6
    t.string   "zip",       :limit => 10
    t.string   "country",   :limit => 64
    t.string   "phone",     :limit => 24
    t.string   "fax",       :limit => 24
    t.string   "email",     :limit => 50
    t.string   "url"
    t.string   "isActive",  :limit => 1
    t.datetime "startdate"
    t.datetime "stopdate"
    t.string   "no",        :limit => 80
    t.string   "abbrv",     :limit => 80
    t.string   "hrd",       :limit => 50
    t.string   "spPhone",   :limit => 24
  end

  create_table "ministry_staff", :force => true do |t|
    t.string   "accountNo",                :limit => 11,                                                  :null => false
    t.string   "firstName",                :limit => 30
    t.string   "middleInitial",            :limit => 1
    t.string   "lastName",                 :limit => 30
    t.string   "isMale",                   :limit => 1
    t.string   "position",                 :limit => 30
    t.string   "countryStatus",            :limit => 10
    t.string   "jobStatus",                :limit => 60
    t.string   "ministry",                 :limit => 35
    t.string   "strategy",                 :limit => 20
    t.string   "isNewStaff",               :limit => 1
    t.string   "primaryEmpLocState",       :limit => 6
    t.string   "primaryEmpLocCountry",     :limit => 64
    t.string   "primaryEmpLocCity",        :limit => 35
    t.string   "primaryEmpLocDesc",        :limit => 128
    t.string   "spouseFirstName",          :limit => 22
    t.string   "spouseMiddleName",         :limit => 15
    t.string   "spouseLastName",           :limit => 30
    t.string   "spouseAccountNo",          :limit => 11
    t.string   "spouseEmail",              :limit => 50
    t.string   "fianceeFirstName",         :limit => 15
    t.string   "fianceeMiddleName",        :limit => 15
    t.string   "fianceeLastName",          :limit => 30
    t.string   "fianceeAccountno",         :limit => 11
    t.string   "isFianceeStaff",           :limit => 1
    t.datetime "fianceeJoinStaffDate"
    t.string   "isFianceeJoiningNS",       :limit => 1
    t.string   "joiningNS",                :limit => 1
    t.string   "homePhone",                :limit => 24
    t.string   "workPhone",                :limit => 24
    t.string   "mobilePhone",              :limit => 24
    t.string   "pager",                    :limit => 24
    t.string   "email",                    :limit => 50
    t.string   "isEmailSecure",            :limit => 1
    t.string   "url"
    t.datetime "newStaffTrainingdate"
    t.string   "fax",                      :limit => 24
    t.string   "note",                     :limit => 2048
    t.string   "region",                   :limit => 10
    t.string   "countryCode",              :limit => 3
    t.string   "ssn",                      :limit => 9
    t.string   "maritalStatus",            :limit => 1
    t.string   "deptId",                   :limit => 10
    t.string   "jobCode",                  :limit => 6
    t.string   "accountCode",              :limit => 25
    t.string   "compFreq",                 :limit => 1
    t.string   "compRate",                 :limit => 20
    t.string   "compChngAmt",              :limit => 21
    t.string   "jobTitle",                 :limit => 80
    t.string   "deptName",                 :limit => 30
    t.string   "coupleTitle",              :limit => 12
    t.string   "otherPhone",               :limit => 24
    t.string   "preferredName",            :limit => 50
    t.string   "namePrefix",               :limit => 4
    t.datetime "origHiredate"
    t.datetime "birthDate"
    t.datetime "marriageDate"
    t.datetime "hireDate"
    t.datetime "rehireDate"
    t.datetime "loaStartDate"
    t.datetime "loaEndDate"
    t.string   "loaReason",                :limit => 80
    t.integer  "severancePayMonthsReq"
    t.datetime "serviceDate"
    t.datetime "lastIncDate"
    t.datetime "jobEntryDate"
    t.datetime "deptEntryDate"
    t.datetime "reportingDate"
    t.string   "employmentType",           :limit => 20
    t.string   "resignationReason",        :limit => 80
    t.datetime "resignationDate"
    t.string   "contributionsToOtherAcct", :limit => 1
    t.string   "contributionsToAcntName",  :limit => 80
    t.string   "contributionsToAcntNo",    :limit => 11
    t.integer  "fk_primaryAddress"
    t.integer  "fk_secondaryAddress"
    t.integer  "fk_teamID"
    t.string   "isSecure",                 :limit => 1
    t.string   "isSupported",              :limit => 1
    t.string   "removedFromPeopleSoft",    :limit => 1,                                  :default => "N"
    t.string   "isNonUSStaff",             :limit => 1
    t.integer  "person_id"
    t.string   "middleName",               :limit => 30
    t.string   "paygroup",                 :limit => 3
    t.string   "idType",                   :limit => 2
    t.string   "statusDescr",              :limit => 30
    t.string   "internationalStatus",      :limit => 3
    t.decimal  "balance",                                  :precision => 9, :scale => 2
    t.string   "cccHrSendingDept",         :limit => 10
    t.string   "cccHrCaringDept",          :limit => 10
    t.string   "cccCaringMinistry",        :limit => 10
    t.string   "assignmentLength",         :limit => 4
  end

  add_index "ministry_staff", ["accountNo"], :name => "accountNo", :unique => true
  add_index "ministry_staff", ["firstName"], :name => "index_ministry_staff_on_firstName"
  add_index "ministry_staff", ["fk_primaryAddress"], :name => "index2"
  add_index "ministry_staff", ["fk_secondaryAddress"], :name => "index3"
  add_index "ministry_staff", ["fk_teamID"], :name => "index1"
  add_index "ministry_staff", ["lastName"], :name => "index4"
  add_index "ministry_staff", ["person_id"], :name => "ministry_staff_person_id_index"
  add_index "ministry_staff", ["region"], :name => "index5"

  create_table "ministry_statistic", :primary_key => "StatisticID", :force => true do |t|
    t.datetime "periodBegin"
    t.datetime "periodEnd"
    t.integer  "exposures"
    t.integer  "exposuresViaMedia"
    t.integer  "evangelisticOneOnOne"
    t.integer  "evangelisticGroup"
    t.integer  "decisions"
    t.integer  "attendedLastConf"
    t.integer  "invldNewBlvrs"
    t.integer  "invldStudents"
    t.integer  "invldFreshmen"
    t.integer  "invldSophomores"
    t.integer  "invldJuniors"
    t.integer  "invldSeniors"
    t.integer  "invldGrads"
    t.integer  "studentLeaders"
    t.integer  "volunteers"
    t.integer  "staff"
    t.integer  "nonStaffStint"
    t.integer  "staffStint"
    t.integer  "fk_Activity"
    t.integer  "multipliers"
    t.integer  "laborersSent"
    t.integer  "decisionsHelpedByMedia"
    t.integer  "decisionsHelpedByOneOnOne"
    t.integer  "decisionsHelpedByGroup"
    t.integer  "decisionsHelpedByOngoingReln"
    t.integer  "ongoingEvangReln"
    t.string   "updated_by"
    t.datetime "updated_at"
    t.string   "peopleGroup"
    t.integer  "holySpiritConversations"
    t.integer  "dollars_raised"
  end

  add_index "ministry_statistic", ["fk_Activity"], :name => "index1"
  add_index "ministry_statistic", ["periodBegin"], :name => "index2"
  add_index "ministry_statistic", ["periodEnd", "fk_Activity", "peopleGroup"], :name => "activityWeekPeopleGroup", :unique => true
  add_index "ministry_statistic", ["periodEnd"], :name => "index3"

  create_table "ministry_strategy", :primary_key => "strategyID", :force => true do |t|
    t.string "name"
    t.string "abreviation"
  end

  create_table "ministry_targetarea", :primary_key => "targetAreaID", :force => true do |t|
    t.string   "name",                   :limit => 100
    t.string   "address1",               :limit => 35
    t.string   "address2",               :limit => 35
    t.string   "city",                   :limit => 30
    t.string   "state",                  :limit => 32
    t.string   "zip",                    :limit => 10
    t.string   "country",                :limit => 64
    t.string   "phone",                  :limit => 24
    t.string   "fax",                    :limit => 24
    t.string   "email",                  :limit => 50
    t.string   "url"
    t.string   "abbrv",                  :limit => 32
    t.string   "fice",                   :limit => 32
    t.string   "mainCampusFice",         :limit => 32
    t.string   "isNoFiceOK",             :limit => 1
    t.string   "note"
    t.string   "altName",                :limit => 100
    t.string   "isSecure",               :limit => 1
    t.string   "isClosed",               :limit => 1
    t.string   "region"
    t.string   "mpta",                   :limit => 30
    t.string   "urlToLogo"
    t.string   "enrollment",             :limit => 10
    t.string   "monthSchoolStarts",      :limit => 10
    t.string   "monthSchoolStops",       :limit => 10
    t.string   "isSemester",             :limit => 1
    t.string   "isApproved",             :limit => 1
    t.string   "aoaPriority",            :limit => 10
    t.string   "aoa",                    :limit => 100
    t.string   "ciaUrl"
    t.string   "infoUrl"
    t.string   "calendar",               :limit => 50
    t.string   "program1",               :limit => 50
    t.string   "program2",               :limit => 50
    t.string   "program3",               :limit => 50
    t.string   "program4",               :limit => 50
    t.string   "program5",               :limit => 50
    t.string   "emphasis",               :limit => 50
    t.string   "sex",                    :limit => 50
    t.string   "institutionType",        :limit => 50
    t.string   "highestOffering",        :limit => 65
    t.string   "affiliation",            :limit => 50
    t.string   "carnegieClassification", :limit => 100
    t.string   "irsStatus",              :limit => 50
    t.integer  "establishedDate"
    t.integer  "tuition"
    t.datetime "modified"
    t.string   "eventType",              :limit => 2
    t.integer  "eventKeyID"
    t.string   "type",                   :limit => 20
    t.string   "county"
  end

  add_index "ministry_targetarea", ["country"], :name => "index4"
  add_index "ministry_targetarea", ["isApproved"], :name => "index2"
  add_index "ministry_targetarea", ["isClosed"], :name => "index7"
  add_index "ministry_targetarea", ["isSecure"], :name => "index5"
  add_index "ministry_targetarea", ["name"], :name => "index1"
  add_index "ministry_targetarea", ["region"], :name => "index6"
  add_index "ministry_targetarea", ["state"], :name => "index3"

  create_table "personal_forms", :force => true do |t|
    t.integer  "person_id"
    t.integer  "questionnaire_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pr_admins", :force => true do |t|
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pr_answer_sheets", :force => true do |t|
    t.integer  "question_sheet_id", :null => false
    t.datetime "created_at",        :null => false
    t.datetime "completed_at"
  end

  create_table "pr_answers", :force => true do |t|
    t.integer  "answer_sheet_id",         :null => false
    t.integer  "question_id",             :null => false
    t.text     "value"
    t.string   "short_value"
    t.integer  "attachment_file_size"
    t.string   "attachment_content_type"
    t.string   "attachment_file_name"
    t.datetime "attachment_updated_at"
  end

  add_index "pr_answers", ["answer_sheet_id"], :name => "index_pr_answers_on_answer_sheet_id"
  add_index "pr_answers", ["question_id"], :name => "index_pr_answers_on_question_id"
  add_index "pr_answers", ["short_value"], :name => "index_pr_answers_on_short_value"

  create_table "pr_conditions", :force => true do |t|
    t.integer "question_sheet_id", :null => false
    t.integer "trigger_id",        :null => false
    t.string  "expression",        :null => false
    t.integer "toggle_page_id",    :null => false
    t.integer "toggle_id"
  end

  create_table "pr_elements", :force => true do |t|
    t.string   "kind",                      :limit => 40, :null => false
    t.string   "style",                     :limit => 40
    t.string   "label"
    t.text     "content"
    t.boolean  "required"
    t.string   "slug",                      :limit => 36
    t.integer  "position"
    t.string   "object_name"
    t.string   "attribute_name"
    t.string   "source"
    t.string   "value_xpath"
    t.string   "text_xpath"
    t.integer  "question_grid_id"
    t.string   "cols"
    t.boolean  "is_confidential"
    t.string   "total_cols"
    t.string   "css_id"
    t.string   "css_class"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "related_question_sheet_id"
    t.integer  "conditional_id"
    t.integer  "max_length"
  end

  add_index "pr_elements", ["position"], :name => "index_pr_elements_on_question_sheet_id_and_position_and_page_id"
  add_index "pr_elements", ["slug"], :name => "index_pr_elements_on_slug"

  create_table "pr_page_elements", :force => true do |t|
    t.integer  "page_id"
    t.integer  "element_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pr_pages", :force => true do |t|
    t.integer "question_sheet_id",                                   :null => false
    t.string  "label",             :limit => 100,                    :null => false
    t.integer "number"
    t.boolean "no_cache",                         :default => false
    t.boolean "hidden",                           :default => false
  end

  add_index "pr_pages", ["question_sheet_id", "number"], :name => "page_number", :unique => true

  create_table "pr_question_sheets", :force => true do |t|
    t.string  "label",    :limit => 60,                    :null => false
    t.boolean "archived",               :default => false
  end

  create_table "pr_references", :force => true do |t|
    t.integer  "question_id"
    t.integer  "answer_sheet_id"
    t.integer  "response_id"
    t.datetime "email_sent_at"
    t.string   "relationship"
    t.string   "title"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "email"
    t.string   "status"
    t.datetime "submitted_at"
    t.string   "access_key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pr_reviewers", :force => true do |t|
    t.integer  "review_id"
    t.integer  "person_id"
    t.datetime "invitation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pr_reviews", :force => true do |t|
    t.integer  "subject_id"
    t.integer  "initiator_id"
    t.string   "status"
    t.integer  "percent"
    t.date     "due"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "purpose"
    t.integer  "question_sheet_id"
  end

  create_table "pr_sessions", :force => true do |t|
    t.text "session_id"
    t.text "data"
  end

  create_table "pr_users", :force => true do |t|
    t.integer  "ssm_id"
    t.datetime "last_login"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profile_pictures", :force => true do |t|
    t.integer "person_id"
    t.integer "parent_id"
    t.integer "size"
    t.integer "height"
    t.integer "width"
    t.string  "content_type"
    t.string  "filename"
    t.string  "thumbnail"
    t.date    "uploaded_date"
  end

  add_index "profile_pictures", ["person_id"], :name => "index_profile_pictures_on_person_id"

  create_table "question_sheet_pr_infos", :force => true do |t|
    t.integer  "question_sheet_id"
    t.boolean  "personal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "school_years", :force => true do |t|
    t.string   "name"
    t.string   "level"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "simplesecuritymanager_user", :primary_key => "userID", :force => true do |t|
    t.string   "globallyUniqueID",          :limit => 80
    t.string   "username",                  :limit => 80,                     :null => false
    t.string   "email_deprecated",          :limit => 64
    t.string   "password",                  :limit => 80
    t.string   "passwordQuestion",          :limit => 200
    t.string   "passwordAnswer",            :limit => 200
    t.datetime "lastFailure"
    t.integer  "lastFailureCnt"
    t.datetime "lastLogin"
    t.datetime "createdOn"
    t.boolean  "emailVerified",                            :default => false, :null => false
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.boolean  "developer"
    t.string   "facebook_hash"
    t.string   "facebook_username"
    t.integer  "fb_user_id",                :limit => 8
  end

  add_index "simplesecuritymanager_user", ["fb_user_id"], :name => "index_simplesecuritymanager_user_on_fb_user_id"
  add_index "simplesecuritymanager_user", ["globallyUniqueID"], :name => "globallyUniqueID", :unique => true
  add_index "simplesecuritymanager_user", ["username"], :name => "CK_simplesecuritymanager_user_username", :unique => true

  create_table "sn_campus_involvements", :force => true do |t|
    t.integer "person_id"
    t.integer "campus_id"
    t.integer "ministry_id"
    t.date    "start_date"
    t.date    "end_date"
    t.integer "added_by_id"
    t.date    "graduation_date"
    t.integer "school_year_id"
    t.string  "major"
    t.string  "minor"
    t.date    "last_history_update_date"
  end

  add_index "sn_campus_involvements", ["campus_id"], :name => "index_sn_campus_involvements_on_campus_id"
  add_index "sn_campus_involvements", ["ministry_id"], :name => "index_sn_campus_involvements_on_ministry_id"
  add_index "sn_campus_involvements", ["person_id"], :name => "index_sn_campus_involvements_on_person_id"

  create_table "sn_campus_ministry_group", :force => true do |t|
    t.integer "group_id"
    t.integer "campus_id"
    t.integer "ministry_id"
  end

  create_table "sn_columns", :force => true do |t|
    t.string   "title"
    t.string   "update_clause"
    t.string   "from_clause"
    t.text     "select_clause"
    t.string   "column_type"
    t.string   "writeable"
    t.string   "join_clause"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source_model"
    t.string   "source_column"
    t.string   "foreign_key"
  end

  create_table "sn_correspondence_types", :force => true do |t|
    t.string  "name"
    t.integer "overdue_lifespan"
    t.integer "expiry_lifespan"
    t.string  "actions_now_task"
    t.string  "actions_overdue_task"
    t.string  "actions_followup_task"
    t.text    "redirect_params"
    t.string  "redirect_target_id_type"
  end

  create_table "sn_correspondences", :force => true do |t|
    t.integer  "correspondence_type_id"
    t.integer  "person_id"
    t.string   "receipt"
    t.string   "state"
    t.date     "visited"
    t.date     "completed"
    t.date     "overdue_at"
    t.date     "expire_at"
    t.text     "token_params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sn_correspondences", ["receipt"], :name => "index_sn_correspondences_on_receipt"

  create_table "sn_custom_attributes", :force => true do |t|
    t.integer "ministry_id"
    t.string  "name"
    t.string  "value_type"
    t.string  "description"
    t.string  "type"
  end

  add_index "sn_custom_attributes", ["ministry_id"], :name => "index_sn_custom_attributes_on_ministry_id"
  add_index "sn_custom_attributes", ["type"], :name => "index_sn_custom_attributes_on_type"

  create_table "sn_custom_values", :force => true do |t|
    t.integer "person_id"
    t.integer "custom_attribute_id"
    t.string  "value"
  end

  add_index "sn_custom_values", ["person_id", "custom_attribute_id"], :name => "index_sn_custom_values_on_person_id_and_custom_attribute_id", :unique => true

  create_table "sn_delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sn_dorms", :force => true do |t|
    t.integer "campus_id"
    t.string  "name"
    t.date    "created_at"
  end

  add_index "sn_dorms", ["campus_id"], :name => "campus_id"

  create_table "sn_email_templates", :force => true do |t|
    t.integer  "correspondence_type_id"
    t.string   "outcome_type"
    t.string   "subject",                :null => false
    t.string   "from",                   :null => false
    t.string   "bcc"
    t.string   "cc"
    t.text     "body",                   :null => false
    t.text     "template"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sn_emails", :force => true do |t|
    t.string   "subject"
    t.text     "body"
    t.text     "people_ids"
    t.text     "missing_address_ids"
    t.integer  "search_id"
    t.integer  "sender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sn_free_times", :force => true do |t|
    t.integer  "start_time"
    t.integer  "end_time"
    t.integer  "day_of_week"
    t.integer  "timetable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "css_class"
    t.decimal  "weight",       :precision => 4, :scale => 2
  end

  create_table "sn_group_involvements", :force => true do |t|
    t.integer  "person_id"
    t.integer  "group_id"
    t.string   "level"
    t.boolean  "requested"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sn_group_involvements", ["person_id", "group_id"], :name => "person_group", :unique => true

  create_table "sn_group_types", :force => true do |t|
    t.integer  "ministry_id"
    t.string   "group_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "mentor_priority"
    t.boolean  "public"
    t.integer  "unsuitability_leader"
    t.integer  "unsuitability_coleader"
    t.integer  "unsuitability_participant"
    t.string   "collection_group_name",     :default => "{{campus}} interested in a {{group_type}}"
    t.boolean  "has_collection_groups",     :default => false
  end

  create_table "sn_groups", :force => true do |t|
    t.string  "name"
    t.string  "address"
    t.string  "address_2"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
    t.string  "country"
    t.string  "email"
    t.string  "url"
    t.integer "dorm_id"
    t.integer "ministry_id"
    t.integer "campus_id"
    t.integer "start_time"
    t.integer "end_time"
    t.integer "day"
    t.integer "group_type_id"
    t.boolean "needs_approval"
    t.integer "semester_id"
  end

  add_index "sn_groups", ["campus_id"], :name => "index_sn_groups_on_campus_id"
  add_index "sn_groups", ["dorm_id"], :name => "index_sn_groups_on_dorm_id"
  add_index "sn_groups", ["ministry_id"], :name => "index_sn_groups_on_ministry_id"
  add_index "sn_groups", ["semester_id"], :name => "index_uscm.sn_groups_on_semester_id"

  create_table "sn_imports", :force => true do |t|
    t.integer  "person_id"
    t.integer  "parent_id"
    t.integer  "size"
    t.integer  "height"
    t.integer  "width"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sn_involvement_histories", :force => true do |t|
    t.string   "type"
    t.integer  "person_id"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "campus_id"
    t.integer  "school_year_id"
    t.integer  "ministry_id"
    t.integer  "ministry_role_id"
    t.integer  "campus_involvement_id"
    t.integer  "ministry_involvement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sn_ministries", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.string   "phone"
    t.string   "fax"
    t.string   "email"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "lane"
    t.string   "note"
    t.string   "address2"
    t.string   "isActive"
    t.string   "hasMultiRegionalAccess"
    t.string   "dept_id"
    t.string   "status"
    t.integer  "strategy_id"
    t.integer  "legacy_regionalteam_id"
    t.integer  "legacy_locallevel_id"
    t.integer  "legacy_activity_id"
    t.string   "type"
    t.integer  "lft"
    t.integer  "rgt"
  end

  add_index "sn_ministries", ["lft"], :name => "index_uscm.sn_ministries_on_lft"
  add_index "sn_ministries", ["parent_id"], :name => "index_sn_ministries_on_parent_id"
  add_index "sn_ministries", ["parent_id"], :name => "index_uscm.sn_ministries_on_parent_id"
  add_index "sn_ministries", ["rgt"], :name => "index_uscm.sn_ministries_on_rgt"

  create_table "sn_ministry_campuses", :force => true do |t|
    t.integer  "ministry_id"
    t.integer  "campus_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sn_ministry_campuses", ["ministry_id", "campus_id"], :name => "ministry_campus", :unique => true

  create_table "sn_ministry_involvements", :force => true do |t|
    t.integer "person_id"
    t.integer "ministry_id"
    t.date    "start_date"
    t.date    "end_date"
    t.boolean "admin"
    t.integer "ministry_role_id"
    t.integer "responsible_person_id"
    t.date    "last_history_update_date"
    t.boolean "is_people_soft"
    t.boolean "is_leader"
    t.integer "legacy_missional_team_member_id"
  end

  add_index "sn_ministry_involvements", ["ministry_id"], :name => "index_sn_ministry_involvements_on_ministry_id"
  add_index "sn_ministry_involvements", ["person_id", "ministry_id"], :name => "person_ministry", :unique => true

  create_table "sn_ministry_role_permissions", :force => true do |t|
    t.integer "permission_id"
    t.integer "ministry_role_id"
    t.string  "created_at"
  end

  create_table "sn_ministry_roles", :force => true do |t|
    t.integer  "ministry_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.string   "description"
    t.string   "type"
    t.boolean  "involved",    :default => true
  end

  add_index "sn_ministry_roles", ["ministry_id"], :name => "index_sn_ministry_roles_on_ministry_id"

  create_table "sn_news", :force => true do |t|
    t.string   "title"
    t.text     "message"
    t.integer  "group_id"
    t.integer  "ministry_id"
    t.integer  "person_id"
    t.boolean  "sticky"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "featured"
    t.boolean  "staff"
    t.boolean  "students"
  end

  create_table "sn_news_comments", :force => true do |t|
    t.integer  "news_id"
    t.integer  "person_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sn_permissions", :force => true do |t|
    t.string "description"
    t.string "controller"
    t.string "action"
  end

  create_table "sn_person_news", :force => true do |t|
    t.integer  "news_id"
    t.integer  "person_id"
    t.boolean  "hidden"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "featured"
  end

  add_index "sn_person_news", ["news_id"], :name => "index_sn_person_news_on_news_id"
  add_index "sn_person_news", ["person_id"], :name => "index_sn_person_news_on_person_id"

  create_table "sn_searches", :force => true do |t|
    t.integer  "person_id"
    t.text     "options"
    t.text     "query"
    t.text     "tables"
    t.boolean  "saved"
    t.string   "name"
    t.string   "order"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sn_semesters", :force => true do |t|
    t.integer  "year_id"
    t.date     "start_date"
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sn_semesters", ["start_date"], :name => "index_sn_semesters_on_start_date"
  add_index "sn_semesters", ["year_id"], :name => "index_sn_semesters_on_year_id"

  create_table "sn_sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sn_sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sn_sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "sn_timetables", :force => true do |t|
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sn_timetables", ["person_id"], :name => "person_id"

  create_table "sn_training_answers", :force => true do |t|
    t.integer  "training_question_id"
    t.integer  "person_id"
    t.string   "approved_by"
    t.date     "completed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sn_training_answers", ["person_id"], :name => "index_sn_training_answers_on_person_id"

  create_table "sn_training_categories", :force => true do |t|
    t.string   "name"
    t.integer  "position"
    t.integer  "ministry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sn_training_categories", ["ministry_id"], :name => "index_sn_training_categories_on_ministry_id"

  create_table "sn_training_question_activations", :force => true do |t|
    t.integer  "ministry_id"
    t.integer  "training_question_id"
    t.boolean  "mandate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sn_training_questions", :force => true do |t|
    t.integer  "ministry_id"
    t.integer  "training_category_id"
    t.string   "activity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sn_training_questions", ["ministry_id"], :name => "index_sn_training_questions_on_ministry_id"
  add_index "sn_training_questions", ["training_category_id"], :name => "index_sn_training_questions_on_training_category_id"

  create_table "sn_user_codes", :force => true do |t|
    t.integer "user_id"
    t.string  "code"
    t.text    "pass"
  end

  add_index "sn_user_codes", ["user_id"], :name => "index_sn_user_codes_on_user_id"

  create_table "sn_user_group_permissions", :force => true do |t|
    t.integer "permission_id"
    t.integer "user_group_id"
    t.string  "created_at"
  end

  create_table "sn_user_groups", :force => true do |t|
    t.string  "name"
    t.date    "created_at"
    t.integer "ministry_id"
  end

  create_table "sn_user_memberships", :force => true do |t|
    t.integer "user_id"
    t.integer "user_group_id"
    t.date    "created_at"
  end

  create_table "sn_view_columns", :force => true do |t|
    t.integer  "view_id"
    t.integer  "column_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sn_view_columns", ["column_id"], :name => "index_sn_view_columns_on_column_id"
  add_index "sn_view_columns", ["view_id", "column_id"], :name => "index_sn_view_columns_on_view_id_and_column_id"

  create_table "sn_views", :force => true do |t|
    t.string  "title",         :limit => 2000
    t.text    "select_clause"
    t.text    "tables_clause"
    t.integer "ministry_id"
    t.boolean "default_view"
  end

  add_index "sn_views", ["ministry_id"], :name => "index_sn_views_on_ministry_id"

  create_table "sn_years", :force => true do |t|
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sp_applications", :force => true do |t|
    t.integer  "person_id"
    t.integer  "project_id"
    t.integer  "designation_number"
    t.integer  "year"
    t.string   "status",                   :limit => 50
    t.integer  "preference1_id"
    t.integer  "preference2_id"
    t.integer  "preference3_id"
    t.integer  "preference4_id"
    t.integer  "preference5_id"
    t.integer  "current_project_queue_id"
    t.datetime "submitted_at"
    t.datetime "completed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "old_id"
    t.boolean  "apply_for_leadership"
    t.datetime "withdrawn_at"
    t.string   "su_code"
    t.boolean  "applicant_notified"
    t.integer  "account_balance"
    t.datetime "accepted_at"
  end

  add_index "sp_applications", ["person_id"], :name => "index_sp_applications_on_person_id"
  add_index "sp_applications", ["year"], :name => "index_sp_applications_on_year"

  create_table "sp_projects", :force => true do |t|
    t.integer  "pd_id"
    t.integer  "apd_id"
    t.integer  "opd_id"
    t.string   "name",                         :limit => 50
    t.string   "city",                         :limit => 50
    t.string   "state",                        :limit => 50
    t.string   "country",                      :limit => 60
    t.string   "aoa",                          :limit => 50
    t.string   "display_location",             :limit => 100
    t.string   "primary_partner",              :limit => 100
    t.string   "secondary_partner",            :limit => 100
    t.boolean  "partner_region_only"
    t.string   "report_stats_to",              :limit => 50
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "weeks"
    t.integer  "primary_ministry_focus_id"
    t.boolean  "job"
    t.text     "description"
    t.string   "operating_business_unit",      :limit => 50
    t.string   "operating_operating_unit",     :limit => 50
    t.string   "operating_department",         :limit => 50
    t.string   "operating_project",            :limit => 50
    t.string   "operating_designation",        :limit => 50
    t.string   "scholarship_business_unit",    :limit => 50
    t.string   "scholarship_operating_unit",   :limit => 50
    t.string   "scholarship_department",       :limit => 50
    t.string   "scholarship_project",          :limit => 50
    t.string   "scholarship_designation",      :limit => 50
    t.integer  "staff_cost"
    t.integer  "intern_cost"
    t.integer  "student_cost"
    t.string   "departure_city",               :limit => 60
    t.datetime "date_of_departure"
    t.string   "destination_city",             :limit => 60
    t.datetime "date_of_return"
    t.text     "in_country_contact"
    t.string   "project_contact_name",         :limit => 50
    t.string   "project_contact_role",         :limit => 40
    t.string   "project_contact_phone",        :limit => 20
    t.string   "project_contact_email",        :limit => 100
    t.integer  "max_student_men_applicants",                   :default => 0,    :null => false
    t.integer  "max_student_women_applicants",                 :default => 0,    :null => false
    t.integer  "housing_capacity_men"
    t.integer  "housing_capacity_women"
    t.integer  "ideal_staff_men",                              :default => 0,    :null => false
    t.integer  "ideal_staff_women",                            :default => 0,    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "current_students_men",                         :default => 0
    t.integer  "current_students_women",                       :default => 0
    t.integer  "current_applicants_men",                       :default => 0
    t.integer  "current_applicants_women",                     :default => 0
    t.integer  "year"
    t.integer  "coordinator_id"
    t.integer  "old_id"
    t.string   "project_status"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "url",                          :limit => 1024
    t.string   "url_title"
    t.string   "ds_project_code",              :limit => 50
    t.boolean  "show_on_website",                              :default => true
    t.datetime "apply_by_date"
    t.integer  "version"
    t.boolean  "use_provided_application",                     :default => true
    t.string   "tertiary_partner"
    t.date     "staff_start_date"
    t.date     "staff_end_date"
  end

  add_index "sp_projects", ["name"], :name => "sp_projects_name_index", :unique => true
  add_index "sp_projects", ["primary_partner"], :name => "primary_partner"
  add_index "sp_projects", ["secondary_partner"], :name => "secondary_partner"

end
