# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_11_15_120240) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "discord_channels", force: :cascade do |t|
    t.string "server_id"
    t.string "channel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string "email"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "link_lists", force: :cascade do |t|
    t.integer "link_id", null: false
    t.integer "list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["link_id"], name: "index_link_lists_on_link_id"
    t.index ["list_id"], name: "index_link_lists_on_list_id"
  end

  create_table "links", force: :cascade do |t|
    t.text "link"
    t.string "title"
    t.text "description"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reaction_like", default: 0
    t.integer "reaction_dislike", default: 0
    t.integer "kind", default: 0
    t.string "blurhash"
    t.integer "status", default: 0
    t.index ["user_id"], name: "index_links_on_user_id"
  end

  create_table "links_tags", force: :cascade do |t|
    t.integer "link_id"
    t.integer "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["link_id"], name: "index_links_tags_on_link_id"
    t.index ["tag_id"], name: "index_links_tags_on_tag_id"
  end

  create_table "list_discord_channels", force: :cascade do |t|
    t.integer "list_id", null: false
    t.integer "discord_channel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discord_channel_id"], name: "index_list_discord_channels_on_discord_channel_id"
    t.index ["list_id", "discord_channel_id"], name: "index_list_discord_channels_on_list_id_and_discord_channel_id", unique: true
    t.index ["list_id"], name: "index_list_discord_channels_on_list_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.text "description"
    t.boolean "public"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_tags_on_slug", unique: true
  end

  create_table "user_links", force: :cascade do |t|
    t.integer "user_id"
    t.integer "link_id"
    t.integer "relationship_type", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["link_id"], name: "index_user_links_on_link_id"
    t.index ["user_id", "link_id", "relationship_type"], name: "index_user_links_on_user_id_and_link_id_and_relationship_type", unique: true
    t.index ["user_id"], name: "index_user_links_on_user_id"
  end

  create_table "user_lists", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "list_id", null: false
    t.integer "relationship_type", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_user_lists_on_list_id"
    t.index ["user_id"], name: "index_user_lists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "nickname"
    t.string "email"
    t.string "password_digest"
    t.text "meta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "link_lists", "links"
  add_foreign_key "link_lists", "lists"
  add_foreign_key "list_discord_channels", "discord_channels"
  add_foreign_key "list_discord_channels", "lists"
  add_foreign_key "user_lists", "lists"
  add_foreign_key "user_lists", "users"
end
