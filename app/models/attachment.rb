class Attachment < ActiveRecord::Base
  mount_uploader :attachment, AttachmentUploader

  def state_enum
    Attachment.state_machine.states.map { |s| [s.human_name, s.name] }
  end

  # Associations

  belongs_to :attached_item, polymorphic: true

  # Validations

  validates_presence_of :attachment
  validates_integrity_of :attachment

  # Callbacks

  before_save :update_attachment_attributes

  # Delegate

  delegate :url, :size, :path, to: :attachment

  # Virtual attributes

  alias_attribute :filename, :original_filename

  state_machine :state, :initial => :active do

    event :enable do
      transition all => :active
    end

    event :disable do
      transition all => :inactive
    end

  end

  private

  def update_attachment_attributes
    if attachment.present? && attachment_changed?
      self.original_filename = attachment.file.original_filename
      self.content_type = attachment.file.content_type
    end
  end
end
