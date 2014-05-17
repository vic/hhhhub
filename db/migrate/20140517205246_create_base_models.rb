class CreateBaseModels < ActiveRecord::Migration
  def change
    
    add_column :users, :name, :string, null: false
    add_column :users, :location, :string
    add_column :users, :homepage, :string
    add_column :users, :hacker,  :boolean, null: false, default: false
    add_column :users, :hispter, :boolean, null: false, default: false
    add_column :users, :hustler, :boolean, null: false, default: false

    create_table :identities do |t|
      t.string     :provider, null: false
      t.string     :uid,      null: false
      t.string     :url
      t.string     :name
      t.string     :email
      t.string     :token
      t.string     :secret
      t.belongs_to :user
      t.timestamps
    end
    add_foreign_key :identities, :users

    create_table :links do |t|
      t.string  :title, null: false
      t.string  :description, null: false, default: ""
      t.string  :url, null: false
      t.belongs_to :user
      t.timestamps
    end
    add_foreign_key :links, :users

    create_table :events do |t|
      t.string :title, null: false
      t.string :description, null: false, default: ""
      t.datetime :starts_at, null: false
      t.datetime :ends_at
      t.string :location
      t.string :address
      t.string :url
      t.belongs_to :user
      t.timestamps
    end
    add_foreign_key :events, :users

    create_table :event_attendees do |t|
      t.belongs_to :user
      t.belongs_to :event
      t.boolean    :confirmed, null: false, default: false
      t.timestamp  :arrived_at
    end

  end
end
