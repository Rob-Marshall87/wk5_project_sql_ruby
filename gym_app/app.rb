require('sinatra')
require('sinatra/contrib/all')
require_relative('controllers/members_controller.rb')
require_relative('controllers/sessions_controller.rb')

get '/' do
  erb( :index )
end
