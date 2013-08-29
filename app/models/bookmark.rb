class Bookmark < ActiveRecord::Base
  mount_uploader :screenshot, ScreenShotUploader
  acts_as_taggable

  has_many :colors

  after_create :take_screenshot

  def take_screenshot
    conn = Faraday.new(:url => "http://capture.heartrails.com/huge?#{ERB::Util.u(self.url)}") do |faraday|
      faraday.request  :url_encoded
      faraday.adapter  Faraday.default_adapter
    end

    response = nil

    18.times do
      break if (response = conn.get).status == 200
      sleep 5
    end
    file_name = File.join "tmp", "#{self.id}.jpeg"

    File.open(file_name, 'wb') do |file|
      file.write(response.body)
      self.screenshot = file
      self.save
    end

    File.unlink(file_name)
  end
end
