module Sunrise
  module Helper
    def html &block
      yield
    end

    def text text
      text
    end

    def method_missing(*args)
      element = args[0]
      options = args[1]
      return opening_tag(element).concat(closing_tag(element)) unless block_given?
      return opening_tag(element).concat(yield).concat(closing_tag(element)) unless options

      opening_tag(element, options).concat(yield).concat(closing_tag(element))
    end

    private

      def opening_tag(tag, options = nil)
        return "<#{tag}>" if options.nil?

        "<#{tag} #{attributes(options)}>"
      end

      def closing_tag(tag)
        "</#{tag}>"
      end

      def attributes(options)
        options.map { |key, value| key.to_s.concat('=').concat("\"#{value.to_s}\"") }.join(' ')
      end
  end
end
