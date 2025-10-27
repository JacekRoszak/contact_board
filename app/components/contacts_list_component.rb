class ContactsListComponent < ViewComponent::Base
  def initialize(contacts:)
    @contacts = contacts
  end

  private

  attr_reader :contacts

  def any_contacts?
    contacts.any?
  end
end
