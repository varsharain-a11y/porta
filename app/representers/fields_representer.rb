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
      [name, { getter: ->(*) { field_value(name) } }]
    end
  end
end
