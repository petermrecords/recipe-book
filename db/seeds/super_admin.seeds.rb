super_admin = Admin.find_by(email: ENV['SUPER_ADMIN_EMAIL_ADDRESS'])

if super_admin
	puts "Super admin account is registered to #{super_admin.email}."
elsif !ENV['SUPER_ADMIN_EMAIL_ADDRESS']
  raise ArgumentError, "An email address for the super admin has not been provided - please add one to the environment prior to setup."
else
  while !(super_admin && super_admin.valid?)
  	super_admin = Admin.new({
  		first_name: "Super", 
  		last_name: "Admin", 
  		email: ENV['SUPER_ADMIN_EMAIL_ADDRESS']
  	})
    puts "Enter a super admin password:"
    super_admin.password = $stdin.gets.chomp
    puts "Confirm the super admin password:"
    super_admin.password_confirmation = $stdin.gets.chomp
    if super_admin.save
  	 puts "Super admin account created for #{ENV['SUPER_ADMIN_EMAIL_ADDRESS']}."
    else
      puts "Errors prevented the super admin account from being saved:"
      super_admin.errors.full_messages.each { |error| puts error }
    end
  end
end