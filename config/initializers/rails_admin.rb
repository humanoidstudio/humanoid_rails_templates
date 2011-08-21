RailsAdmin.config do |config|
  # Global configuration
  config.excluded_models = ["Ckeditor::Asset","Ckeditor::AttachmentFile","Ckeditor::Picture"]
  config.reload_between_requests = false
  
  config.models do
    fields_of_type :text do
      ckeditor true
      pretty_value do
        value.html_safe
      end
    end
    
    list do
      exclude_fields :created_at, :updated_at
    end
  end
  
  
  # Model-specific configurations
  config.model User do
    list do
      field :id do
        sortable true
      end

      field :email do
        sortable true
      end

      field :role do
        visible true
        filterable :title
        sortable :title
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
  end
end