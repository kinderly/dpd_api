# encoding: utf-8

require "spec_helper"

describe DpdApi::LabelPrint do

  context "local_labels" do
    let(:single_label) { [ { sender_name: 'ООО Вектор', receiver_name: 'Иванов Петр Алексеевич', order_number: 344019, barcode: 1234567} ] }
    let(:multiple_labels) { [ { sender_name: 'ООО Вектор', receiver_name: 'Иванов Петр Алексеевич', order_number: 344019, barcode: 1234567},
                              { sender_name: 'ООО Вектор', receiver_name: 'Петров Алексей Иванович', order_number: 344020, barcode: 1234568}] }

    it "renders single label" do
      expect do
        w = described_class.create_local_labels(single_label)
        File.open('/home/nu-hin/Desktop/dpd.html', 'w') { |file| file.write(w) }
      end.not_to raise_error
    end

    it "renders multiple labels" do
      expect do
        w = described_class.create_local_labels(multiple_labels)
        File.open('/home/nu-hin/Desktop/dpd_m.html', 'w') { |file| file.write(w) }
      end.not_to raise_error
    end
  end
end
