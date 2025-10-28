default_user = User.find_or_create_by!(email: 'admin@contactboard.com') do |user|
  user.password = 'password123'
  user.password_confirmation = 'password123'
end

puts "Default user created: #{default_user.email}"

contacts_data = [
  { name: 'Anna', surname: 'Kowalska', email: 'anna.kowalska@example.com', phone: '+48 123 456 789', category: 'family' },
  { name: 'Jan', surname: 'Nowak', email: 'jan.nowak@example.com', phone: '+48 987 654 321', category: 'work' },
  { name: 'Maria', surname: 'Wiśniewska', email: 'maria.wisniewska@example.com', phone: '+48 555 123 456', category: 'friends' },
  { name: 'Piotr', surname: 'Wójcik', email: 'piotr.wojcik@example.com', phone: '+48 777 888 999', category: 'work' },
  { name: 'Katarzyna', surname: 'Kowalczyk', email: 'katarzyna.kowalczyk@example.com', phone: '+48 111 222 333', category: 'family' },
  { name: 'Tomasz', surname: 'Kamiński', email: 'tomasz.kaminski@example.com', phone: '+48 444 555 666', category: 'friends' },
  { name: 'Agnieszka', surname: 'Lewandowska', email: 'agnieszka.lewandowska@example.com', phone: '', category: 'work' },
  { name: 'Michał', surname: 'Zieliński', email: 'michal.zielinski@example.com', phone: '+48 999 888 777', category: 'family' }
]

contacts_data.each do |contact_attrs|
  contact = Contact.find_or_create_by!(email: contact_attrs[:email]) do |c|
    c.name = contact_attrs[:name]
    c.surname = contact_attrs[:surname]
    c.phone = contact_attrs[:phone]
    c.category = contact_attrs[:category]
  end
  puts "Contact created: #{contact.name} #{contact.surname} (#{contact.category})"
end

puts "Created #{Contact.count} contacts total"
