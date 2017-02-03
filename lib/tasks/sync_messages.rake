namespace :user do
  desc 'Synchronize sent messages'
  task :sync_messages => :environment do
    Rails.logger.info "Synchronization Started."
    User.all.each do |user|
      Rails.logger.info "Synchronizing sent messages of: #{user.email}"
      user.sync_sent_messages
    end
    Rails.logger.info "Synchronization Completed."
  end
end