# require_dependency Rails.root.join('vendor','plugins','questionnaire_engine','app','models','answer').to_s
require_dependency Qe::Engine.root.join('app', 'models', 'qe', 'answer').to_s

class Answer < Qe::Answer
  has_attached_file :attachment, :storage => :s3,
                                  :s3_credentials => Rails.root.join("config/amazon_s3.yml"),
                                  :path => "pr/:attachment/:id/:filename"
end