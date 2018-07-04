namespace :category do
  desc "Add new category to database"

  task :add, [:val] => [:environment] do |task, args|
    Category.find_or_create_by(category_name: args[:val])
  end
end
