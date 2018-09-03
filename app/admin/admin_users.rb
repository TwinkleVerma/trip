ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end

ActiveAdmin.register Airline do
  permit_params :name, image_attributes: [:avatar]
  config.per_page = 10

  form do |f|
    f.inputs  do
      f.input :name

      f.object.build_image unless f.object.image

      f.semantic_fields_for :image do |l|
        l.input :avatar
      end

    end
    f.actions
  end
end

ActiveAdmin.register User do
  permit_params :name, :contact, :password, :email
  config.per_page = 10

end


ActiveAdmin.register Booking do

  config.per_page = 10

end
