class Api::City
  include HTTParty

  def self.raw (federation_unit_id=nil)
    response = self.new.class.post(API_CITY_URI, :body => {'state' => federation_unit_id.to_s}, :headers => {'Content-Type' => 'application/x-www-form-urlencoded'})
    response.body.slice!(0,federation_unit_id.to_s.length)
    ActiveSupport::JSON.decode(response.body)
  end

  def self.select_formatted (federation_unit_id=nil, name='name', value='id')
    Api::Util.select_formatted(raw(federation_unit_id),name,value)
  end
end