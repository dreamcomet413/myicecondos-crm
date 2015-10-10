# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Fat Free CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TasksHelper do

  describe "responding with generated links" do

    before do
      @task = FactoryGirl.create(:task)
    end

    it "should render link to uncomplete of a task" do
      link_to_task_uncomplete(@task, nil).should include(t(:task_uncomplete))
    end

  end
end

