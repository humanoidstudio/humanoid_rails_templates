class AddReferralCodeAndReferrerIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :referral_code, :string
    
    User.reset_column_information
    User.all.each do |u|
      u.update_attribute(:referral_code, Rufus::Mnemo::from_integer(rand(100**5)))
    end
    add_column :users, :referrer_id, :integer
  end
end
