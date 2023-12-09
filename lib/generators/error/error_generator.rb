# frozen_string_literal: true

class ErrorGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def create_error_file
    template 'error.template', "app/errors/domain_errors/#{file_path}_error.rb"
  end

  def modify_locale_file
    append_to_file 'config/locales/en.yml',
                   "    #{name.underscore.split('/').join('_')}: '#{ApplicationError::DEFAULT_ERROR_MESSAGE}'\n",
                   after: "errors:\n"
  end

  argument :name, type: :string
end
