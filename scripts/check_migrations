#!/usr/bin/env ruby

# frozen_string_literal: true

# Original author of this script: SiebeJan Stoker
class Worker
  def initialize
  end

  def work
    puts remove_migrations_not_on_disk_sql
  end

  def migrations_on_disk
    `ls -1 db/migrate`.split("\n").map do |migration_file|
      "'#{migration_file.match(/\d{14}/)[0]}'"
    end
  end

  def remove_migrations_not_on_disk_sql
    'delete from schema_migrations where version not in'\
      "(#{migrations_on_disk.join ','});"
  end
end

Worker.new.work
