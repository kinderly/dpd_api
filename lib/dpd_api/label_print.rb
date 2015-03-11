# encoding: utf-8

require 'dpd_api/label_data'

module DpdApi
  class LabelPrint < Base
    class << self
      def create_label_file(params = {})
        response(:create_label_file, params, namespace: :get_label_file)
      end

      def create_label(params = {})
        response(:create_label, params, namespace: :get_label)
      end

      def create_local_labels(orders)
        labels = orders.map do |o|
          DpdApi::LabelData.new(o[:sender_name], o[:receiver_name], o[:order_number], o[:barcode], o[:dpd_number])
        end

        DpdApi::LabelData.render(labels)
      end

      protected

      def url
        "#{DpdApi.configuration.base_url}/services/label-print?wsdl"
      end
    end
  end
end
