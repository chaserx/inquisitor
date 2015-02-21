class RouteConstraints::UserRequiredConstraint
  include RouteConstraints::UserConstraint

  def matches? request
    user = current_user(request)
    user.present?
  end
end
