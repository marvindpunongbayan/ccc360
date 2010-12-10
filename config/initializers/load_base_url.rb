file = Rails.root.join("config/base_url.txt")
$base_url = File.read(file).chomp if File.exists?(file)
