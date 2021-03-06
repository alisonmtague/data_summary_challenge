require "test_helper"

describe "Purchases integration" do
  it "import should successfully import file" do
    file_rows = <<-eos
    purchaser name	item description	item price	purchase count	merchant address	merchant name
    Snake Plissken	$10 off $20 of food	10.0 2	 987 Fake St	 Bob's Pizza
    Amy Pond	$30 of awesome for $10	10.0 5	 456 Unreal Rd	 Tom's Awesome Shop
    Marty McFly	$20 Sneakers for $5	5.0    1	 123 Fake St	 Sneaker Store Emporium
    Snake Plissken	$20 Sneakers for $5	5.0    4	 123 Fake St	 Sneaker Store Emporium
    eos

    file = Tempfile.new('example.tab')
    file.write(file_rows)
    file.rewind

    assert_difference "Purchase.count", 4 do
      post :import_purchases, :file => Rack::Test::UploadedFile.new(file)
    end

  end
end
