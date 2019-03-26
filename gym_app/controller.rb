require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative('./models/sessions')
require_relative('./models/members')
also_reload('./models/*')

get '/gym' do
  erb(:home )
end

get '/gym/members' do #index
  @members = Member.all
  erb( :index )
end

get '/gym/members/new' do #new
  @sessions = Session.all
  erb ( :new )
end

post '/gym/students' do #create
  @new_member = Member.new(params)
  @new_member.save
  erb ( :create )
end

get '/gym/members/:id' do # show
  @member = Member.find_by_id( params[:id] )
  erb( :show )
end
