class ContactsController < ApplicationController
  load_and_authorize_resource

  def index
    @contacts = @contacts.where(category: params[:category]) if params[:category].present?
    @contacts = @contacts.order(:surname, :name)
  end

  def new
  end

  def create
    if @contact.save
      respond_to do |format|
        format.html { redirect_to contacts_path, notice: t('contacts.messages.created') }
        format.turbo_stream { flash.now[:notice] = t('contacts.messages.created') }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @contact.update(contact_params)
      respond_to do |format|
        format.html { redirect_to contacts_path, notice: t('contacts.messages.updated') }
        format.turbo_stream { flash.now[:notice] = t('contacts.messages.updated') }
        format.json { 
          render json: {
            id: @contact.id,
            name: @contact.name,
            surname: @contact.surname,
            email: @contact.email,
            phone: @contact.phone,
            category: @contact.category,
            category_display: t("contacts.categories.#{@contact.category}")
          }
        }
      end
    else
      respond_to do |format|
        format.html { redirect_to contacts_path, alert: t('contacts.messages.update_failed') }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("flash_messages", FlashComponent.new(message: t('contacts.messages.update_failed'), type: :alert)) }
        format.json { render json: { errors: @contact.errors }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_path, notice: t('contacts.messages.deleted') }
      format.turbo_stream { flash.now[:notice] = t('contacts.messages.deleted') }
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :surname, :email, :phone, :category)
  end
end
