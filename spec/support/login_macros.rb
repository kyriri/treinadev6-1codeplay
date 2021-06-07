module LoginMacros
  def user_login(user = User.create!(email: 'happy@table.com',
                                     password: 'chocolate123',
                                    ),
                 scope = :user)
    login_as user, scope: scope
    user # so it's possible to do user = user_login and use it on tests
  end
end