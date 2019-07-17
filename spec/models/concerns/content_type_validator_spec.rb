# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContentTypeValidator, type: :concern do
  with_temporary_table do
    create_table :active_storage_blobs do |t|
      t.string   :key, null: false
      t.string   :filename, null: false
      t.string   :content_type
      t.text     :metadata
      t.bigint   :byte_size,  null: false
      t.string   :checksum,   null: false
      t.datetime :created_at, null: false

      t.index [:key], unique: true
    end

    create_table :active_storage_attachments do |t|
      t.string     :name,     null: false
      t.references :record,   null: false, polymorphic: true, index: false
      t.references :blob,     null: false

      t.datetime :created_at, null: false

      t.index %i[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness', unique: true
      t.foreign_key :active_storage_blobs, column: :blob_id
    end
    create_table :people
  end

  class Person < ApplicationRecord
    has_one_attached :avatar
    validates :avatar, content_type: ['image/png', 'image/jpeg']
  end

  let(:person) { Person.new(avatar: avatar) }

  context 'given no avatar' do
    let(:avatar) { nil }

    it 'is valid' do
      aggregate_failures do
        expect(person).to be_valid
        expect(person.errors.full_messages).to be_empty
      end
    end
  end

  context 'given a matched content type' do
    let(:avatar) { upload('cat.png') }

    it 'is valid' do
      aggregate_failures do
        expect(person).to be_valid
        expect(person.errors.full_messages).to be_empty
      end
    end
  end

  context 'given a mismatched content type' do
    let(:avatar) { upload('cat.gif') }

    it 'is valid' do
      aggregate_failures do
        expect(person).not_to be_valid
        expect(person.errors.full_messages).to include('Avatar attatchment is not a valid file format')
      end
    end
  end

  def upload(fixture)
    { io: File.open(file_fixture(fixture)), filename: fixture }
  end
end
