# coding: UTF-8
require 'carrierwave/test/matchers'

describe TeaserImageUploader do
  include CarrierWave::Test::Matchers
  include ActionDispatch::TestProcess

  before do
    TeaserImageUploader.enable_processing = true
    @teaser = FactoryGirl.build :teaser
    @uploader = @teaser.image
    @uploader.store!(fixture_file_upload('spec/support/test_images/1.jpg', 'image/jpeg'))
  end

  after do
    TeaserImageUploader.enable_processing = false
    @uploader.remove!
  end

  # FIXME: если тест не прошел, то возникает ошибка: uninitialized constant TeaserImageUploader
  xit "should have proper dimensions" do
    dimensions = configus.teaser.dimensions
    dimensions.to_hash.each do |version_name, d|
      @uploader.send(version_name).should have_dimensions(d[:w], d[:h])
    end
  end

end