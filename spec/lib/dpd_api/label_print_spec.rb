# encoding: utf-8

require "spec_helper"

describe DpdApi::LabelPrint do

  context "local_labels" do
    let(:single_label) { [ { sender_name: 'ООО Киндерли', receiver_name: 'Петров Алексей Иванович, 344018, Россия, г. Москва, ул. Верхнаяя масловка, д. 127 к. 2, кв. 26', order_number: 132947, barcode: '2096022', dpd_number: '03046124MOW'} ] }
    let(:multiple_labels) { [ { sender_name: 'ООО Вектор', receiver_name: 'Иванов Петр Алексеевич', order_number: 344019, barcode: '2096022', dpd_number: '03046123MOW'},
                              { sender_name: 'ООО Вектор', receiver_name: 'Петров Алексей Иванович, 344018, Россия, г. Москва, ул. Верхнаяя масловка, д. 127 к. 2, кв. 26', order_number: 344020, barcode: '2096022', dpd_number: '03046124MOW'}] }

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
