require "ice_cube"

module RecurringSelectHelper
  module FormHelper
    def select_recurring(object_name, method, rrule, options, html_options = {})
      RecurringSelectTag.new(object_name, method, self, rrule, options, html_options).render
    end
  end

  module FormBuilder
    def select_recurring(method, options = {}, html_options = {})
      unless @template.respond_to?(:select_recurring)
        @template.class.send(:include, RecurringSelectHelper::FormHelper)
      end

      @template.select_recurring(@object_name, method, @object.send(method), options.merge(:object => @object), html_options)
    end
  end

  module SelectRecurringHTMLOptions
    private

    def recurring_select_html_options(html_options, rrule)
      html_options = html_options.stringify_keys
      html_options["class"] = (html_options["class"].to_s.split + ["recurring_select"]).join(" ")

      unless rrule.blank?
        html_options["data"] ||= {}
        html_options["data"]["rrule-hash"] = rrule.to_hash
        html_options["data"]["rrule-string"] = rrule.to_s
      end

      html_options
    end
  end

  class RecurringSelectTag < ActionView::Helpers::Tags::HiddenField
    include SelectRecurringHTMLOptions
    include ActionView::Context

    def initialize(object_name, method, template_object, rrule, options, html_options = {})
      @rrule = rrule
      @object_name = object_name
      @method_name = method.to_s
      @html_options = recurring_select_html_options(html_options, rrule)
      add_default_name_and_id(@html_options)

      super(object_name, method, template_object, options)
    end

    def render
      content_tag :div, class: "recurring_select_group" do
        hidden_field_tag(@object_name, @rrule.to_json, @html_options) +
        content_tag(:span, @rrule.to_s, class: "summary") +
        content_tag(:a, "Edit", class: "edit")
      end
    end
  end
end
