# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Fat Free CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
Rails.application.routes.draw do
  resources :lists
  mount MailsViewer::Engine => '/delivered_mails'

  root :to => 'home#index'

  match 'activities' => 'home#index'
  match 'admin'      => 'admin/users#index',       :as => :admin
  match 'login'      => 'authentications#new',     :as => :login
  match 'logout'     => 'authentications#destroy', :as => :logout
  match 'profile'    => 'users#show',              :as => :profile
  match 'signup'     => 'users#new',               :as => :signup

  match '/home/options',  :as => :options
  match '/home/toggle',   :as => :toggle
  match '/home/timeline', :as => :timeline
  match '/home/timezone', :as => :timezone
  match '/home/redraw',   :as => :redraw
  match '/email_webhook', to: "emails#email_webhook"

  resource  :authentication, :except => [:index, :edit]
  resources :comments,       :except => [:new, :show]
  resources :emails,         :only   => [:destroy]
  resources :passwords,      :only   => [:new, :create, :edit, :update]
  resources :prospect_matches

  resources :accounts, :id => /\d+/ do
    collection do
      get  :advanced_search
      post :filter
      get  :options
      get  :field_group
      match :auto_complete
      get  :redraw
      get  :versions
    end
    member do
      put  :attach
      post :discard
      post :subscribe
      post :unsubscribe
      get  :contacts
      get  :opportunities
    end
  end

  resources :campaigns, :id => /\d+/ do
    collection do
      get  :advanced_search
      post :filter
      get  :options
      get  :field_group
      match :auto_complete
      get  :redraw
      get  :versions
    end
    member do
      put  :attach
      post :discard
      post :subscribe
      post :unsubscribe
      get  :leads
      get  :opportunities
    end
    resources :campaign_emails, only: [:create, :update, :destroy]
  end

  resources :contacts, :id => /\d+/ do
    collection do
      get  :advanced_search
      post :filter
      get  :options
      get  :field_group
      match :auto_complete
      get  :redraw
      get  :versions
    end
    member do
      put  :attach
      post :discard
      post :subscribe
      post :unsubscribe
      get  :opportunities
    end
  end

  resources :partial_leads, only: :index
  resources :leads, :id => /\d+/ do
    collection do
      get  :advanced_search
      post :filter
      get  :options
      get  :field_group
      match :auto_complete
      get  :redraw
      get  :versions
      get  :autocomplete_account_name
    end
    member do
      get  :convert
      post :discard
      post :subscribe
      post :unsubscribe
      put  :attach
      put  :promote
      put  :reject
      post :add_call
      put  :update_call
      post :send_email
    end
  end
  resources :lead_assignment_rules

  resources :opportunities, :id => /\d+/ do
    collection do
      get  :advanced_search
      post :filter
      get  :options
      get  :field_group
      match :auto_complete
      get  :redraw
      get  :versions
    end
    member do
      put  :attach
      post :discard
      post :subscribe
      post :unsubscribe
      get  :contacts
    end
  end

  resources :tasks, :id => /\d+/ do
    collection do
      post :filter
      match :auto_complete
    end
    member do
      put  :complete
      put  :uncomplete
    end
  end

  resources :users, :id => /\d+/, :except => [:index, :destroy] do
    member do
      get  :avatar
      get  :password
      put  :upload_avatar
      put  :change_password
      post :redraw
    end
    collection do
      get  :opportunities_overview
      match :auto_complete
    end
  end

  resources :landings, except: [:show]
  resources :email_templates, except: [:show] do
    member do
      get :sample
    end
  end

  namespace :admin do
    resources :groups

    resources :users do
      collection do
        match :auto_complete
      end
      member do
        get :confirm
        put :suspend
        put :reactivate
      end
    end

    resources :field_groups, :except => [:index, :show] do
      collection do
        post :sort
      end
      member do
        get :confirm
      end
    end

    resources :fields do
      collection do
        match :auto_complete
        get   :options
        get   :redraw
        post  :sort
        get   :subform
      end
    end

    resources :tags, :except => [:show] do
      member do
        get :confirm
      end
    end

    resources :fields, :as => :custom_fields
    resources :fields, :as => :core_fields

    resources :settings, :only => :index
    resources :plugins,  :only => :index
  end

  namespace :api do
    resources :leads, only: [] do
      collection do
        post :load_from_client
      end
    end
  end

end
