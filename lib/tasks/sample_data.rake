# Provide tasks to load and delete demo user data.
require 'active_record'
require 'active_record/fixtures'

namespace :db do
  DATA_DIRECTORY = "#{RAILS_ROOT}/lib/tasks/sample_data"
  namespace :sample_data do
    TABLES = %w(pd_users specs personal_lives professional_lives)
    MIN_USER_ID = 5000 # Starting user id for the sample data
    desc "Load sample data"
    
    task :load => :environment do |t|
      class_name = nil # Use nil to get Rails to figure out the class.
      TABLES.each do |table_name|
        fixture = Fixtures.new(ActiveRecord::Base.connection,
                               table_name,
                               class_name,
                               File.join(DATA_DIRECTORY, table_name.to_s))
        fixture.insert_fixtures
        puts "Loaded data from #{table_name}.yml"
      end
    end
  
    desc "Remove sample data"
    task :delete => :environment do |t|
      PDUser.delete_all("id >= #{MIN_USER_ID}")
      Spec.delete_all("user_id >= #{MIN_USER_ID}")
      PersonalLife.delete_all( "user_id >= #{MIN_USER_ID}")
      ProfessionalLife.delete_all( "user_id >= #{MIN_USER_ID}")
    end
  end
end