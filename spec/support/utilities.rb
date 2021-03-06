include ApplicationHelper

def full_title(page_title)
  base_title = "Ruby on Rails Tutorial Sample App"

 if page_title.empty?
  base_title
 else
  "#{base_title} | #{page_title}"
 end
end


#Filling in the form doesn’t work when not using Capybara, so to cover this case we allow the user to pass the option no_capyabara: true to override the default signin method and manipulate the cookies directly. This is necessary when using one of the HTTP request methods directly (get, post, patch, or delete)

def sign_in(user, options={})
  if options[:no_capybara]
    # Sign in when not using Capybara.
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else
    visit signin_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end
