# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Fat Free CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
module MockIMAP
  def mock_imap
    @imap = double
    @settings = @crawler.instance_variable_get("@settings")
    @settings[:address] = @mock_address
    Net::IMAP.stub(:new).with(@settings[:server], @settings[:port], @settings[:ssl]).and_return(@imap)
  end

  def mock_connect
    mock_imap
    @imap.stub(:login).and_return(true)
    @imap.stub(:select).and_return(true)
  end

  def mock_disconnect
    @imap.stub(:disconnected?).and_return(false)
    @imap.stub(:logout).and_return(true)
    @imap.stub(:disconnect).and_return(true)
  end

  def mock_message(body)
    @fetch_data = double
    @fetch_data.stub(:attr).and_return("RFC822" => body)
    @imap.stub(:uid_search).and_return([ :uid ])
    @imap.stub(:uid_fetch).and_return([ @fetch_data ])
    @imap.stub(:uid_copy).and_return(true)
    @imap.stub(:uid_store).and_return(true)
    body
  end
end
