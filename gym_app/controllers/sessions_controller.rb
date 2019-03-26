require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative('../models/sessions')
require_relative('../models/members')
also_reload('../models/*')

get '/gym' do
  erb(:"sessions/home" )
end

get '/gym/sessions' do #index
  @sessions = Session.all
  erb( :"sessions/index" )
end

get '/gym/sessions/new' do #new
  erb ( :"sessions/new" )
end

post '/gym/sessions' do #create
  @new_session = Session.new(params)
  @new_session.save
  erb ( :"sessions/create" )
end
#
# get '/gym/members/:id' do # show
#   @member = Member.find_by_id( params[:id] )
#   erb( :"members/show" )
# end
#
# get '/gym/members/:id/edit' do # edit
#   @member = Member.find_by_id( params[:id] )
#   @sessions = Session.all
#   erb( :"members/edit" )
# end
#
# post '/gym/members/:id' do # update
#   member = Member.new(params)
#   member.update
#   redirect to "/gym/members/#{params['id']}"
# end
#
# post '/gym/members/:id/delete' do # delete
#   member = Member.find_by_id(params[:id])
#   member.delete()
#   redirect to '/gym/members'
# end
