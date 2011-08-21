class Role < ActiveRecord::Base
  attr_accessible :title
  has_many :users
  
  rails_admin do
    show do
      fields_of_type :has_many_association do
        pretty_value do
          bindings[:view].render :partial => 'show_association',
                                 :locals  => { :field => self, 
                                               :form => bindings[:form], 
                                               :fieldset => bindings[:fieldset] }
        end
      end
    end
  end
end
