class PersonAccess < ActiveRecord::Base
  def any_access_set
    national_access.present? || regional_access.present? || ics_access.present? || 
      intern_access.present? || stint_access.present?
  end

  def jobstatus_access
    #if stint_access.present? && stint_access.present?
  end

  def jobtitle_access

  end
end
