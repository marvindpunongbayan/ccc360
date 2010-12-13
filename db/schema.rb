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

ActiveRecord::Schema.define(:version => 20101206204954) do

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

  create_table "pr_admins", :force => true do |t|
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pr_answer_sheet_question_sheets", :force => true do |t|
    t.integer  "answer_sheet_id"
    t.integer  "question_sheet_id"
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
    t.string   "kind",                      :limit => 40,                    :null => false
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
    t.text     "tooltip"
    t.boolean  "hide_label",                              :default => false
    t.boolean  "hide_option_labels",                      :default => false
    t.integer  "max_length"
  end

  add_index "pr_elements", ["position"], :name => "index_pr_elements_on_question_sheet_id_and_position_and_page_id"
  add_index "pr_elements", ["slug"], :name => "index_pr_elements_on_slug"

  create_table "pr_email_templates", :force => true do |t|
    t.string   "name",       :limit => 1000, :null => false
    t.text     "content"
    t.boolean  "enabled"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pr_email_templates", ["name"], :name => "index_pr_email_templates_on_name", :length => {"name"=>255}

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

  create_table "pr_personal_forms", :force => true do |t|
    t.integer  "person_id"
    t.integer  "question_sheet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pr_question_sheet_pr_infos", :force => true do |t|
    t.integer  "question_sheet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_type",         :default => "review"
    t.integer  "summary_form_id"
  end

  create_table "pr_question_sheets", :force => true do |t|
    t.string  "label",        :limit => 60,                    :null => false
    t.boolean "archived",                   :default => false
    t.boolean "fake_deleted",               :default => false
  end

  create_table "pr_references", :force => true do |t|
    t.integer  "question_id"
    t.integer  "applicant_answer_sheet_id"
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

  create_table "pr_reminders", :force => true do |t|
    t.integer  "person_id"
    t.string   "label"
    t.string   "note"
    t.date     "reminder_date"
    t.boolean  "send_email",      :default => false
    t.integer  "email_days_diff", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "email_sent_at"
  end

  create_table "pr_reviewers", :force => true do |t|
    t.integer  "review_id"
    t.integer  "person_id"
    t.datetime "invitation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_key"
    t.datetime "submitted_at"
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
    t.datetime "completed_at"
    t.integer  "show_summary_form_days", :default => 14
    t.boolean  "fake_deleted",           :default => false
  end

  create_table "pr_sessions", :force => true do |t|
    t.text "session_id"
    t.text "data"
  end

  create_table "pr_summary_forms", :force => true do |t|
    t.integer  "person_id"
    t.integer  "review_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pr_users", :force => true do |t|
    t.integer  "ssm_id"
    t.datetime "last_login"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
