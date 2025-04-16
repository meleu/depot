class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # TODO: (meleu) have a better understanding about this.
  # I didn't notice any change with/without this line
  include ActiveStorage::SetCurrent
end
