namespace :admin do
    desc "Create default admin user"
    task create: :environment do
      User.find_or_create_by!(email: "sfanelli@xyz.com") do |user|
        user.password = "Teach1"
        user.password_confirmation = "Teach1"
      end
      puts "Admin user created or already exists."
    end
  end
  