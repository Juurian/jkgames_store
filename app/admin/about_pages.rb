ActiveAdmin.register AboutPage do
  permit_params :headline, :self_intro, :why_us, :stores_addresses, :store_hours

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :headline
      f.input :self_intro, as: :text
      f.input :why_us, as: :text
      f.input :stores_addresses, as: :text
      f.input :store_hours, as: :text
    end
    f.actions
  end
end
