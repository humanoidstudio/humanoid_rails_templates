RailsAdmin.config do |config|
  config.excluded_models = ["Ckeditor::Asset","Ckeditor::AttachmentFile","Ckeditor::Picture"]
  config.models do
      edit do
        field :email, :text do
          ckeditor true
        end
      end
    end
end