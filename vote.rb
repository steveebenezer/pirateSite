require 'sinatra'
require 'sinatra/reloader' if development?
require 'yaml/store'

get '/' do
	@title = 'Hi-ho Pondy! How be yes doin\'?'
	erb :index
end

post '/cast' do
	@title = "Wish I\'d known \'bout \'tis a pair days ago. I\'d be havin\' a ruckas all shore leave."
	@vote = params['vote']
	@store = YAML::Store.new 'votes.yml'
	@store.transaction do
		@store['votes'] ||= {}
		@store['votes'][@vote] ||= 0
		@store['votes'][@vote] += 1
	end
	erb :cast
end

get '/results' do
	@title = 'Arrrrrgghhhh check out this!'
	@store = YAML::Store.new 'votes.yml'
	@votes = @store.transaction { @store['votes'] }
	erb :results
end

Choices = {
	'BMB' => '\'tis site be th\' bomb!',
	'MSG' => 'I gunna pillage \'tis page \'n message it everywhere',
	'FHT' => 'Why be no one fightin\' Marco Polo wit\' me?',
	'RUM' => 'Yo-ho-ho and a bottle of rum!',
	'LKE' => 'I lust \'tis harrharr.',
}