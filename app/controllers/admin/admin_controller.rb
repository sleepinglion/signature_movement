class Admin::AdminController < ApplicationController
    load_and_authorize_resource except: [:create]

    def current_ability
        @current_ability ||= AdminAbility.new(current_admin)
    end

    def resource_name
      :admin
    end

    def resource
      @resource ||= Admin.new
    end

    def devise_mapping
      @devise_mapping ||= Devise.mappings[:admin]
    end

    rescue_from CanCan::AccessDenied do |_exception|
        if current_user
            render file: "#{Rails.root}/public/403.html", status: 403, layout: false
        else
            redirect_to new_admin_session_path
        end
    end

    def layout
        if params[:no_layout]
            false
        else
            'admin/application'
        end
    end
end
