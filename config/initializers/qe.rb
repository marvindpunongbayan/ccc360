module Qe
  # # prefix for database tables
  mattr_accessor :table_name_prefix
  self.table_name_prefix = 'pr_'
  
  # this should be dynamically overriden by the application at certain points
  mattr_accessor :answer_sheet_class
  self.answer_sheet_class = 'Qe::AnswerSheet'

  mattr_accessor :from_email
  self.from_email = 'info@example.com'

  mattr_accessor :no_refs
  self.no_refs = true
end
