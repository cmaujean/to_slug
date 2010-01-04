module ToSlug
  
  # Generate a slug for the string +value+.
  #
  # A slug should consist of numbers (0-9), lowercase letters (a-z) and 
  # dashes (-). Any other characters should be filtered.
  #
  # ==== Example
  #
  #   "The World is Beautiful!".to_slug # => "the-world-is-beautiful"
  #
  # ==== Returns
  # String:: A 'sluggified' version of this string
  #
  # --
  # @api public
  def to_slug
    # Perform transliteration to replace non-ascii characters with an ascii
    # character
    value = self.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n, '').to_s
    
    # Remove single quotes and backticks from input
    value.gsub!(/['`]+/, '')

    # @ --> at, and & --> and
    value.gsub! /\s*@\s*/, " at "
    value.gsub! /\s*&\s*/, " and "

    # Replace any non-word character (\W) with a space
    value.gsub!(/\W+/, ' ')
    
    # Remove any whitespace before and after the string
    value.strip!
    
    # All characters should be downcased
    value.downcase!
    
    # Replace spaces with dashes
    value.gsub!(' ', '-')
  
    #convert double dashes to single
    value.gsub! /-+/,"-"

    #convert double underscores to single
    value.gsub! /_+/,"_"

    #strip off leading/trailing dashes and underscores
    value.gsub! /\A[-_\.]+|[-_\.]+\z/,""

    # Return the resulting slug
    value
  end
  
end