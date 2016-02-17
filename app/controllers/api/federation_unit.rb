class Api::FederationUnit
  include HTTParty

  def self.raw
    self.new.class.post(API_FEDERATION_UNIT_URI).parsed_response
  end

  def self.select_formatted(name='uf', value='codigo')
    Api::Util.select_formatted(raw,name,value)
  end
end