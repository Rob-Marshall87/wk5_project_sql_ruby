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

get '/gym/sessions/:id' do # show
  @session = Session.find_by_id( params[:id] )
  erb( :"sessions/show" )
end

get '/gym/sessions/:id/edit' do # edit
  @session = Session.find_by_id( params[:id] )
  erb( :"sessions/edit" )
end

post '/gym/sessions/:id' do # update
  session = Session.new(params)
  session.update
  redirect to "/gym/sessions/#{params['id']}"
end

post '/gym/sessions/:id/delete' do # delete
  session = Session.find_by_id(params[:id])
  session.delete()
  redirect to '/gym/sessions'
end

get '/gym/sessions/:id/members' do
  session = Session.find_by_id( params[:id] )
  @members = session.members
  erb( :"sessions/members")
end
