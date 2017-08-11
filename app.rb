#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
	validates :name, :phone, :datestamp, :color, presence: true
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
end

get '/' do
	@barbers = Barber.all
	erb :index 
end

get '/visit' do
	erb :visit
end

post '/visit' do
	visitor = Client.new params[:client]
	
	if visitor.save
		erb "<h3>Спасибо, вы записались!</h3>"
	else
		erb "<h3>Ошибка!</h3>"
	end
end

get '/contacts' do
	erb :contacts
end

post '/contacts' do
	visitor_location = Contact.new params[:contact]
	visitor_location.save

	erb "<h3>Спасибо! Вы помогаете нам стать лучше!</h3>"
end
