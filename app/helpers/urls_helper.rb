module UrlsHelper
  def notification_class(type)
    case type
    when 'alert'
      'border-red-500 bg-red-50 text-red-500'
    when 'notice'
      'border-blue-500 bg-blue-50 text-blue-500'
    when 'success'
      'border-green-500 bg-green-50 text-green-500'
    when 'error'
      'border-red-500 bg-red-50 text-red-500'
    when 'warning'
      'border-yellow-500 bg-yellow-50 text-yellow-500'
    when 'info'
      'border-blue-500 bg-blue-50 text-blue-500'
    else
      'border-gray-500 bg-gray-50 text-gray-500'
    end
  end
end
