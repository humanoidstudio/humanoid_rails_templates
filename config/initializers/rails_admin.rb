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
      
      fields_of_type :has_one_association do
        pretty_value do
          if value
            bindings[:view].link_to(value.to_s, 
                                    "/admin/#{value.class.name.pluralize.underscore}/#{value.id}")
          end
        end
      end
    end
    
    show do
      fields_of_type :has_many_association do
        pretty_value do
          bindings[:view].render :partial => 'show_association',
                                 :locals  => { :field => self }
        end
      end
      
      fields_of_type :has_one_association do
        pretty_value do
          if value
            bindings[:view].link_to(value.to_s, 
                                    "/admin/#{value.class.name.pluralize.underscore}/#{value.id}")
          end
        end
      end
    end
  end
end