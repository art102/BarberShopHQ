#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
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

	@username = params[:username]
	@phone = params[:phone]
	@date_time = params[:date_time]
	@barber = params[:barber]
	@color = params[:color]

	visitor = Client.new
	visitor.name = @username
	visitor.phone = @phone
	visitor.datestamp = @date_time
	visitor.barber = @barber
	visitor.color = @color
	visitor.save

	erb "<h3>Вы записались!</h3><p>Будем ждать Вас #{@date_time}.</p>"
end

get '/contacts' do
	erb :contacts
end

post '/contacts' do
	address = params[:address]

	visitor_location = Contact.new
	visitor_location.address = address
	visitor_location.save

	erb "<h3>Спасибо! Вы помогаете нам стать лучше!</h3>"
	redirect to '/visit'
end
