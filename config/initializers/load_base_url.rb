file = Rails.root.join("base_url.txt")
$base_url = File.read(file).chomp if File.exists?(file)
