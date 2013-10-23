require 'sinatra'
require 'active_record'
require 'pry'
require 'rubygems'
# require 'sinatra/activerecord'
require 'alphadecimal'

###########################################################
# Configuration
###########################################################


set :public_folder, File.dirname(__FILE__) + '/public'
# set :database, "sqlite3:///database.db"

configure :development, :production do
    ActiveRecord::Base.establish_connection(
       :adapter => 'sqlite3',
       :database =>  'db/dev.sqlite3.db'
     )
end

# Handle potential connection pool timeout issues
after do
    ActiveRecord::Base.connection.close
end

###########################################################
# Models
###########################################################
# Models to Access the database through ActiveRecord.
# Define associations here if need be
# http://guides.rubyonrails.org/association_basics.html

class Link < ActiveRecord::Base
    def shorten
      self.id.alphadecimal
    end
end


###########################################################
# Routes
###########################################################

get '/' do
	#p Link.all
    #@links = [] # FIXME
    erb :index
end

get '/new' do
    erb :form
end

post '/new' do
  @short_url = Link.find_or_create_by_url(params[:original])
  if @short_url.valid?
    erb :success
  else
    erb :index
  end
end
end

get '/:shortened' do
	short_url = Link.find(params[:shortened])
	redirect short_url.original
end