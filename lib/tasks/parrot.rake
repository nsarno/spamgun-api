namespace :parrot do
  desc "Clean up scrapping & spamming jobs"
  task job_clear: :environment do
    Job.delete_all
  end

end
