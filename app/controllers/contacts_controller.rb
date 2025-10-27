class ContactsController < ApplicationController
  load_and_authorize_resource

  def index
    @contacts = @contacts.order(:surname, :name)
  end

  def show
  end

  def new
  end

  def create
    if @contact.save
      redirect_to contacts_path, notice: t('contacts.messages.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @contact.update(contact_params)
      redirect_to contacts_path, notice: t('contacts.messages.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @contact.destroy
    redirect_to contacts_path, notice: t('contacts.messages.deleted')
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :surname, :email, :phone, :category)
  end
end
