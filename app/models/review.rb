class Review < ActiveRecord::Base
  belongs_to :subject, :class_name => "Person"
  belongs_to :initiator, :class_name => "Person"
  belongs_to :question_sheet
  has_many :reviewings, :class_name => "Reviewer"
  has_many :reviewers, :through => :reviewings, :class_name => "Person", :source => :person
  set_table_name "pr_reviews"

  validates_presence_of :name
  validates_presence_of :due

  def name
    self[:name].present? ? self[:name] : question_sheet.label
  end

  def past?
    self.completed_at.present? && self.completed_at < 1.week.ago
  end

  def question_sheets
    [ question_sheet ]
  end
  
  def late?
    Date.today > due && !completed_at
  end

  def update_percent_and_completed
    submitted = reviewings.where("submitted_at is not null").count
    total = reviewings.count
    logger.info "review #{id}: #{total} reviews, #{submitted} submitted"
    if total > 0
      self.percent = (submitted.to_f / total.to_f * 100).to_i
    else
      self.percent = 0
    end
    if percent == 100
      self.completed_at ||= Time.now
    end
    self.save!
  end
end
