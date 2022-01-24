class ApplicationController < Sinatra::Base

    # this line sets the Content-Type header for all responses
  set :default_content_type, 'application/json'

   get '/games' do 
    # get all games from the database by title and limit it to 10
      games = Game.all.order(:title).limit(10)
    # return the JSON response with an array of all the game data  
      games.to_json 
  end

    # use the id syntax to create a dynamic route 
   get '/games/:id' do
    # look up the game in the database using its ID
    game = Game.find(params[:id])
    # send a JSON-formatted response of the game data
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
  end

end

