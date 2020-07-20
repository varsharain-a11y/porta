module FieldsRepresenter
  def representable_attrs
    # Representable::Config#clone does not work, just create new one and inherit it
    attrs = Representable::Config.new.inherit!(super)
    representable_fields_attrs.each do |(name, options)|
      attrs.add(name, options)
    end
    attrs
  end

  def representable_fields_attrs
    Array(represented.try(:defined_builtin_fields)).map do |field|
      name = field.name
      # TODO: this is wrong for JSON!
      [name, { getter: ->(*) { v = field_value(name); v.try(:to_xml, skip_instruct: true, root: name) || v.to_s.strip } }]
    end
  end
end
