class ContactFormComponent < ViewComponent::Base
  def initialize(contact:, url:, method: :post)
    @contact = contact
    @url = url
    @method = method
  end

  private

  attr_reader :contact, :url, :method

  def category_options
    Contact.categories.map do |key, value|
      [I18n.t("contacts.categories.#{key}"), key]
    end
  end

  def submit_text
    contact.persisted? ? I18n.t('contacts.form.update') : I18n.t('contacts.form.create')
  end
end
