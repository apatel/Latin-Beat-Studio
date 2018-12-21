RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)
  config.authorize_with do
    redirect_to main_app.root_path unless current_user.try(:admin?)
  end

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.label_methods.unshift(:display_name)

  config.model 'ClassType' do
    label 'Classes'
    field :name
    field :description
    field :active
    field :class_image
    field :purchase
    field :color, :color
  end

  config.model 'Instructor' do
    edit do
      field :name
      field :title
      field :playlist do
        label 'Playlist (Spofity embed code)'
      end
      field :user
      field :instructor_image
      field :fb_handle do
        label 'Facebook Title'
      end
      field :fb_link do
        label 'Facebook Link'
      end
      field :ig_handle do
        label 'Instagram Title'
      end
      field :ig_link do
        label 'Instagram Link'
      end
      field :bio, :ck_editor
      field :view_order
    end
  end

  config.model 'Pass' do
    label 'Packages'
  end

  config.model 'PassType' do
    label 'Package Type'
  end

  config.model 'StudioEvent' do
    label 'Events'
  end

  config.model 'Content' do
    label 'Custom Content'
  end
end
