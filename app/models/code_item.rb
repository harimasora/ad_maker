class CodeItem < ActiveRecord::Base
  belongs_to :code_table

  validates :short_description, presence: true, length: {maximum: 10}
  validates :description, presence: true, length: {maximum: 50}
  validates :dependent, length: {maximum: 10}
  validates_uniqueness_of :short_description

  def self.options_for_process_state_select
    table = CodeTable.where(name: 'Etapa do Processo').first
    where(code_table_id: table.id).order('LOWER(description)').map { |e| [e.description, e.short_description] }
  end
end
