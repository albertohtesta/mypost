def hash_order_key(hash)
	new_hash = hash.sort.to_h
	return new_hash
end

hash = { abc: 'hello', another_key: 123, 4567 => 'third' }
puts hash_order_key(hash)


=begin
Escribe una función que ordene las llaves (keys) de un hash por la lóngitud de la llave.
{ abc: 'hello', another_key: 123, 4567 => 'third' }
should result in:

["abc", "4567", "another_key"]
=end