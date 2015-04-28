# encoding: utf-8

require "spec_helper"

describe DpdApi::LabelPrint do

  context "local_labels" do
    let(:labels) { [ { sender_name: 'ООО Киндерли', receiver_name: 'Петров Алексей Иванович, 344018, Россия, г. Москва, ул. Верхняя масловка, д. 127 к. 2, кв. 26', order_number: 700001, barcode: 'KDL2096022', dpd_number: '03046124MOW'},
                              { sender_name: 'ООО Киндерли', receiver_name: 'Иванов Петр Алексеевич, 344108, Россия, г. Ростов-на-Дону, пер. Соборный, д. 61, кв.', order_number: 700002, barcode: 'KDL2096024', dpd_number: '03046123MOW'},
                              { sender_name: 'ООО Киндерли', receiver_name: 'Петров Владимир Константинович, 344018, Россия, г. Москва, пр-кт. Ленинградский, д. 200 к. 1, кв. 19', order_number: 700003, barcode: 'KDL2096023', dpd_number: '03046124MOW'}] }

    it 'renders single label' do
      labels.each_with_index do |label, i|
        expect do
          w = described_class.create_local_labels([label])
          File.open("/home/nu-hin/Desktop/dpd_#{i}.html", 'w') { |file| file.write(w) }
        end.not_to raise_error
      end
    end

    it 'renders multiple labels' do
      expect do
        w = described_class.create_local_labels(labels)
        File.open('/home/nu-hin/Desktop/dpd_m.html', 'w') { |file| file.write(w) }
      end.not_to raise_error
    end
  end
end
