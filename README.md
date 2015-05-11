mindcast-proxy
==============

Start the API server with

	RACK_ENV=production rackup

	rackup -o 0.0.0.0

add pub/private key stuff

https://stackoverflow.com/questions/12662902/ruby-openssl-asymmetric-encryption-using-two-key-pairs
https://stackoverflow.com/questions/9891708/ruby-file-encryption-decryption-with-private-public-keys

"2015-03-18T13:24:04Z"

GET /v1/products

GET /v1/product/{sku}

product {
	title: "Title",
	description: "Red Tara",
	short_description: "Red Tara",
	sku: "E005",
	price: "1.99",
	categories: ["cat1", "cat2"],
	image: "http://dev.getmajordomus.local/wp-content/uploads/2015/03/audio_book_5@2.png"
}