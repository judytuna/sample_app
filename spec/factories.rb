# By using the symbol ':user', we get Factory Girl to simulate the User model.
# We'll be able to create a User factory in the tests like this: 
#    @user = Factory(:user) 
# @user will simulate an instance of User.

Factory.define :user do |user|
  user.name "Michael Hartl"
  user.email "mhartl@example.com"
  user.password "foobar"
  user.password_confirmation "foobar"
end
