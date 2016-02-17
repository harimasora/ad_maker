class Api::Util
  def self.select_formatted(hash_array, name, value)
    if hash_array.nil?
      return []
    end

    final_array = []
    hash_array.each do |h|
      item_arr = [h[name.to_s].to_s, h[value.to_s].to_s]
      final_array << item_arr
    end
    final_array
  end
end
