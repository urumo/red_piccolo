# frozen_string_literal: true

email = ENV.fetch('SUPERADMIN_EMAIL', 'admin@svck.dev')
password = ENV.fetch('SUPERADMIN_PASSWORD', 'P@ssw0rd')
User.create!(email:, password:, role: :superadmin)
