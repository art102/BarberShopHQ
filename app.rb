#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
	validates :name, presence: true, length: { minimum: 3 }
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :color, presence: true
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
	validates :address, presence: true,length: { in: 2..100 }
end

get '/' do
	@barbers = Barber.all
	erb :index 
end

get '/visit' do
	@visitor = Client.new
	erb :visit
end

post '/visit' do
	@visitor = Client.new params[:client]
	
	if @visitor.save
		erb "<h3>Спасибо, вы записались!</h3>"
	else
		@error = @visitor.errors.full_messages.first
		erb :visit
	end
end

get '/contacts' do
	@visitor_location = Contact.new 
	erb :contacts
end

post '/contacts' do
	@visitor_location = Contact.new params[:contact]
	if @visitor_location.save
		erb "<h3>Спасибо! Вы помогаете нам стать лучше!</h3>"
	else 
		@error = @visitor_location.errors.full_messages.first
		erb :contacts
	end
end

get '/barber/:id' do
	@barber = Barber.find(params[:id])
	erb :barber
end

get '/bookings' do
	@clients = Client.order('created_at DESC')
	erb :bookings
end
