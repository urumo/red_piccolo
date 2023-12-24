# frozen_string_literal: true

class PresenterGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def create_presenter_file
    template 'presenter.template', File.join('app/services/presenters', class_path, "#{file_name}_presenter.rb")
    template 'presenter_spec.template',
             File.join('spec/services/presenters', class_path, "#{file_name}_presenter_spec.rb")
  end

  def create_directories
    FileUtils.mkdir_p('app/services/presenters') unless File.directory?('app/services/presenters')

    FileUtils.mkdir_p('spec/services/presenters') unless File.directory?('spec/services/presenters')
  end

  argument :name, type: :string
  argument :attributes, type: :array, default: [], banner: 'field:type field:type'
end
