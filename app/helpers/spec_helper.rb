module SpecHelper
  
  #***************************************************************#
  #******     C O N S T A N T     D E C L A R A T I O N     ******#
  #***************************************************************#    
  DB_STRING_MAX_LENGTH = 255
  HTML_TEXT_FIELD_SIZE = 15  
  
  # Define a custom function called "text_field_for", which makes a text
  # field based on the form object and the name of the field.
  # Its purpose is to generate HTML of the form
  # <div class="form_row">
  #   <label for="last_name">Last name</label>
  #   <input id="spec_last_name" maxlength="255" name="spec[last_name]" 
  #    size="15" type="text" value="Bar" />
  # </div>
  # using code like  <%= text_field_for form, "Last name" %>  
  def text_field_for(form, 
                     field,
                     size=HTML_TEXT_FIELD_SIZE,
                     maxlength=DB_STRING_MAX_LENGTH)
                     
    label = content_tag("label", "#{field.humanize} :", :for => field)
    form_field = form.text_field field, :size => size, :maxlength => maxlength
    
    # Use content_tag function to form the relevant tags, rather than explicitly
    # using strings such as "<label>". This way, we don't have to worry about closing
    # tags, since content_tag does it for us    
    content_tag("div", "#{label} #{form_field}", :class => "form_row")
  end
  
end