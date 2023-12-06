ActiveAdmin.register Game do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :platform, :description, :genre, :price, :esrb_rating, :manufacturer, :release_date, :weight, :stock, :images
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :platform, :description, :genre, :price, :esrb_rating, :manufacturer, :release_date, :weight, :stock]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form do |f|
    f.semantic_errors
    # f.inputs = all the inputs of the form title, platform etc
    f.inputs
    f.inputs do
      f.input :images, as: :file, hint: f.object.images.attached? ? f.object.images.map { |i| image_tag(i) }.join('<br>').html_safe : content_tag(:span, 'No images yet')
    end
    f.actions
  end
end