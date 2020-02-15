
# Your application should only accept the /items/<ITEM NAME> route. Everything else should 404
# If a user requests /items/<Item Name> it should return the price of that item
# IF a user requests an item that you don't have, then return a 400 and an error message

class Application

  def call(env)
    
    resp = Rack::Response.new
    req = Rack::Request.new(env) 

    if req.path.match(/items/)
      found_item = req.path.split("/items/").last
      if item_found = @@items.find { |i| i.name == found_item }
        resp.write item_found.price
      else
        resp.status = 400
        resp.write "Item not found"
      end  
    else
      resp.status = 404
      resp.write "Route not found"
    end  

    resp.finish
  end  

end  
