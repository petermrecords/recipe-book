super_admin = Admin.find_by(email: ENV['SUPER_ADMIN_EMAIL_ADDRESS'])

if super_admin
	puts "Super admin account found."
else
	Admin.create({
		first_name: "Super", 
		last_name: "Admin", 
		email: ENV['SUPER_ADMIN_EMAIL_ADDRESS'],
		password: ENV['SUPER_ADMIN_PASSWORD']
	})
	puts "Super admin account created for #{ENV['SUPER_ADMIN_EMAIL_ADDRESS']}."
end