Sequel.migration do
  up do
    create_table(:headers) do
      primary_key :id
      column :name, 'text'
      column :value, 'text', null: false
      column :report_id, 'integer'
    end

    create_table(:links) do
      primary_key :id
      column :name, 'text'
      column :href, 'text'
      column :rel, 'text'
      column :target, 'text'
      column :report_id, 'integer'
    end

    create_table(:reports) do
      primary_key :id
      column :url, 'text', null: false
      column :created_at, 'integer', null: false
      column :links_count, 'integer', null: false
      column :remote_ip, 'cidr', null: false
      column :country, 'text', null: false
    end

    create_table(:users) do
      primary_key :id
      column :name, 'text', null: false
      column :password, 'text', null: false
      column :ip, 'cidr', null: false
    end
  end

  down do
    drop_table(:headers)
    drop_table(:links)
    drop_table(:reports)
    drop_table(:users)
  end
end
