require "sinatra"
require "./models.rb"

module Errors
  class ArgumentsWasGotNotFully < StandardError
    def message
      "arguments was got not fully"
    end
  end
end

configure do
end

def show_docs
  s=""
  File.open(__FILE__, "r").read.each_line do |line|
    if line.include?("post") and !line.include?("line") and !line.include?("*")
      s+=(line.gsub("do", ""))
    end
  end
  return s
end
DOCS = show_docs

def get_doc
  return """Method: POST
Content-Type: application/json

#{DOCS}"""
end

def parse_body
  JSON.parse(request.body.read, symbolize_names: true)
end

def get_data(fields, data)
  length = fields.length
  _data = {}
  fields.each do |field|
    if data.include?(field.to_sym)
      _data.update(field => data[field])
    end
  end

  raise Errors::ArgumentsWasGotNotFully if _data.length < length

  _data
end

def check(model_name, data)
  #model = Object.const_get(model_name)
  key_id = (model_name + "_id").to_sym
  raise Errors::KeyIdNotFound if data.has_key?(key_id) == true
  item_found = Model.find()
end

before do
  content_type :json
end

after do
end

post '/shops' do
  items = Shop.all.as_json
  return {status: true, items: items}.to_json
end

post '/books' do
  items = Book.all.as_json
  return {status: true, items: items}.to_json
end

post '/shop/new' do # {"name": string}
  begin
    shop = Shop.new get_data([:name], parse_body)
  rescue => e
    return {status: false, item: nil, errors: [e.message]}.to_json
  end

  if shop.save
    return {status: true, item: shop.as_json, errors: nil}.to_json
  else
    return {status: false, item: nil, errors: shop.errors}.to_json
  end
end

post '/book/new' do # {"title": string}
  begin
    book = Book.new get_data([:title], parse_body)
  rescue => e
    return {status: false, item: nil, errors: [e.message]}.to_json
  end

  if book.save
    return {status: true, item: book.as_json, errors: nil}.to_json
  else
    return {status: false, item: nil, errors: book.errors}.to_json
  end
end

post '/book/:book_id/add/shop/:shop_id/count/:count' do # place book to shop
  begin
    data = get_data([:book_id, :shop_id, :count], params)
    data = check_item("book", data)
    data = check_item("shop", data)
    item = BookByShop.new(data)
  rescue => e
    return {status: false, item: nil, errors: [e.message]}.to_json
  end

  if item.save
    return {status: true, item: item, errors: nil}.to_json
  else
    return {status: false, item: nil, errors: item.errors}.to_json
  end
end

get '/robots.txt' do
  content_type :text
  return ""
end

get '/*' do
  content_type :text
  return get_doc
end

post '/*' do
  content_type :text
  return get_doc
end
