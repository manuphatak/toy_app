# frozen_string_literal: true

# Create an In-memory Temporary ActiveRecord Table
# http://blog.spoolz.com/2015/02/05/create-an-in-memory-temporary-activerecord-table-for-testing/
RSpec.configure do |config|
  config.shared_context_metadata_behavior = :apply_to_host_groups
end

RSpec.shared_context :with_temporary_table do
  def self.with_temporary_table(&block)
    before(:context) do
      ActiveRecord::Migration.verbose = false # don't output all the migration activity
      # switch the active database connection to an SQLite, in-memory database
      ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
      ActiveRecord::Schema.define(version: 1) { instance_eval(&block) }
    end

    after(:context) do
      ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['test'])
    end
  end
end

RSpec.configure do |config|
  config.include_context :with_temporary_table
end
