class Api::Subgroup
  include HTTParty

  def self.raw(group=nil)
    self.new.class.post(API_SUBGROUP_URI, :body => {'grupo' => group.to_s}, :headers => {'Content-Type' => 'application/x-www-form-urlencoded'}).parsed_response
  end

  def self.select_formatted(group=nil,name='descricao', value='codico')
    Api::Util.select_formatted(raw(group),name,value)
  end
end