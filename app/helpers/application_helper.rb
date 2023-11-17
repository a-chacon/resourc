module ApplicationHelper
  include Pagy::Frontend

  def kind_to_color_class(kind)
    case kind
    when 'article'
      'bg-gradient-to-r from-teal-400 to-cyan-600 text-white' # Teal and Cyan gradient
    when 'video'
      'bg-gradient-to-r from-pink-400 to-red-600 text-white' # Pink and Red gradient
    when 'podcast'
      'bg-gradient-to-r from-indigo-400 to-blue-600 text-white' # Indigo and Blue gradient
    when 'course'
      'bg-gradient-to-r from-orange-300 to-yellow-500 text-white' # Orange and Yellow gradient
    when 'tool'
      'bg-gradient-to-r from-purple-400 to-indigo-600 text-white' # Purple and Indigo gradient
    when 'ebook'
      'bg-gradient-to-r from-green-400 to-lime-600 text-white' # Green and Lime gradient
    when 'documentation'
      'bg-gradient-to-r from-yellow-400 to-amber-600 text-white' # Yellow and Amber gradient
    when 'presentation'
      'bg-gradient-to-r from-blue-400 to-cyan-600 text-white' # Blue and Cyan gradient
    when 'template'
      'bg-gradient-to-r from-red-400 to-orange-600 text-white' # Red and Orange gradient
    when 'community'
      'bg-gradient-to-r from-cyan-400 to-teal-600 text-white' # Cyan and Teal gradient
    when 'event'
      'bg-gradient-to-r from-brown-400 to-orange-600 text-white' # Brown and Orange gradient
    when 'talk'
      'bg-gradient-to-r from-gray-400 to-cool-gray-600 text-white' # Gray gradient
    when 'library'
      'bg-gradient-to-r from-gray-400 to-warm-gray-600 text-white' # Gray gradient
    when 'tutorial'
      'bg-gradient-to-r from-yellow-300 to-amber-500 text-white' # Light yellow and Amber gradient
    when 'newsletter'
      'bg-gradient-to-r from-blue-400 to-indigo-600 text-white' # Blue and Indigo gradient
    when 'other'
      'bg-gradient-to-r from-gray-400 to-warm-gray-600 text-white' # Gray gradient
    else
      'bg-gray-300 text-black' # Default color for unknown kinds
    end
  end
end
