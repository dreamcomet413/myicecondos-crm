class Call < ActiveRecord::Base
  attr_accessible :lead_id, :notes, :title
  belongs_to :lead

  def self.title_list
    ['Talked to Lead', 'Left Voice Mail', 'Called (No message left)', 'Lead is Not There', 'Opt Out - Do not Call', 'Wrong Number', 'Lead Called In']
  end
end
