require 'rails_helper'

RSpec.feature 'User Authentication', type: :feature do
  let!(:user) { create(:user, email: 'test@example.com', password: 'password123') }

  scenario 'User visits homepage and gets redirected to login page' do
    visit root_path
    
    expect(page).to have_current_path(new_user_session_path)
    expect(page).to have_content('Zaloguj się')
  end

  scenario 'User successfully logs in with valid credentials' do
    visit new_user_session_path
    
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Hasło', with: 'password123'
    click_button 'Zaloguj się'
    
    expect(page).to have_content('Pomyślnie zalogowano')
    expect(page).to have_current_path(contacts_path)
    expect(page).to have_content('Kontakty')
  end

  scenario 'User fails to log in with invalid credentials' do
    visit new_user_session_path
    
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Hasło', with: 'wrongpassword'
    click_button 'Zaloguj się'
    
    expect(page).to have_content('Nieprawidłowy Email lub hasło')
    expect(page).to have_current_path(new_user_session_path)
  end

  scenario 'User fails to log in with non-existent email' do
    visit new_user_session_path
    
    fill_in 'Email', with: 'nonexistent@example.com'
    fill_in 'Hasło', with: 'password123'
    click_button 'Zaloguj się'
    
    expect(page).to have_content('Nieprawidłowy Email lub hasło')
    expect(page).to have_current_path(new_user_session_path)
  end

  scenario 'User successfully logs out' do
    sign_in user
    visit contacts_path
    
    click_link 'Wyloguj się'
    
    expect(page).to have_content('Pomyślnie wylogowano')
    expect(page).to have_current_path(new_user_session_path)
  end
end
