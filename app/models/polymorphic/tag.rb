# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Fat Free CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
class Tag < ActsAsTaggableOn::Tag
  before_destroy :no_associated_field_groups

  # Don't allow a tag to be deleted if it is associated with a Field Group
  def no_associated_field_groups
    FieldGroup.find_all_by_tag_id(self).none?
  end

  # Returns a count of taggings per model klass
  # e.g. {"Contact" => 3, "Account" => 1}
  def model_tagging_counts
    Tagging.where(:tag_id => id).count(:group => :taggable_type)
  end

  ActiveSupport.run_load_hooks(:fat_free_crm_tag, self)
end
