require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/svg_outputter'
require 'base64'
require 'erb'

module DpdApi
  class LabelData < Struct.new(:sender_name, :receiver_name, :order_number, :barcode, :dpd_number)

    def barcode_svg(height = 45)
      barby = Barby::Code128.new(self.barcode.to_s)
      barby.to_svg(xdim: 1.5, margin: 0, height: height)
    end

    def self.render(labels, template = nil)
      renderer = ERB.new(template || default_template)
      @labels = Array(labels).select{|l| l.is_a?(self)}
      renderer.result(binding)
    end

    def logo_base_64
      @logo ||= "data:image/jpg;base64,#{Base64.encode64(File.binread(self.class.logo))}"
    end

    protected

    def self.default_template
      File.read(default_erb)
    end

    def self.path(filename)
      File.join(File.dirname(File.expand_path(__FILE__)), filename)
    end

    def self.default_erb
      path('../templates/label.html.erb')
    end

    def self.logo
      path('../assets/logo.jpg')
    end
  end
end
