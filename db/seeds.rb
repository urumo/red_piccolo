# frozen_string_literal: true

email = ENV.fetch('SUPERADMIN_EMAIL', 'admin@svck.dev')
password = ENV.fetch('SUPERADMIN_PASSWORD', 'P@ssw0rd')
admin = User.create!(email:, password:, role: :superadmin)

DomainServices::Chat::CreateChatService
  .call(admin,
        'Random', 'Абсолютно ненормальное общение, выяснение отношений, холивары, грязный юмор и всё то, что можно' \
          ' назвать Random')
