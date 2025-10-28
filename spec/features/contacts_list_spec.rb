require 'rails_helper'

RSpec.feature 'Contacts List', type: :feature do
  let!(:user) { create(:user, email: 'test@example.com', password: 'password123') }
  let!(:contacts) { create_list(:contact, 10) }

  scenario 'User logs in and sees contacts list' do
    visit root_path
    
    expect(page).to have_current_path(new_user_session_path)
    
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Hasło', with: 'password123'
    click_button 'Zaloguj się'
    
    expect(page).to have_current_path(contacts_path)
    expect(page).to have_content('Kontakty')
    
    contacts.each do |contact|
      expect(page).to have_content(contact.name)
      expect(page).to have_content(contact.surname)
      expect(page).to have_content(contact.email)
    end
    
    expect(page).to have_css('tbody tr', count: 10)
  end

  scenario 'User sees empty state when no contacts exist' do
    Contact.destroy_all
    
    visit new_user_session_path
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Hasło', with: 'password123'
    click_button 'Zaloguj się'
    
    expect(page).to have_content('Brak kontaktów')
    expect(page).to have_content('Kontakty(0)')
    expect(page).not_to have_css('tbody tr')
  end

  scenario 'User can filter contacts by category' do
    family_contact = create(:contact, :family, name: 'Unique_Jan', surname: 'Kowalski')
    work_contact = create(:contact, :work, name: 'Unique_Anna', surname: 'Nowak')
    
    visit new_user_session_path
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Hasło', with: 'password123'
    click_button 'Zaloguj się'
    
    expect(page).to have_css('tbody tr', count: 12)
    
    visit contacts_path(category: 'family')
    
    expect(page).to have_content('Unique_jan')
    expect(page).to have_content('Kowalski')
    expect(page).not_to have_content('Unique_anna')
    
    visit contacts_path(category: 'work')
    
    expect(page).to have_content('Unique_anna')
    expect(page).to have_content('Nowak')
    expect(page).not_to have_content('Unique_jan')
    
    visit contacts_path
    
    expect(page).to have_css('tbody tr', count: 12)
  end
end
