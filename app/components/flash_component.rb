class FlashComponent < ViewComponent::Base
  def initialize(message:, type:)
    @message = message
    @type = type
  end

  private

  attr_reader :message, :type

  def css_classes
    case type.to_s
    when 'notice'
      'alert alert-success'
    when 'alert'
      'alert alert-error'
    when 'warning'
      'alert alert-warning'
    else
      'alert alert-info'
    end
  end
end
