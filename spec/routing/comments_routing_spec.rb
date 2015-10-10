# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Fat Free CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CommentsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/comments" }.should route_to(:controller => "comments", :action => "index")
    end

    it "recognizes and generates #edit" do
      { :get => "/comments/1/edit" }.should route_to(:controller => "comments", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/comments" }.should route_to(:controller => "comments", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/comments/1" }.should route_to(:controller => "comments", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/comments/1" }.should route_to(:controller => "comments", :action => "destroy", :id => "1")
    end
  end
end
