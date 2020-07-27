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
      [
        name,
        {
          getter: ->(*) {
            v = field_value(name)
            # v.try(:to_xml, builder: ThreeScale::XML::Builder.new(skip_instruct: true)) || v.to_s.strip
            # v.try(:to_xml, builder: Nokogiri::XML::Builder.new, skip_instruct: true) || v.to_s.strip

            # xml = ThreeScale::XML::Builder.new(skip_instruct: true)
            # if v.respond_to?(:to_xml)
            #   v.to_xml(builder: xml, root: name)
            # else
            #   xml.__send__(:method_missing, name, v.to_s.strip)
            # end

            v
          }
        }
      ]
    end
  end
end
