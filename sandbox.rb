# Sample shopping cart hash
helloworld = {"1"=>{"quantity"=>1, "title"=>".Hack // Gu Last Recode   PlayStation 4 PS4", "price"=>"29.99"}, "2"=>{"quantity"=>1, "title"=>"11 11 Memories Retold (EU Import)   PlayStation 4 PS4", "price"=>"24.99"}}

helloworld.delete(1)
puts helloworld
puts helloworld.key?(1)