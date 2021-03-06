require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative('../models/sessions')
require_relative('../models/members')
also_reload('../models/*')

get '/gym' do
  erb(:"members/home" )
end

get '/gym/members' do #index
  @members = Member.all
  erb( :"members/index" )
end

get '/gym/members/new' do #new
  @sessions = Session.all
  erb ( :"members/new" )
end

post '/gym/members' do #create
  @new_member = Member.new(params)
  @new_member.save
  erb ( :"members/create" )
end

get '/gym/members/:id' do # show
  @member = Member.find_by_id( params[:id] )
  erb( :"members/show" )
end

get '/gym/members/:id/edit' do # edit
  @member = Member.find_by_id( params[:id] )
  @sessions = Session.all
  erb( :"members/edit" )
end

post '/gym/members/:id' do # update
  member = Member.new(params)
  member.update
  redirect to "/gym/members/#{params['id']}"
end

post '/gym/members/:id/delete' do # delete
  member = Member.find_by_id(params[:id])
  member.delete()
  redirect to '/gym/members'
end
