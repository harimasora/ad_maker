class Api::Group
  include HTTParty

  def self.raw
    self.new.class.post(API_GROUP_URI).parsed_response
  end

  def self.select_formatted(name='descricao', value='codigo')
    Api::Util.select_formatted(raw,name,value)
  end
end