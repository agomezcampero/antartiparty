module AuthConcern
  extend ActiveSupport::Concern

  included do
    def check_user_signed_in
      redirect_to new_user_session_path unless current_user
    end
  end
end
