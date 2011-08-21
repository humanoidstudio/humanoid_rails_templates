class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  belongs_to :role
  belongs_to :referrer, :class_name => "User", :foreign_key => :referrer_id
  has_many :referrals, :class_name => "User", :foreign_key => :referrer_id
  
  before_create do
    add_role(:member)
    add_referral_code
  end

  # Check user's role
  def role?(role)
    self.role == Role.find_by_name(role.to_s.titleize) ? true : false
  end
  
  def to_s
    "[##{self.id}] #{self.email}"
  end
  
  # Model-specific configurations
  rails_admin do
    list do
      fields :id, :email do
        sortable true
      end

      field :role do
        filterable :title
        sortable :title
      end
      
      field :referrer do
        pretty_value do
          bindings[:view].link_to(value.email, "/admin/#{value.class.name.pluralize.underscore}/#{value.id}")
        end
      end
      
      field :created_at do
        label "Signup At"
      end
      
      exclude_fields :reset_password_sent_at, :remember_created_at, :sign_in_count,
                     :current_sign_in_at, :last_sign_in_at,
                     :current_sign_in_ip, :last_sign_in_ip
    end
    
    edit do
      exclude_fields :reset_password_sent_at
    end
    
    show do
      fields :id, :email, :role

      field :referrer do
        pretty_value do
          bindings[:view].link_to(value.email, "/admin/#{value.class.name.pluralize.underscore}/#{value.id}")
        end
      end
      
      field :referrals do
        pretty_value do
          bindings[:view].render :partial => 'show_association',
                                 :locals  => { :field => self, 
                                               :form => bindings[:form], 
                                               :fieldset => bindings[:fieldset] }
        end
      end
      
      include_all_fields
    end
  end
  
  private
    def add_role(role_name)
      self.role = Role.find_by_name(role_name.to_s.titleize)
    end
    
    def add_referral_code
      self.referral_code = random_referral_code
    end
    
    # Generate a unique random referral code and assign it to the user
    def random_referral_code
      code = Rufus::Mnemo::from_integer rand(100**5)
      while referral_code_existed?(code)
        code = Rufus::Mnemo::from_integer rand(100**5)
      end
      "#{code}"
    end
    
    # Check if referral code existed in database
    def referral_code_existed?(code)
      User.find_by_referral_code(code) ? true : false
    end
end
