class ProductionOrder < ActiveRecord::Base
  mount_uploader :logotype, LogotypeUploader

  belongs_to :soliciting_user, class_name: 'User'
  belongs_to :responsible_user, class_name: 'User'
  belongs_to :business_unit

  has_many :categories, dependent: :destroy
  accepts_nested_attributes_for :categories, allow_destroy: true, reject_if: proc { |attributes| attributes[:api_id].blank? }

  has_many :attachments, as: :attached_item, dependent: :destroy
  accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: proc { |attributes| attributes[:attachment].blank? }

  has_many :banners
  accepts_nested_attributes_for :banners, allow_destroy: true, reject_if: proc { |attributes| attributes[:image].blank? }

  has_many :rejection_reasons
  accepts_nested_attributes_for :rejection_reasons, allow_destroy: true, reject_if: proc { |attributes| attributes[:description].blank? }

  def federation_unit_id_enum
    Api::FederationUnit.select_formatted
  end

  def city_id_enum
    if self.federation_unit_id.nil?
      []
    else
      Api::City.select_formatted(self.federation_unit_id)
    end
  end

  def district_id_enum
    if self.city_id.nil?
      []
    else
      Api::District.select_formatted(self.city_id)
    end
  end

  def state_enum
    ProductionOrder.state_machine.states.map { |s| [s.human_name, s.name] }
  end

  rails_admin do
    list do
      configure :federation_unit_id do
        hide
      end
      configure :city_id do
        hide
      end
      configure :district_id do
        hide
      end
    end

    show do
      configure :federation_unit_id do
        hide
      end
      configure :city_id do
        hide
      end
      configure :district_id do
        hide
      end
    end
  end

  validates :business_unit_id, presence: true
  validates :soliciting_user_id, presence: true
  # validates_uniqueness_of :code

  after_create :initialize_code

  before_create :set_1st_responsible
  before_update :set_responsible

  def initialize_code
    str = id.to_s
    str += '-'
    str += created_at.year.to_s
    str += '%02d' % created_at.month.to_s
    str += '%02d' % created_at.day.to_s
    self.code = str
  end

  filterrific(
      default_filter_params: { sorted_by: 'created_at_desc' },
      available_filters: [
          :sorted_by,
          :search_query,
          :search_name_query,
          :search_code_query,
          :with_soliciting_user_id,
          :with_responsible_user_id,
          :with_business_unit_id,
          :with_federation_unit_id,
          :with_city_id,
          :with_state,
          :with_name,
          :with_duration,
          :with_not_published,
          :with_created_at_gte,
          :with_created_at_lt
      ]
  )

  scope :search_query, lambda { |query|
    # Searches the students table on the 'first_name' and 'last_name' columns.
    # Matches using LIKE, automatically appends '%' to each term.
    # LIKE is case INsensitive with MySQL, however it is case
    # sensitive with PostGreSQL. To make it work in both worlds,
    # we downcase everything.
    return nil  if query.blank?

    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)

    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    # num_or_conds = 2
    # where(
    #     terms.map { |term|
    #       "(LOWER(students.first_name) LIKE ? OR LOWER(students.last_name) LIKE ?)"
    #     }.join(' AND '),
    #     *terms.map { |e| [e] * num_or_conds }.flatten
    # )
    num_or_conds = 1
    where(
        terms.map { |term|
          "(LOWER(production_orders.name) LIKE ?)"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }
  scope :search_name_query, lambda { |query|
    return nil  if query.blank?
    term = query.to_s.downcase
    term = (term.gsub('*', '%') + '%').gsub(/%+/, '%')
    where('LOWER(production_orders.name) LIKE ?', term)
  }
  scope :search_code_query, lambda { |query|
    return nil  if query.blank?
    term = query.to_s.downcase
    term = (term.gsub('*', '%') + '%').gsub(/%+/, '%')
    where('LOWER(production_orders.code) LIKE ?', term)
  }

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
      when /^created_at_/
        # Simple sort on the created_at column.
        # Make sure to include the table name to avoid ambiguous column names.
        # Joining on other tables is quite common in Filterrific, and almost
        # every ActiveRecord table has a 'created_at' column.
        order("production_orders.created_at #{ direction }")
      when /^name_/
        # Simple sort on the name colums
        # order("LOWER(students.last_name) #{ direction }, LOWER(students.first_name) #{ direction }")
        order("LOWER(production_orders.name) #{ direction }")
      # when /^country_name_/
        # This sorts by a student's country name, so we need to include
        # the country. We can't use JOIN since not all students might have
        # a country.
        # order("LOWER(countries.name) #{ direction }").includes(:country)
      when /^business_unit_name_/
        order("LOWER(buiness_units.name) #{ direction }").includes(:business_unit)
      when /^soliciting_user_name_/
        joins(:soliciting_user).order("LOWER(users.email) #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  # always include the lower boundary for semi open intervals
  scope :with_created_at_gte, lambda { |reference_time|
    where('production_orders.created_at >= ?', Date.strptime(reference_time, '%d/%m/%Y'))
  }
  # always exclude the upper boundary for semi open intervals
  scope :with_created_at_lt, lambda { |reference_time|
    where('production_orders.created_at < ?', Date.strptime(reference_time, '%d/%m/%Y'))
  }

  scope :with_soliciting_user_id, lambda { |soliciting_user_ids| where(soliciting_user_id: [*soliciting_user_ids]) }
  scope :with_responsible_user_id, lambda { |responsible_user_ids| where(responsible_user_id: [*responsible_user_ids]) }
  scope :with_business_unit_id, lambda { |business_unit_ids| where(business_unit_id: [*business_unit_ids]) }
  scope :with_state, lambda { |states|
    parsed_state = []
    case states
      when 'EPSubmitte'
        parsed_state << 'submitted'
      when 'EPDesign'
        parsed_state << 'designing'
      when 'EPQuality'
        parsed_state << 'qualifying'
      when 'EPRejected'
        parsed_state << 'rejected'
      when 'EPPublishe'
        parsed_state << 'published'
      when 'EPCancelle'
        parsed_state << 'cancelled'
    end
    where(state: [*parsed_state])
  }
  scope :with_name, lambda { |names| where(name: [*names]) }
  scope :with_duration, lambda { |reference_time|
    if reference_time == '0'
      days_ago = Time.now
    elsif reference_time > 0
      days_ago = Time.now - (reference_time * 1.day)
    else
      days_ago = Time.now
    end
    where('production_orders.created_at < ?', days_ago)
  }
  scope :with_not_published, lambda { |checked| checked == 1 ? without_states(:published) : nil }
  scope :with_federation_unit_id, lambda { |federation_unit|
    where('business_units.federation_unit_id = ?', federation_unit).joins(:business_unit)
  }
  scope :with_city_id, lambda { |city|
    where('business_units.city_id = ?', city).joins(:business_unit)
  }

  def self.options_for_sorted_by
    [
        ['Nome (a-z)', 'name_asc'],
        ['Criado em (mais atual)', 'created_at_desc'],
        ['Criado em (mais antigo)', 'created_at_asc'],
        ['Solicitante (a-z)', 'soliciting_user_name_asc'],
        ['Unidade (a-z)', 'business_unit_name_asc']
    ]
  end

  def self.options_for_with_federation_unit_id(user, business_unit)
    if user.admin?
      Api::FederationUnit.select_formatted
    else
      [[business_unit.federation_unit_name, business_unit.federation_unit_id]]
    end
  end

  def self.options_for_with_city_id(user, business_unit)
    if user.admin?
      []
    elsif user.master?
      Api::City.select_formatted(business_unit.federation_unit_id)
    else
      [[business_unit.city_name, business_unit.city_id]]
    end
  end

  def self.options_for_with_business_unit_id(user, business_unit)
    if user.admin? || user.master?
      []
    elsif user.franchisee?
      BusinessUnit.options_for_select(business_unit.city_id)
    else
      [[business_unit.name, business_unit.id]]
    end
  end

  def self.options_for_with_responsible_user_id(business_unit)
    User.options_for_responsible_select(business_unit.id)
  end

  has_paper_trail

  state_machine :state, :initial => :submitted do

    event :approve do
      transition :submitted => :designing,
                 :qualifying => :published
    end

    event :check_design do
      transition [:designing, :rejected] => :qualifying
    end

    event :reject do
      transition :qualifying => :rejected
    end

    event :cancel do
      transition [:submitted, :qualifying] => :cancelled
    end

  end

  scope :with_states, lambda {|*states| where(:state => states)}

  scope :without_states, lambda {|*states| where.not(:state => states)}

  def duration
    ((Time.now - created_at)/1.day)
  end

  def set_responsible
    unless self.changed_attributes[:state].nil?
      if self.changes[:state].last == 'designing'
        set_designer_as_responsible
      elsif self.changes[:state].last == 'qualifying'
        set_marketing_as_responsible
      elsif self.changes[:state].last == 'rejected'
        set_designer_as_responsible
      elsif self.changes[:state].last == 'published'
        remove_responsible
      elsif self.changes[:state].last == 'cancelled'
        remove_responsible
      end
    end
  end

  def remove_responsible
    self.responsible_user = nil
  end

  def set_designer_as_responsible
    if self.original_designer_id.nil?
      responsible = User.designer.where(business_unit: self.business_unit).sample
      self.original_designer_id = responsible.try(:id)
      self.responsible_user = responsible
    else
      self.responsible_user_id = self.original_designer_id
    end
  end

  def set_marketing_as_responsible
    responsible = User.marketing.sample
    self.responsible_user = responsible
  end

  def set_1st_responsible
    responsible = User.marketing.sample
    self.responsible_user = responsible
  end
end

# p = FactoryGirl.create(:production_order)