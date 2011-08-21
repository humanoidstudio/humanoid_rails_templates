class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  belongs_to :role
  
  before_create do
    add_role(:member)
    #add_referral_code
  end

  # Check user's role
  def role?(role)
    self.role == Role.find_by_name(role.to_s.titleize) ? true : false
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
