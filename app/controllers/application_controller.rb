class ApplicationController < ActionController::Base
    before_action :configure_permitted_params, if: :devise_controller?
    before_action :set_search
    
    def set_search
        @q = Room.ransack(params[:q])
        @rooms = @q.result(distinct: true)
    end
    
    protected
    def configure_permitted_params
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction, :image_icon])
    end
end
