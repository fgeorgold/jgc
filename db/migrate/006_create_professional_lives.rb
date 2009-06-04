class CreateProfessionalLives < ActiveRecord::Migration
  def self.up
    create_table :professional_lives do |t|
      t.column :pd_user_id, :integer, :null => false
      t.column :current_employee,             :text
      t.column :start_date,                   :date
      t.column :past_work_experience,         :text
      t.column :years_of_work,                :float      
      t.column :social_activities,            :text
      t.column :skills,                       :text
      t.column :future_plans,                 :text
      t.column :desired_job_description,      :text
      t.column :desired_salary_per_year,      :integer
    end
  end

  def self.down
    drop_table :professional_lives
  end
end
