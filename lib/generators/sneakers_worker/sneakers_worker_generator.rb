# frozen_string_literal: true

class SneakersWorkerGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def create_worker_file
    template 'worker.template', "app/workers/#{file_path}_worker.rb"
    template 'worker_spec.template', "spec/workers/#{file_path}_worker_spec.rb"
  end

  argument :name, type: :string
end
