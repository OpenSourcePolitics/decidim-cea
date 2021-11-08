# frozen_string_literal: true

class DeeplTranslator
  attr_reader :text, :source_locale, :target_locale, :resource, :field_name

  def initialize(resource, field_name, text, target_locale, source_locale)
    @resource = resource
    @field_name = field_name
    @text = text
    @target_locale = target_locale
    @source_locale = source_locale
  end

  def translate
    translation = deepl_translation text, source_locale, target_locale
    return if translation.blank?

    Decidim::MachineTranslationSaveJob.perform_later(
      resource,
      field_name,
      target_locale,
      translation.text
    )
  end

  def deepl_translation(text, source_locale, target_locale)
    DeepL.translate text, source_locale, target_locale
  rescue DeepL::Exceptions::RequestError => e
    Rails.logger.debug "--- An error occurred on Deepl translation ---"
    Rails.logger.debug "Deepl HTTP response code: #{e.response.code}"
    Rails.logger.debug "Deepl HTTP response body: #{e.response.body}"
    Rails.logger.debug "Deepl HTTP Request body: #{e.request.body}"
    Rails.logger.debug "---------------------------------------------"
    ""
  end
end
