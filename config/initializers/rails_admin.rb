RailsAdmin.config do |config|
  # Global configuration
  config.excluded_models = ["Ckeditor::Asset","Ckeditor::AttachmentFile","Ckeditor::Picture"]
  config.reload_between_requests = true
  config.compact_show_view = false
  
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
  
end