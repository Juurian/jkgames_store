ActiveAdmin.register ContactPage do
  permit_params :name, :email, :phone, :address, :message_text

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :name
      f.input :email
      f.input :phone
      f.input :address, as: :text
      f.input :message_text, as: :text
    end
    f.actions
  end
end
