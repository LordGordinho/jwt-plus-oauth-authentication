class Api::Auth::SessionsController < DeviseTokenAuth::SessionsController
  protect_from_forgery with: :null_session, only: proc { |c| c.request.format.json? }
  skip_before_action :authenticate_user!

  def create
    if field = (resource_params.keys.map(&:to_sym) & resource_class.authentication_keys).first
      q_value = get_case_insensitive_field_from_resource_params(field)

      @resource = find_resource(field, q_value)
    end

    if @resource && valid_params?(field, q_value) && (!@resource.respond_to?(:active_for_authentication?) || @resource.active_for_authentication?)
      valid_password = @resource.valid_password?(resource_params[:password])
      if (@resource.respond_to?(:valid_for_authentication?) && !@resource.valid_for_authentication? { valid_password }) || !valid_password
        return render_create_error_bad_credentials
      end

      create_and_assign_token

      sign_in(@resource, scope: :user, store: false, bypass: false)

      yield @resource if block_given?

      render_create_success
    elsif @resource && !Devise.paranoid && !(!@resource.respond_to?(:active_for_authentication?) || @resource.active_for_authentication?)
      if @resource.respond_to?(:locked_at) && @resource.locked_at
        render_create_error_account_locked
      else
        render_create_error_not_confirmed
      end
    else
      hash_password_in_paranoid_mode
      render_create_error_bad_credentials
    end
  end

  private

  def find_resource(field, value)
    return resource_class.find_by('lower(username) = :value OR lower(email) = :value', { value: }) if field == :email_or_username
    return resource_class.dta_find_by(field => value, 'provider' => provider) unless database_adapter&.include?('mysql')

    field_sanitized = resource_class.connection.quote_column_name(field)
    resource_class.where("BINARY #{field_sanitized} = ? AND provider= ?", value, provider).first
  end
end
