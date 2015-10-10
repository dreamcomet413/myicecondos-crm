class LeadAssignmentRule < ActiveRecord::Base
  attr_accessible :information, :source, :title

  serialize :information, Hash

  validates :title, presence: true
  validates :source, presence: true, uniqueness: true
  validate :percentage_sum

  def self.for_source lead_source
    where(source: lead_source).first
  end

  def next_user_for_assignment
    information[:users].each do |u|
      user_max_count = (u[1][:percentage].to_f/100*10).round
      return u[0].to_i if u[1][:current_count] < user_max_count
    end
  end

  def update_assignments user_id
    if information[:assigned_leads_count] == 9
      information[:assigned_leads_count] = 0
      information[:users].each do |k,v|
        v[:current_count] = 0
      end
      information[:users] = Hash[information[:users].sort_by{|k,v| -v["percentage"].to_i}]
    else
      information[:assigned_leads_count] = information[:assigned_leads_count].to_i + 1
      user_to_move = information[:users].delete(user_id.to_s)
      if user_to_move[:current_count] < (user_to_move[:percentage].to_f/100*10).round
        user_to_move[:current_count] = user_to_move[:current_count].to_i + 1
      end
      to_merge = {user_id.to_s => user_to_move}
      information[:users].merge! to_merge
    end
    save
  end

  private

  def percentage_sum
    c_sum = information[:users].values.sum{|v| v[:percentage].to_i}
    errors.add(:base, "Lead distribution percentages must add up to 100. Current sum: #{c_sum}") unless c_sum == 100
  end
end
