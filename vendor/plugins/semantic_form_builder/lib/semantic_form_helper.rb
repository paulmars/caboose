module SemanticFormHelper

  def wrapping(type, field_name, label, field, options = {})
    help = %Q{<span class="help">#{options[:help]}</span>} if options[:help]
    to_return = []
    to_return << %Q{<div class="#{type}-field #{options[:class]}">}
    to_return << %Q{<label for="#{field_name}">#{label}#{help}</label>} unless ["radio","check", "submit"].include?(type)
    to_return << %Q{<div class="input">}
    to_return << field
    to_return << %Q{<label for="#{field_name}">#{label}</label>} if ["radio","check"].include?(type)
    to_return << %Q{</div></div>}
  end

  def semantic_group(type, field_name, label, fields, options = {})
    help = %Q{<span class="help">#{options[:help]}</span>} if options[:help]
    to_return = []
    to_return << %Q{<div class="#{type}-fields #{options[:class]}">}
    to_return << %Q{<label for="#{field_name}">#{label}#{help}</label>}
    to_return << %Q{<div class="input">}
    to_return << fields.join
    to_return << %Q{</div></div>}
  end

  def boolean_field_wrapper(input, name, value, text, help = nil)
    field = []
    field << %Q{<label>#{input} #{text}</label>}
    field << %Q{<div class="help">#{help}</div>} if help
    field
  end

  def check_box_tag_group(name, values, options = {})
    selections = []
    values.each do |item|
      if item.is_a?(Hash)
        value = item[:value]
        text = item[:label]
        help = item.delete(:help)
      else
        value = item
        text = item
      end
      box = check_box_tag(name, value)
      selections << boolean_field_wrapper(box, name, value, text)
    end
    label = options[:label]
    semantic_group("check-box", name, label, selections, options)
  end

  def semantic_form_left_column_size(size, unit = "em")
    <<-FORMSIZE
    <style type="text/css">
      form.semantic_form div.check-box-field label, form.semantic_form div.check-box-fields label, form.semantic_form div.date-field label, form.semantic_form div.datetime-field label, form.semantic_form div.file-field label, form.semantic_form div.password-field label, form.semantic_form div.radio-field label, form.semantic_form div.radio-fields label, form.semantic_form div.select-field label, form.semantic_form div.text-field label, form.semantic_form div.textarea-field label, form.semantic_form div.time-zone-select-field label, form.semantic_form div.submit-field label {width: #{size}#{unit};}
      form.semantic_form div.submit-field div.input { margin-left:#{size}.3#{unit}; }
   </style>
    FORMSIZE
  end

  def semantic_form_for(object_name, *args, &proc)
    args[0] ||= {}
    args[0][:builder] ||= SemanticFormBuilder
    args[0][:html]    ||= {}
    args[0][:html][:class] ||= ""
    args[0][:html][:class] += "semantic_form"
    form_for(object_name, *args, &proc)
  end

end
