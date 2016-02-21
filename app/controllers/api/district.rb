class Api::District
  include HTTParty

  def self.raw(city=nil)
    self.new.class.post(API_DISTRICT_URI, :body => {'cidade' => city.to_s}, :headers => {'Content-Type' => 'application/x-www-form-urlencoded'}).parsed_response
  end

  def self.select_formatted(city=nil,name='descricao', value='codico')
    Api::Util.select_formatted(raw(city),name,value)
  end
end