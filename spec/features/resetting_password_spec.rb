require 'timecop'

feature 'Resetting Password' do
  let(:user) { User.first }
  before do 
    sign_up
    Capybara.reset!
    allow(SendRecoverLink).to receive(:call)
  end

  scenario 'it doesn\'t allow you to use the token after an hour' do
    recover_password
    Timecop.travel(60 * 60 * 60) do
      visit("/users/reset_password?token=#{user.password_token}")
      expect(page).to have_content "Your token is invalid"
    end
  end

  scenario 'When I forget my password I can see a link to reset' do
    visit '/sessions/new'
    click_link 'I forgot my password'
    expect(page).to have_content("Please enter your email address")
  end

  scenario 'When I enter my email I am told to check my inbox' do
    recover_password
    expect(page).to have_content "Thanks, Please check your inbox for the link."
  end

  scenario 'assigned a reset token to the user when they recover' do
    expect{recover_password}.to change{User.first.password_token}
  end

  scenario 'it asks for your new password when your token is valid' do
    recover_password
    visit("/users/reset_password?token=#{user.password_token}")
    expect(page).to have_content("Please enter your new password")
  end

  scenario 'it lets you enter a new password with a valid token' do
    recover_password
    set_password(password: "newpassword", password_confirmation: "newpassword")
    expect(page).to have_content("Please sign in")
  end

  scenario 'it lets you sign in after password reset' do
    recover_password
    set_password(password: "newpassword", password_confirmation: "newpassword")
    sign_in(email: "alice@example.com", password: "newpassword")
    expect(page).to have_content "Welcome, alice@example.com"
  end

  scenario 'it lets you know if your passwords don\'t match' do
    recover_password
    set_password(password: "newpassword", password_confirmation: "wrongpassword")
    expect(page).to have_content("Password does not match the confirmation")
  end

  scenario 'it immediately resets token upon successful password update' do
    recover_password
    set_password(password: "newpassword", password_confirmation: "newpassword")
    visit("/users/reset_password?token=#{user.password_token}")
    expect(page).to have_content("Your token is invalid")
  end

  scenario 'it calls the SendRecoverLink service to send the link' do
    expect(SendRecoverLink).to receive(:call).with(user)
    recover_password
  end

  def recover_password
    visit '/users/recover'
    fill_in :email, with: "alice@example.com"
    click_button "Submit"
  end

  def set_password(password:, password_confirmation:)
    visit("/users/reset_password?token=#{user.password_token}")
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    click_button "Submit"
  end
end
