# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Fat Free CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
module FatFreeCRM
  module Exportable

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def exportable(options = {})
        unless included_modules.include?(InstanceMethods)
          include InstanceMethods
          extend SingletonMethods
        end
      end
    end

    module InstanceMethods
      def user_id_full_name
        user = self.user
        user ? user.full_name : ''
      end

      def self.included(base)
        if base.instance_methods.include?(:assignee) or base.instance_methods.include?('assignee')
          define_method :assigned_to_full_name do
            user = self.assignee
            user ? user.full_name : ''
          end
        end

        if base.instance_methods.include?(:completor) or base.instance_methods.include?('completor')
          define_method :completed_by_full_name do
            user = self.completor
            user ? user.full_name : ''
          end
        end
      end
    end

    module SingletonMethods
    end

  end # Exportable
end # FatFreeCRM

ActiveRecord::Base.send(:include, FatFreeCRM::Exportable)
