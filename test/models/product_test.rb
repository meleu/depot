require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test 'attributes must not be empty' do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?, 'price must not be empty'
  end

  test 'price must be positive' do
    product = products(:valid_product)

    product.price = 0
    assert product.invalid?
    # assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]
    assert_equal [I18n.t('errors.messages.greater_than_or_equal_to', count: 0.01)], product.errors[:price]

    product.price = -1
    assert product.invalid?
    # assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]
    assert_equal [I18n.t('errors.messages.greater_than_or_equal_to', count: 0.01)], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  test 'image url' do
    product = products(:valid_product)

    good_names = %w[
      img.gif img.jpg img.png IMG.JPG IMG.Jpg http://a.b.c/x/y/z/img.gif
    ]
    bad_names = %w[
      img.doc img.gif/more img.gif.more
    ]

    good_names.each do |img_url|
      product.image_url = img_url
      assert product.valid?, "#{img_url} must be valid"
    end

    bad_names.each do |img_url|
      product.image_url = img_url
      assert product.invalid?, "#{img_url} must be invalid"
    end
  end

  test 'title is unique' do
    product = products(:ruby)
    title = product.title

    new_product = Product.new(
      title:,
      description: 'New Description',
      image_url: 'something.jpg',
      price: 9.99
    )

    assert new_product.invalid?
    assert_equal [I18n.t('errors.messages.taken')], new_product.errors[:title]
  end
end
